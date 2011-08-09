
#import "OCLDirectoryParser.h"
#import "OCLFileIterator.h"
#import "OCLTokeniser.h"
#import "OCLToken.h"

@interface OCLDirectoryParser (Private)

- (NSArray *)parseFile:(NSString *)filePath;

@end

@implementation OCLDirectoryParser

#pragma mark -
#pragma mark Init

- (id)init {
    
    if ( (self = [super init]) ) {
        rules_ = [[[NSMutableArray alloc] init] retain];
    }
    
    return self;
    
}

- (void)dealloc {
    
    [rules_ release];
    
    [super dealloc];
    
}

#pragma mark -
#pragma mark Methods

- (NSArray *)parseDirectory:(NSString *)dirPath {
    
    NSMutableArray *errors = [[[NSMutableArray alloc] init] autorelease];
    OCLFileIterator *iterator = [[[OCLFileIterator alloc] initWithPath:dirPath] autorelease];
    NSString *filePath = nil;
    
    while ( (filePath = [iterator next]) ) {
        NSArray *fileErrors = [self parseFile:filePath];
        [errors addObjectsFromArray:fileErrors];
    }
    
    return [NSArray arrayWithArray:errors];
    
}

- (void)addRule:(id<OCLRule>)rule {
    
    [rules_ addObject:rule];
    
}

#pragma mark -
#pragma mark Private

- (NSArray *)parseFile:(NSString *)filePath {
    
    OCLTokeniser *tokeniser = [[[OCLTokeniser alloc] initWithPath:filePath] autorelease];
    NSMutableArray *fileErrors = [[[NSMutableArray alloc] init] autorelease];
    NSArray *tokens = [tokeniser getAllTokens];
    
    for ( OCLToken *token in tokens ) {
        // @todo dispatch tokens to parser rules
    }
    
    return fileErrors;

}

@end
