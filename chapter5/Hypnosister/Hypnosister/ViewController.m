//
//  ViewController.m
//  Hypnosister
//
//  Created by deokhee park on 2022/12/07.
//

#import "ViewController.h"
#import "HypnosisView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initFirstView];
//    [self initSecondView];
    [self initHypnosisView];
}

- (void)initFirstView {
    CGRect firstFrame = CGRectMake(160, 240, 100, 50);
    HypnosisView *firstView = [[HypnosisView alloc] initWithFrame:firstFrame];
    firstView.backgroundColor = [UIColor redColor];
    [self.view addSubview:firstView];
}

- (void)initSecondView {
    CGRect secondFrame = CGRectMake(20,30,50,50);
    
    HypnosisView *secondView = [[HypnosisView alloc] initWithFrame:secondFrame];
    secondView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:secondView];
}

- (void)initHypnosisView {
    //firstView의 frame을 self.view의 bounds로 개싱하는 코드를 추가하기위 주석처리
    //CGRect firstFrame = CGRectMake(160, 240, 100, 50);
//    CGRect firstFrame = self.view.bounds;
//    HypnosisView *firstView = [[HypnosisView alloc] initWithFrame:firstFrame];
////    firstView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:firstView];
//    CGRect secondFrame = CGRectMake(20,0,50,50);
    
    /**
     HypnosisView를 화면 크기로 다시 줄이고 또 다른 화면 크기를 HypnosisView를 uiscrollview의 하위뷰로 추가한다.
     스크롤뷰의 contentSize를 높이는 같고 너비는 화면 크기의 두 배로 설정함.
     */
    //프레임들을 위한 CGRect를 만든다.
    CGRect screenRect = self.view.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2.0;
    //bigRect.size.height *= 2.0;
    
    //화면 크기의 스크롤뷰를 만들고 뷰에 추가한다.
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    //화면이 멈췄을 때 뷰들 중 하나의 뷰 포트만을 보려면 스크롤뷰의 페이징 옵션을 켠다.
    //scrollView.pagingEnabled = true;
    [self.view addSubview:scrollView];
    
//    //대형의 최면뷰를 만들고 스크롤뷰에 추가한다.
//    HypnosisView *hypnosisView = [[HypnosisView alloc] initWithFrame:bigRect];
    //화면 크기의 최면뷰를 만들고 스크롤뷰에 추가함
    HypnosisView *hypnosisView = [[HypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview: hypnosisView];
    //화면 크기의 두번째 최면뷰를 오른쪽 화면밖에 추가함.
    screenRect.origin.x = screenRect.origin.x + screenRect.size.width;
    HypnosisView *anotherView = [[HypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:anotherView];
    //스크롤 뷰에 콘덴츠 영역의 크기를 설정함.
    scrollView.contentSize = bigRect.size;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}


@end
