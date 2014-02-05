#import "PlumberConnection.h"

@implementation PlumberConnection

- (instancetype)initWithFrom:(CGRect)from to:(CGRect)to path:(UIBezierPath *)path {
    self = [super init];
    if (self) {
        _from = from;
        _to = to;
        _path = path;
    }
    return self;
}

@end