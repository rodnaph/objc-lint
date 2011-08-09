
@protocol OCLRenderer <NSObject>

// render the specified errors, no output if no errors
- (void)renderErrors:(NSArray *)errors;

@end
