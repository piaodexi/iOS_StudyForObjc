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
    CGRect firstFrame = self.view.bounds;
    HypnosisView *firstView = [[HypnosisView alloc] initWithFrame:firstFrame];
//    firstView.backgroundColor = [UIColor redColor];
    [self.view addSubview:firstView];
    CGRect secondFrame = CGRectMake(20,0,50,50);
    
    HypnosisView *secondView = [[HypnosisView alloc] initWithFrame:secondFrame];
    secondView.backgroundColor = [UIColor blueColor];
    
    [firstView addSubview:secondView];
}


@end
