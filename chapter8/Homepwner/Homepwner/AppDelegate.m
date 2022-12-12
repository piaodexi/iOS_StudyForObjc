//
//  AppDelegate.m
//  Homepwner
//
//  Created by deokhee park on 2022/12/09.
//

#import "AppDelegate.h"
#import "ItemsViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //ItemsViewController를 만든다.
    ItemsViewController *ivc = [[ItemsViewController alloc] init];
    
    //ItemsViewController의 테이블뷰를 윈도우 계층구조상에 놓는다.
    self.window.rootViewController = ivc;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
