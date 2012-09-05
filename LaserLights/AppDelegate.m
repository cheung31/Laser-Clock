#import "AppDelegate.h"
#import "LightsView.h"
#import "LightsViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = [LightsViewController new];
    //self.window.rootViewController.view = [[LightsView alloc] initWithFrame:self.window.bounds];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)applicationDidBecomeActive:(UIApplication *)application {   
    self.window.rootViewController.view = [[LightsView alloc] initWithFrame:self.window.bounds];
    [((LightsView*)self.window.rootViewController.view) makeClock];
    [((LightsView*)self.window.rootViewController.view) updateTime];
}

@end
