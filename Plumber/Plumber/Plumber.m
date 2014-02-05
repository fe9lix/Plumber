#import "Plumber.h"
#import "PlumberConnection.h"

@implementation Plumber

// Ported from: https://github.com/DmitryBaranovskiy/raphaeljs.com/blob/master/graffle.js
- (PlumberConnection *)connectFrom:(CGRect)from to:(CGRect)to {
    
    NSArray *p = @[[NSValue valueWithCGPoint:CGPointMake(from.origin.x + from.size.width / 2, from.origin.y - 1)],
                   [NSValue valueWithCGPoint:CGPointMake(from.origin.x + from.size.width / 2, from.origin.y + from.size.height + 1)],
                   [NSValue valueWithCGPoint:CGPointMake(from.origin.x - 1, from.origin.y + from.size.height / 2)],
                   [NSValue valueWithCGPoint:CGPointMake(from.origin.x + from.size.width + 1, from.origin.y + from.size.height / 2)],
                   [NSValue valueWithCGPoint:CGPointMake(to.origin.x + to.size.width / 2, to.origin.y - 1)],
                   [NSValue valueWithCGPoint:CGPointMake(to.origin.x + to.size.width / 2, to.origin.y + to.size.height + 1)],
                   [NSValue valueWithCGPoint:CGPointMake(to.origin.x - 1, to.origin.y + to.size.height / 2)],
                   [NSValue valueWithCGPoint:CGPointMake(to.origin.x + to.size.width + 1, to.origin.y + to.size.height / 2)]];
    
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    NSMutableArray *dis = [NSMutableArray array];
    CGFloat dx;
    CGFloat dy;
    
    for (NSInteger i = 0; i < 4; i++) {
        for (NSInteger j = 4; j < 8; j++) {
            CGPoint pi = ((NSValue *)p[i]).CGPointValue;
            CGPoint pj = ((NSValue *)p[j]).CGPointValue;
            dx = fabsf(pi.x - pj.x);
            dy = fabsf(pi.y - pj.y);
            if ((i == j - 4) || (((i != 3 && j != 6) || pi.x < pj.x) && ((i != 2 && j != 7) || pi.x > pj.x) && ((i != 0 && j != 5) || pi.y > pj.y) && ((i != 1 && j != 4) || pi.y < pj.y))) {
                [dis addObject:@(dx + dy)];
                d[[dis lastObject]] = @[@(i), @(j)];
            }
        }
    }
    
    NSArray *res;
    if ([dis count] == 0) {
        res = @[@0, @4];
    } else {
        res = d[[dis valueForKeyPath:@"@min.floatValue"]];
    }
    
    NSInteger res0 = [res[0] integerValue];
    NSInteger res1 = [res[1] integerValue];
    CGPoint pRes0 = ((NSValue *)p[res0]).CGPointValue;
    CGPoint pRes1 = ((NSValue *)p[res1]).CGPointValue;
    
    CGPoint p1 = CGPointMake(pRes0.x, pRes0.y);
    CGPoint p4 = CGPointMake(pRes1.x, pRes1.y);
    
    dx = fmaxf(fabsf(p1.x - p4.x) / 2, 10);
    dy = fmaxf(fabsf(p1.y - p4.y) / 2, 10);
    
    CGFloat p2x = [@[@(p1.x), @(p1.x), @(p1.x - dx), @(p1.x + dx)][res0] floatValue];
    CGFloat p2y = [@[@(p1.y - dy), @(p1.y + dy), @(p1.y), @(p1.y)][res0] floatValue];
    CGPoint p2 = CGPointMake([self round:p2x], [self round:p2y]);
    
    CGFloat p3x = [@[@0, @0, @0, @0, @(p4.x), @(p4.x), @(p4.x - dx), @(p4.x + dx)][res1] floatValue];
    CGFloat p3y = [@[@0, @0, @0, @0, @(p1.y + dy), @(p1.y - dy), @(p4.y), @(p4.y)][res1] floatValue];
    CGPoint p3 = CGPointMake([self round:p3x], [self round:p3y]);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake([self round:p1.x], [self round:p1.y])];
    [path addCurveToPoint:p4 controlPoint1:p2 controlPoint2:p3];
    
    return [[PlumberConnection alloc] initWithFrom:from
                                                to:to
                                              path:path];
}

- (CGFloat)round:(CGFloat)val {
    return floorf(val * 1000 + 0.5) / 1000;
}

@end