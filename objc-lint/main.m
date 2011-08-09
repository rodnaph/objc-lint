
#import "OCLFileIterator.h"
#import "OCLDirectoryParser.h"
#import "OCLConsoleRenderer.h"
#import "OCLRuleUnderscoredIvars.h"

int main ( int argc, const char *argv[] ) {

    if ( argc < 2 ) {
        NSLog( @"Usage: objc-ling /path/to/src" );
        exit( 1 );
    }

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSString *srcPath = [[[NSString alloc] initWithCString:argv[1] encoding:NSUTF8StringEncoding] autorelease];
    OCLDirectoryParser *parser = [[[OCLDirectoryParser alloc] init] autorelease];
    OCLConsoleRenderer *renderer = [[[OCLConsoleRenderer alloc] init] autorelease];
    NSArray *errors = [parser parseDirectory:srcPath];
    
    [parser addRule:[[[OCLRuleUnderscoredIvars alloc] init] autorelease]];
    [renderer renderErrors:errors];
    [pool drain];
    
    return 0;
    
}
