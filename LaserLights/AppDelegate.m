#import "AppDelegate.h"
#import "LightsView.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = [UIViewController new];
    self.window.rootViewController.view = [[LightsView alloc] initWithFrame:self.window.bounds];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
