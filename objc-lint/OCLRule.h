
@protocol OCLRule <NSObject>

// return array of OCLError objects, or nil if none
- (NSArray *)handleToken:(NSArray *)tokens atIndex:(int)index;

@end
