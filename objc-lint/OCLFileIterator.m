
#import "OCLFileIterator.h"

@interface OCLFileIterator (Private)

- (void)loadFilePaths;

@end

@implementation OCLFileIterator

@synthesize rootPath=rootPath_,
            filePaths=filePaths_;

#pragma mark -
#pragma mark Init

- (void)dealloc {
    
    [rootPath_ release];
    [filePaths_ release];
    
    [super dealloc];
    
}

- (id)initWithPath:(NSString *)rootPath {
    
    if ( (self = [super init]) ) {
        self.rootPath = rootPath;
        [self loadFilePaths];
        currentPathIndex = 0;
    }
    
    return self;
    
}

#pragma mark -
#pragma mark Methods

- (NSString *)next {

    return currentPathIndex < [filePaths_ count]
        ? [NSString stringWithFormat:@"%@%@", rootPath_, [filePaths_ objectAtIndex:currentPathIndex++]]
        : nil;

}

#pragma mark -
#pragma mark Private

- (void)loadFilePaths {

    NSMutableArray *filePaths = [[NSMutableArray alloc] init];
    NSArray *allPaths = [[[NSFileManager defaultManager] enumeratorAtPath:rootPath_] allObjects];
    
    for ( NSString *path in allPaths ) {
        NSString *extension = [path substringFromIndex:[path length] - 2];
        if ( [extension isEqualToString:@".h"] || [extension isEqualToString:@".m"] ) {
            [filePaths addObject:path];
        }
    }
    
    self.filePaths = [NSArray arrayWithArray:filePaths];
    
    [filePaths release];
    
}


@end
