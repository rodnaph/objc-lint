
@interface OCLFileIterator : NSObject {
    int currentPathIndex;
}

@property (nonatomic, retain) NSString *rootPath;
@property (nonatomic, retain) NSArray *filePaths;

// initialise the iterator with the path to a root folder
- (id)initWithPath:(NSString *)rootPath;

// returns the next file path, or nil if no more
- (NSString *)next;

@end
