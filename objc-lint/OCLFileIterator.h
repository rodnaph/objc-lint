
@interface OCLFileIterator : NSObject {
    int currentPathIndex;
}

@property (nonatomic, retain) NSString *path;
@property (nonatomic, retain) NSArray *paths;

// initialise the iterator with the path to a root folder
- (id)initWithPath:(NSString *)path;

// returns the next file path, or nil if no more
- (NSString *)next;

@end
