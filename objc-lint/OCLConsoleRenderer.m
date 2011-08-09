
#import "OCLConsoleRenderer.h"

@implementation OCLConsoleRenderer

- (void)renderErrors:(NSArray *)errors {
    
    NSLog( @"Renderer..." );
    
    if ( [errors count] > 0 ) {
        NSLog( @"Errors..." );
    }
    
}

@end
