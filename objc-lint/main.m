
#import "OCLFileIterator.h"
#import "OCLTokeniser.h"

int main ( int argc, const char * argv[] ) {

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    OCLFileIterator *iterator = [[[OCLFileIterator alloc] initWithPath:@"/Users/rod/Code/objc-lint/objc-lint/"] autorelease];
    NSString *path;

    NSLog( @"Starting..." );
    
    while ( (path = [iterator next]) != nil ) {
        
        OCLTokeniser *tokeniser = [[OCLTokeniser alloc] initWithPath:path];
        OCLToken *token;
        
        NSLog( @"File: '%@'", path );
        
        while ( (token = [tokeniser next]) != nil ) {
            NSLog( @"  %@", token.content );
        }
        
        NSLog( @" " );
        
    }
    
    NSLog( @"Done!" );
    
    [pool drain];
    
    return 0;
    
}
