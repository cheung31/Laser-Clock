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
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {    
    self.window.rootViewController = [LightsViewController new];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    self.window.rootViewController = nil;
}

@end
