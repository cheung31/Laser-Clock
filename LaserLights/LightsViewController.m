
#import "LightsViewController.h"
#import "LightsView.h"
#import "LaserHand.h"
#import "ClockLayer.h"

@interface LightsViewController ()

@end

@implementation LightsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    self.view.hidden = YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    CGPoint newCenter;
    if (UIInterfaceOrientationIsPortrait(fromInterfaceOrientation)) {
        newCenter = CGPointMake((self.view.bounds.size.width / 4), (self.view.bounds.size.height / 2));
    } else {
        newCenter = self.view.center;
    }
    [((LightsView*)self.view) setCenter:newCenter];
    self.view.hidden = NO;

}

@end
