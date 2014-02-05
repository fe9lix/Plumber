#import <Foundation/Foundation.h>

@interface PlumberConnection : NSObject

@property (readonly, nonatomic) CGRect from;
@property (readonly, nonatomic) CGRect to;
@property (readonly, strong, nonatomic) UIBezierPath *path;

- (instancetype)initWithFrom:(CGRect)from to:(CGRect)to path:(UIBezierPath *)path;

@end