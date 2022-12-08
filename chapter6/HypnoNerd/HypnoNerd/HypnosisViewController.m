//
//  HypnosisViewController.m
//  HypnoNerd
//
//  Created by deokhee park on 2022/12/08.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"
@interface HypnosisViewController ()

@end

@implementation HypnosisViewController

//프로그래밍으로 뷰 만들기 (xib가 없을땐 loadview에서 작성한다) 
- (void)loadView {
    HypnosisView *backgroundView = [[HypnosisView alloc] init];
    
    self.view = backgroundView;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil) {
        //탭바 항목의 라벨을 설정한다.
        self.tabBarItem.title = @"Hypnotize";
        //파일로부터 uiimage를 만든다.
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        
        //탭바 항목에 이 이미지를 넣는다.
        self.tabBarItem.image = i;
    }
    return self;
}
- (void)viewDidLoad {
    //항상 상위 클래스의 viewDidLoad를 호출한다.
    [super viewDidLoad];
    NSLog(@"뷰 디드로드");
}

@end
