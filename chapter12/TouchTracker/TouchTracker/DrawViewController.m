//
//  DrawViewController.m
//  TouchTracker
//
//  Created by deokhee park on 2022/12/12.
//

#import "DrawViewController.h"
#import "DrawView.h"

@implementation DrawViewController
//DrawView의 인스턴스를 DrawViewController의 뷰로 설정하기 위해 loadView 재정의를 한다.
- (void)loadView
{
    self.view = [[DrawView alloc] initWithFrame:CGRectZero];
}

@end
