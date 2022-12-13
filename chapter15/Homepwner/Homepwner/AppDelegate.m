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
    
    //itemsViewController만을 포함한 UINavigationController 인스턴스를 만든다.
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:ivc];
    //ItemsViewController의 테이블뷰를 윈도우 계층구조상에 놓는다.
    //self.window.rootViewController = ivc;
    //윈도우 계층구조에 내비게이션 컨트롤러의 뷰를 놓는다.
    self.window.rootViewController = navc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
