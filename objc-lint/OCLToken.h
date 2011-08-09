
#define OCL_TOKEN_NONE              0

// string tokens
#define OCL_TOKEN_MODIFIER          1
#define OCL_TOKEN_LITERAL           2
#define OCL_TOKEN_IDENTIFIER        3
#define OCL_TOKEN_PREPROC           4
#define OCL_TOKEN_NUMBER            5
#define OCL_TOKEN_COMMENT_SINGLE    6
#define OCL_TOKEN_COMMENT_MULTI     7

// ascii tokens
#define OCL_TOKEN_TAB               9
#define OCL_TOKEN_NEWLINE           10
#define OCL_TOKEN_SPACE             32
#define OCL_TOKEN_BANG              33
#define OCL_TOKEN_MODULUS           37
#define OCL_TOKEN_AMPERSAND         38
#define OCL_TOKEN_PAREN_OPEN        40
#define OCL_TOKEN_PAREN_CLOSE       41
#define OCL_TOKEN_STAR              42
#define OCL_TOKEN_PLUS              43
#define OCL_TOKEN_COMMER            44
#define OCL_TOKEN_MINUS             45
#define OCL_TOKEN_DOT               46
#define OCL_TOKEN_DIVIDE            47
#define OCL_TOKEN_COLON             58
#define OCL_TOKEN_SEMICOLON         59
#define OCL_TOKEN_ANGLE_OPEN        60
#define OCL_TOKEN_EQUALS            61
#define OCL_TOKEN_ANGLE_CLOSE       62
#define OCL_TOKEN_QUESTION          63
#define OCL_TOKEN_BRACKET_OPEN      91
#define OCL_TOKEN_BRACKET_CLOSE     93
#define OCL_TOKEN_CARET             94
#define OCL_TOKEN_BRACE_OPEN        123
#define OCL_TOKEN_PIPE              124
#define OCL_TOKEN_BRACE_CLOSE       125

@interface OCLToken : NSObject {}

@property (nonatomic, assign) int type;
@property (nonatomic, retain) NSString *content;

- (id)initWithToken:(int)type;
- (id)initWithToken:(int)type andContent:(NSString *)content;

- (void)append:(int)chr;

@end
