//
//  DrawView.m
//  TouchTracker
//
//  Created by deokhee park on 2022/12/12.
//
/**
이미 그린 선과 현재 그리고 있는 선 모두를 관리해야한다. 클래스 인터페이스에 두 가지 상태의 선을 각각 가지는 두 개의 인스턴스 변수를 만든다.
 */
#import "DrawView.h"
#import "Line.h"

@interface DrawView ()

//@property (nonatomic, strong) Line *currentLine;
@property (nonatomic, strong) NSMutableDictionary *lineInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;

@end
@implementation DrawView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:(CGRect)frame];
    if (self) {
        self.lineInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    return self;
}
- (void)strokeLine: (Line *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}
- (void)drawRect: (CGRect) rect
{
    // 완성된 선은 검은 색으로 그린다.
    [[UIColor blackColor] set];
    for (Line *line in self.finishedLines) {
        [self strokeLine:line];
    }
    
    [[UIColor redColor] set];
    for (NSValue *key in self.lineInProgress) {
        [self strokeLine:self.lineInProgress[key]];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //이벤트의 순서를 확인하기 위해 로그문을 넣는다.
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        
        Line *line = [[Line alloc] init];
        line.begin = location;
        line.end = location;
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.lineInProgress[key] = line;
    }

    
    [self setNeedsDisplay];
}
//currentLine의 end를 갱신
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        Line *line = self.lineInProgress[key];
        line.end = [t locationInView:self];
    
    }
    [self setNeedsDisplay];

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //이벤트의 순서를 확인하기 위해 로그문을 넣는다.
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        Line *line = self.lineInProgress[key];
        [self.finishedLines addObject:line];
        [self.lineInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //이벤트의 순서를 확인하기 위해 로그문을 넣는다.
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.lineInProgress removeObjectForKey:key];
    }

    
    [self setNeedsDisplay];
}

@end
