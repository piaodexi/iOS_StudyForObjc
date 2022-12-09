//
//  AppDelegate.m
//  HypnoNerd
//
//  Created by deokhee park on 2022/12/08.
//

#import "AppDelegate.h"
#import "HypnosisViewController.h"
#import "ReminderViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    
    HypnosisViewController *hvc = [[HypnosisViewController alloc] init];
    
    //앱 번들을 나타내는 객체의 포인터를 가져온다
    NSBundle *appBundle = [NSBundle mainBundle];
    
    //appBudle에서 ReminderViewcontroller.xib 파일을 검색한다.
    ReminderViewController *rvc = [[ReminderViewController alloc] initWithNibName:@"ReminderViewController" bundle:appBundle];
    
    //UITabBarController
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[hvc, rvc];
    tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    
    //self.window.rootViewController = hvc;
    //self.window.rootViewController = rvc;
    self.window.rootViewController = tabBarController;
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}
/**
 rootViewController의 뷰는 프로그램 시작 시 나타난다. 그래서 윈도우는 뷰 컨트롤러를 rootViewController로 설정할 때 그 뷰를 요청한다.
 */


@end
