
#import "OCLRule.h"

@interface OCLDirectoryParser : NSObject {
    NSMutableArray *rules_;
}

// add a validation rule to the parser
- (void)addRule:(id <OCLRule>)rule;

// parse all the source files in the directory and return any errors
- (NSArray *)parseDirectory:(NSString *)dirPath;

@end
