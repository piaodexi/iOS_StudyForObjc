//
//  AppDelegate.m
//  TouchTracker
//
//  Created by deokhee park on 2022/12/12.
//

#import "AppDelegate.h"
#import "DrawViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    DrawViewController *dvc = [[DrawViewController alloc] init];
    self.window.rootViewController = dvc;
    
    self.window.backgroundColor =[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
