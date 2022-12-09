//
//  HypnosisViewController.m
//  HypnoNerd
//
//  Created by deokhee park on 2022/12/08.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"
@interface HypnosisViewController () <UITextFieldDelegate>

@end

@implementation HypnosisViewController

//프로그래밍으로 뷰 만들기 (xib가 없을땐 loadview에서 작성한다) 
- (void)loadView {
    CGRect frame = [UIScreen mainScreen].bounds;
    HypnosisView *backgroundView = [[HypnosisView alloc] initWithFrame:frame];
    
    CGRect textFieldRect = CGRectMake(40,70,240,30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    //좀 더 보기 편하게 텍스트 필드의 테두리 스타일을 설정한다.
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    textField.delegate = self;
    [backgroundView addSubview:textField];
    //텍스트필드의 플레이스홀더 텍스트를 설정
    textField.placeholder = @"입력해보세요";
    //키보드의 리턴키 타입수정
    /**
     리턴키 타입을 변경하는 것은 리턴키의 기능에 영향이 없다. 리턴키는 자동으로 뭔가를 하지않는다. 리턴키의 기능은 스스로 구현해야만한다. 
     */
    //textField.returnKeyType = UIReturnKeyDone;
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
//화면의 임의의 위치 20곳에 문자열을 그리는 새 메
-(void)drawHypnoticMessage: (NSString *)message {
    for (int i = 0; i < 20; i++) {
        UILabel *messageLabel = [[UILabel alloc] init];
        
        //라벨의 색과 텍스트를 설정한다.
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        
        // 이 메소드는 라벨의 크기를 표시할 텍스트에 적합하게 조절한다.
        [messageLabel sizeToFit];
        
        //최면 뷰의 너비 내에서 적당한 임의의값 x를 가져온다.
        int width = (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        
        int x = arc4random() % width;
        
        //최면뷰의 높이 내에서 적당한 임의의 값 y를 가져온다.
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        
        int y = arc4random() % height;
        
        //라벨의 frame을 갱신한다.
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        //계층 구조에 라벨 추가 한다
        [self.view addSubview:messageLabel];
        
        //각 라벨의 중심을 각 방향에서 25 포인트 기울여 수평과 수직 모션 효과를 추가함.
        //TODO 모션 적용안되는듯 보임 기기에서 추후 고칠것
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"check");
    [self drawHypnoticMessage:textField.text];
    
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}
@end
