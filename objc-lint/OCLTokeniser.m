
#import "OCLTokeniser.h"
#import "OCLToken.h"

@interface OCLTokeniser (Private)

// read a single character from the file (return any putBack)
- (int)read;

// put a character back to be read again
- (void)putBack:(int)chr;

- (BOOL)isAlpha:(int)chr;

- (BOOL)isAlphaNumeric:(int)chr;

- (BOOL)isNumeric:(int)chr;

@end

@implementation OCLTokeniser

@synthesize path=path_;

static const int asciiTokens[26] = {
    OCL_TOKEN_TAB,
    OCL_TOKEN_NEWLINE,
    OCL_TOKEN_SPACE,
    OCL_TOKEN_MODULUS,
    OCL_TOKEN_PAREN_OPEN,
    OCL_TOKEN_PAREN_CLOSE,
    OCL_TOKEN_STAR,
    OCL_TOKEN_PLUS,
    OCL_TOKEN_COMMER,
    OCL_TOKEN_MINUS,
    OCL_TOKEN_DOT,
    OCL_TOKEN_DIVIDE,
    OCL_TOKEN_COLON,
    OCL_TOKEN_SEMICOLON,
    OCL_TOKEN_BRACKET_OPEN,
    OCL_TOKEN_BRACKET_CLOSE,
    OCL_TOKEN_BRACE_OPEN,
    OCL_TOKEN_BRACE_CLOSE,
    OCL_TOKEN_ANGLE_OPEN,
    OCL_TOKEN_ANGLE_CLOSE,
    OCL_TOKEN_EQUALS,
    OCL_TOKEN_CARET,
    OCL_TOKEN_QUESTION,
    OCL_TOKEN_BANG,
    OCL_TOKEN_AMPERSAND,
    OCL_TOKEN_PIPE
};

#pragma mark -
#pragma mark Init

- (id)initWithPath:(NSString *)path {
    
    if ( (self = [super init]) ) {
        
        self.path = path;
        
        fileContent_ = [[NSString alloc] initWithContentsOfFile:path_ encoding:NSUTF8StringEncoding error:nil];
        currentPos_ = 0;
        
    }
    
    return self;
    
}

- (void)dealloc {
    
    [path_ release];
    [fileContent_ release];
    
    [super dealloc];
    
}

#pragma mark -
#pragma mark Methods

- (NSArray *)getAllTokens {
    
    NSMutableArray *tokens = [[[NSMutableArray alloc] init] autorelease];
    OCLToken *token;
    
    while ( (token = [self next]) != nil ) {
        [tokens addObject:token];
    }
    
    return [NSArray arrayWithArray:tokens];
    
}

- (OCLToken *)next {

    OCLToken *currentToken_ = nil;
    int tokenCount = sizeof(asciiTokens) / sizeof(int);
    int prevChr = -1;
    
    while ( currentPos_ < [fileContent_ length] ) {
        
        int chr = [self read];

        if ( currentToken_.type == OCL_TOKEN_PREPROC ) {
            if ( chr == OCL_CHR_NEWLINE ) {
                return currentToken_;
            }
            [currentToken_ append:chr];
        }
        
        else if ( currentToken_.type == OCL_TOKEN_MODIFIER ) {
            
            if ( chr == OCL_CHR_QUOTE ) {
                currentToken_.type = OCL_TOKEN_LITERAL;
                currentToken_.content = @"@\"";
            }
            
            else {
                if ( [self isAlpha:chr] ) {
                    [currentToken_ append:chr];
                }
                else {
                    [self putBack:chr];
                    return currentToken_;
                }
            }
            
        }
        
        else if ( currentToken_.type == OCL_TOKEN_IDENTIFIER ) {
            if ( [self isAlphaNumeric:chr] ) {
                [currentToken_ append:chr];
            }
            else {
                [self putBack:chr];
                return currentToken_;
            }
        }
        
        else if ( currentToken_.type == OCL_TOKEN_LITERAL ) {
            [currentToken_ append:chr];
            if ( chr == OCL_CHR_QUOTE && prevChr != OCL_CHR_BACKSLASH ) {
                return currentToken_;
            }
        }
        
        else if ( currentToken_.type == OCL_TOKEN_COMMENT_SINGLE ) {
            if ( chr == OCL_CHR_NEWLINE ) {
                return currentToken_;
            }
            [currentToken_ append:chr];
        }
        
        else if ( currentToken_.type == OCL_TOKEN_COMMENT_MULTI ) {
            if ( chr == OCL_CHR_STAR ) {
                int nextChr = [self read];
                if ( nextChr == OCL_CHR_SLASH ) {
                    return currentToken_;
                }
                [currentToken_ append:chr];
                [currentToken_ append:nextChr];
                [self putBack:nextChr];
            }
            else {
                [currentToken_ append:chr];
            }
        }
        
        else if ( chr == OCL_CHR_SLASH ) {
            int nextChr = [self read];
            if ( nextChr == OCL_CHR_SLASH ) {
                currentToken_ = [[[OCLToken alloc] initWithToken:OCL_TOKEN_COMMENT_SINGLE andContent:@"//"] autorelease];
            }
            else if ( nextChr == OCL_CHR_STAR ) {
                currentToken_ = [[[OCLToken alloc] initWithToken:OCL_TOKEN_COMMENT_MULTI andContent:@"/*"] autorelease];
            }
            else {
                [self putBack:nextChr];
            }
        }
        
        else if ( chr == OCL_CHR_HASH ) {
            currentToken_ = [[[OCLToken alloc] initWithToken:OCL_TOKEN_PREPROC andContent:@"#"] autorelease];
        }
        
        else if ( chr == OCL_CHR_AT ) {
            currentToken_ = [[[OCLToken alloc] initWithToken:OCL_TOKEN_MODIFIER andContent:@"@"] autorelease];
        }
        
        else if ( chr == OCL_CHR_QUOTE ) {
            currentToken_ = [[[OCLToken alloc] initWithToken:OCL_TOKEN_LITERAL andContent:@"\""] autorelease];
        }
        
        else if ( [self isAlpha:chr] ) {
            currentToken_ = [[[OCLToken alloc] initWithToken:OCL_TOKEN_IDENTIFIER andContent:[NSString stringWithFormat:@"%c", chr]] autorelease];
        }
        
        else if ( [self isNumeric:chr] ) {
            currentToken_ = [[[OCLToken alloc] initWithToken:OCL_TOKEN_NUMBER andContent:[NSString stringWithFormat:@"%c", chr]] autorelease];
        }
        
        else {
        
            for ( int i=0; i<tokenCount; i++ ) {
                int type = asciiTokens[ i ];
                if ( chr == type ) {
                    return [[[OCLToken alloc] initWithToken:chr] autorelease];
                }
            }
            
            NSLog( @"UNKNOWN: %d", chr );
            exit( 1 );
            
        }
        
        prevChr = chr;

    }
    
    return nil;
    
}

- (int)read {
    
    return [fileContent_ characterAtIndex:currentPos_++];
    
}

- (void)putBack:(int)chr {
    
    if ( currentPos_ > 0 ) {
        currentPos_--;
    }
    
}

- (BOOL)isAlpha:(int)chr {
    
    return chr == 95 || (chr > 64 && chr < 91) || (chr > 96 && chr < 123);
    
}
                  
- (BOOL)isAlphaNumeric:(int)chr {
    
    return [self isAlpha:chr] || [self isNumeric:chr];
    
}

- (BOOL)isNumeric:(int)chr {
    
    return (chr > 47 && chr < 58);
    
}

@end
