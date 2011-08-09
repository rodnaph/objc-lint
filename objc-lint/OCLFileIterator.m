
#import "OCLFileIterator.h"

@interface OCLFileIterator (Private)

- (void)loadPaths;

@end

@implementation OCLFileIterator

@synthesize path=path_,
            paths=paths_;

#pragma mark -
#pragma mark Init

- (void)dealloc {
    
    [path_ release];
    [paths_ release];
    
    [super dealloc];
    
}

- (id)initWithPath:(NSString *)path {
    
    if ( (self = [super init]) ) {
        self.path = path;
        [self loadPaths];
        currentPathIndex = 0;
    }
    
    return self;
    
}

#pragma mark -
#pragma mark Methods

- (NSString *)next {

    return currentPathIndex < [paths_ count]
        ? [NSString stringWithFormat:@"%@%@", path_, [paths_ objectAtIndex:currentPathIndex++]]
        : nil;

}

#pragma mark -
#pragma mark Private

- (void)loadPaths {

    NSMutableArray *filePaths = [[NSMutableArray alloc] init];
    NSArray *allPaths = [[[NSFileManager defaultManager] enumeratorAtPath:path_] allObjects];
    
    for ( NSString *path in allPaths ) {
        NSString *extension = [path substringFromIndex:[path length] - 2];
        if ( [extension isEqualToString:@".h"] || [extension isEqualToString:@".m"] ) {
            [filePaths addObject:path];
        }
    }
    
    self.paths = [NSArray arrayWithArray:filePaths];
    
    [filePaths release];
    
}


@end
