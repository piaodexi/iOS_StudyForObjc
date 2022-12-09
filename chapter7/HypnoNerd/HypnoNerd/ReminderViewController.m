//
//  ReminderViewController.m
//  HypnoNerd
//
//  Created by deokhee park on 2022/12/08.
//

#import "ReminderViewController.h"

@interface ReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@end

@implementation ReminderViewController

//인터페이스빌더 ..xib 파일을 사용하여 뷰만들기 
- (void)viewDidLoad {
    //항상 상위 클래스의 viewDidLoad를 호출한다.
    [super viewDidLoad];
    NSLog(@"뷰 디드로드");
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil) {
        //탭바 항목의 라벨을 설정한다.
        self.tabBarItem.title = @"Reminder";
        //파일로부터 uiimage를 만든다.
        UIImage *i = [UIImage imageNamed:@"Time.png"];
        
        //탭바 항목에 이 이미지를 넣는다.
        self.tabBarItem.image = i;
    }
    return self;
}
- (IBAction)addReminder:(id)sender {
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
    
    //로컬 노티피게이션 추가하기 10이후에 deprecated 되었음.
    //TODO 10이후 비슷한 함수 찾아서 적용해보기
//    UILocalNotification *note = [[UILocalNotification alloc] init];
//    note.alertBody = @"나다...데시다..";
//    note.fireDate = date;
//    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //사용자들이 최소한 60초 이후의 미래만을 선택할 수 있도록 날짜 피커 설정 
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
    NSLog(@"뷰가 나타난다. ");
}


@end
