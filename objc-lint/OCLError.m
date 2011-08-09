
#import "OCLError.h"

@implementation OCLError

@synthesize description=description_;

#pragma mark -
#pragma mark Init

- (void)dealloc {
    
    [description_ release];
    
    [super dealloc];
    
}

@end
