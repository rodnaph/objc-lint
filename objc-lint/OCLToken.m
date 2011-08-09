
#import "OCLToken.h"

@implementation OCLToken

@synthesize type=type_,
            content=content_;

#pragma mark -
#pragma mark Init

- (id)initWithToken:(int)type {
    
    if ( (self = [super init]) ) {
        self.type = type;
        self.content = [NSString stringWithFormat:@"%c", type];
    }
    
    return self;
    
}

- (id)initWithToken:(int)type andContent:(NSString *)content {
    
    if ( (self = [super init]) ) {
        self.type = type;
        self.content = content;
    }
    
    return self;
    
}

- (void)dealloc {
    
    [content_ release];
    
    [super dealloc];
    
}

#pragma mark -
#pragma mark Methods

- (void)append:(int)chr {
    
    self.content = [NSString stringWithFormat:@"%@%c", content_, chr];
    
}

@end
