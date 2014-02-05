#import "PlumberViewController.h"
#import "PlumberControl.h"

@interface PlumberViewController ()

@property (weak, nonatomic) IBOutlet PlumberControl *plumberControl;

@end

@implementation PlumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.plumberControl setNeedsDisplay];
}

@end
