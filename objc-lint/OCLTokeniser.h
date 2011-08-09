
#import "OCLToken.h"

#define OCL_CHR_HASH                35
#define OCL_CHR_AT                  64
#define OCL_CHR_QUOTE               34
#define OCL_CHR_SLASH               47
#define OCL_CHR_STAR                42
#define OCL_CHR_NEWLINE             10
#define OCL_CHR_BACKSLASH           92

@interface OCLTokeniser : NSObject {
    NSString *fileContent_;
    int currentPos_;
}

@property (nonatomic, retain) NSString *path;

// initialise the tokeniser for the specified file
- (id)initWithPath:(NSString *)path;

// return the next token if there is one, or nil
- (OCLToken *)next;

// read configured file and return all tokens
- (NSArray *)getAllTokens;

@end
