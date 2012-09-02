
#import "LightsViewController.h"
#import "LightsView.h"
#import "LaserHand.h"

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
    [((LightsView*)self.view) updateTime];
}

-(void)viewDidAppear:(BOOL)animated {
    [((LightsView*)self.view) updateTime];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
