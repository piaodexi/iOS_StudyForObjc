//
//  HypnosisView.m
//  Hypnosister
//
//  Created by deokhee park on 2022/12/07.
//

#import "HypnosisView.h"

@implementation HypnosisView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        //모든 HypnosisView는 무색의 배경을 가진다.
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;
    
    //bounds 영역의 중심을 계산한다.
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
//    //원은 뷰에 들어갈 수 있는 것 중 가장 큰 크기가 된다.
//    float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
    
    //가장 큰 원은 뷰를 에워싼다.
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    //UIBezierPath 클래스의 인스턴스는 도형이나 원을 만들 수 있도록 선과 곡선들을 정의한다.
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
//    // 0부터 2 * PI의 라디안 각도와 radius값을 반지름으로 center를 중심점으로 한 호를 path에 추가한다.
//    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:true];
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius = currentRadius - 20) {
        //각 원을 그리기 전에 연필을 집어 올바른 지점으로 이동시킨다.
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:true];
    }
    
    // 선 두깨를 10포인트로 설정한다.
    path.lineWidth = 10;
    
    //선의 색상을 연회색으로 지정한다.
    [[UIColor lightGrayColor] setStroke];
    //선을 그린다!
    [path stroke];
}

@end
