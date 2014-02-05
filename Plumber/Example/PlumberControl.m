#import "PlumberControl.h"
#import "Plumber.h"
#import "PlumberConnection.h"

@interface PlumberControl ()

@property (strong, nonatomic) Plumber *plumber;
@property (strong, nonatomic) NSArray *connections;
@property (strong, nonatomic) CALayer *hitLayer;

@end

@implementation PlumberControl

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.backgroundColor = [UIColor blackColor];
    
    [self setupLayers];
    [self setupConnections];
}

- (void)setupLayers {
    CALayer *ellipseLayer = [CALayer layer];
    ellipseLayer.position = CGPointMake(50, 100);
    ellipseLayer.bounds = CGRectMake(0, 0, 75, 50);
    ellipseLayer.borderColor = [UIColor redColor].CGColor;
    ellipseLayer.borderWidth = 2.0f;
    ellipseLayer.cornerRadius = 25.0f;
    
    CALayer *roundRectLayer = [CALayer layer];
    roundRectLayer.position = CGPointMake(165, 100);
    roundRectLayer.bounds = CGRectMake(0, 0, 75, 50);
    roundRectLayer.borderColor = [UIColor orangeColor].CGColor;
    roundRectLayer.borderWidth = 2.0f;
    roundRectLayer.cornerRadius = 8.0f;
    
    CALayer *rectLayer = [CALayer layer];
    rectLayer.position = CGPointMake(165, 200);
    rectLayer.bounds = CGRectMake(0, 0, 75, 50);
    rectLayer.borderColor = [UIColor yellowColor].CGColor;
    rectLayer.borderWidth = 2.0f;
    
    CALayer *circleLayer = [CALayer layer];
    circleLayer.position = CGPointMake(280, 100);
    circleLayer.bounds = CGRectMake(0, 0, 50, 50);
    circleLayer.borderColor = [UIColor greenColor].CGColor;
    circleLayer.borderWidth = 2.0f;
    circleLayer.cornerRadius = 25.0f;
    
    [self.layer addSublayer:ellipseLayer];
    [self.layer addSublayer:roundRectLayer];
    [self.layer addSublayer:rectLayer];
    [self.layer addSublayer:circleLayer];
}

- (void)setupConnections {
    self.plumber = [[Plumber alloc] init];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [self updateConnections];
    [self drawConnections];
}

- (void)updateConnections {
    CALayer *ellipseLayer = self.layer.sublayers[0];
    CALayer *roundRectLayer = self.layer.sublayers[1];
    CALayer *rectLayer = self.layer.sublayers[2];
    CALayer *circleLayer = self.layer.sublayers[3];
    
    self.connections = @[[self.plumber connectFrom:ellipseLayer.frame to:roundRectLayer.frame],
                         [self.plumber connectFrom:roundRectLayer.frame to:rectLayer.frame],
                         [self.plumber connectFrom:roundRectLayer.frame to:circleLayer.frame]];
}

- (void)drawConnections {
    [[UIColor lightGrayColor] set];
    
    for (PlumberConnection *connection in self.connections) {
        UIBezierPath *path = connection.path;
        path.lineWidth = 4.0f;
        [path stroke];
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    
    self.hitLayer = [self.layer hitTest:[touch locationInView:self]];
    
    return self.hitLayer != self.layer;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.hitLayer.position = [touch locationInView:self];
    [CATransaction commit];
    
    [self setNeedsDisplay];
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
}

@end