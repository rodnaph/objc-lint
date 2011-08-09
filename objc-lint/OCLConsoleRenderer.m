
#import "OCLConsoleRenderer.h"
#import "OCLError.h"

@implementation OCLConsoleRenderer

- (void)renderErrors:(NSArray *)errors {
    
    if ( [errors count] > 0 ) {
        
        for ( OCLError *error in errors ) {
            NSLog( @"ERROR" );
        }
        
    }
    
}

@end
