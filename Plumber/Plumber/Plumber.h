#import <Foundation/Foundation.h>

@class PlumberConnection;

@interface Plumber : NSObject

- (PlumberConnection *)connectFrom:(CGRect)from to:(CGRect)to;

@end