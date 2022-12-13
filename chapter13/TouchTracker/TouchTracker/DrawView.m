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

@interface DrawView () <UIGestureRecognizerDelegate>
// 모든 메소드에서 팬인식기에 접근할 수 있도록 해주는 프로퍼티
@property (nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;
//@property (nonatomic, strong) Line *currentLine;
@property (nonatomic, strong) NSMutableDictionary *lineInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;
//선택한 선들을 저장할 프로퍼티
//(이 프로퍼티는 weak이다 finishedLines배열은 선을 강한 참조로 유지함. 화면이 지워질때 finishedLines에서 선이 제거되면 selectedLine은 nil로 설정될것이다. )
@property (nonatomic, weak) Line *selectedLine;

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
        
        //두 번의 탭이 필요한 UITapGestureRecognizer의 인스턴스를 만든다.
        UITapGestureRecognizer *doubleTapRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        //인식할 제스터가 여전히 가용하면 일시적으로 나타나는 빨간 점을 막기 위해서 뷰에 touchesBegan:withEvent: 메시지가 보내지는 것을 지연시키도록 요청
        //일케 해야 더블 탭하는 동안에 더이상 빨간 점이 보이지 않게 됨.
        doubleTapRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecognizer];
        //사용자가 선을 선택할 수 있도록 다른 제스처 인식기 추가
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        //tap: 과 doubleTap: 메소드 둘다 실행안되게 tapRecognizer가 반드시 doubleTapRecognizer의 실패를 기다리도록 하게함.
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        
        //선을 오래 누르고 있으면(long press ) 그 선이 선택되고 손가락으로 끌어 주변으로 드래그 가능한 ..
        UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];
        //UIPanGestureRecognizer 인스턴스를 만드는 코드 추가 후 그 인식기의 프로퍼티 두개를 설정하고 DrawView에 연결
        self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];
    }
    return self;
}
/**
 translationInView: 메시지를 팬 인식에 보낼 것이다. 이 UIPanGestureRecognizer 메소드는 인자로 전달된 뷰의 좌표계상에서 팬이 얼마나 움직였는지 CGPoint 단위로 반환한다. 팬 제스처가 시작되면 이 프로퍼티는 제로 포인트 (X와 Y 모두 0인)로 설정됨. 이값은 팬의 움직임에 따라 갱신된다. 만약 팬이 매우 멀리 오른쪽으로 가면 높은 X값을 가진다. 팬이 시작된 곳으로 돌아가면 그 값은 제로포인트로 돌아간다.
 */
//moveLine: apthemfmf rngusgksek. UIPanGestureRecognizer 클래스에서 메소드를 제스처 인식기에 보내기 때문에 이 메소드의 인자는 UIGestureRecognizer가 아닌 UIPanGestureRecognizer 인스턴스의 포인터여야 한다.

- (void)moveLine: (UIPanGestureRecognizer *)gr
{
    //선택된 선이 없으면 여기선 아무것도 하지 않는다.
    if (!self.selectedLine) {
        return;
    }
    
    //팬의 위치가 변하면
    if (gr.state == UIGestureRecognizerStateChanged) {
        // 팬이 얼마나 움직였나?
        CGPoint translation = [gr translationInView:self];
        
        //선의 현재 시작 지점과 끝 지점에 이동값을 더한다.
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        
        //선의 새로운 시작 지점과 끝 지점을 설정한다.
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;
        
        //화면을 다시 그린다.
        [self setNeedsDisplay];
        
        /**
         인식기가 변경을 알릴때마다 팬 제스처 인식기의 이동값을 다시 제로 포인트로 설정
         */
        [gr setTranslation:CGPointZero inView:self];
    }
}
/**
 제스처 인식기는 자신의 제스처를 인식하면 이 메시지를 델리게이트에 보낸다. 또한 그 제스처를 다른 제스처 인식기가 인식했다는 것을 알아챌 수도 있다. 만약 이 메소드가  YES를 반환하면 다른 제스처 인식기와  터치를 공유할 수 있다.
 */
//_moveRecognizer가 델리게이트에 이 메시지를 보낸것이라면 YES를 반환함.
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }
    return NO;
}
//롱프레스가 시작되고 뷰가 longPress: 메시지를 받으면 이 제스처가 발생한 가장 가까운 선이 선택되고 화면에 손가락이 놓여있는 동안 사용자에게 선을 선택할 수 있게 해주는 메소드
- (void)longPress:(UIGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:point];
        
        if (self.selectedLine) {
            [self.lineInProgress removeAllObjects];
        }
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}

- (void)tap:(UIGestureRecognizer *)gr API_AVAILABLE(ios(5))
{
    NSLog(@"Recognizer tap");
    //메시지를 제스처 인식기에 보내고 그 결과를 lineAtPoint: 메소드에 전달 그리고 반환된 선을 selectedLine에 할당
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:point];
    
    
    [self setNeedsDisplay];
}
//더블 탭이 발생하면 doubleTap: 메시지가 이 인스턴스로 보내짐.
- (void)doubleTap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized Double Tap");
    
    [self.lineInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
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
    //선택된 선을 녹색으로 그림
    if (self.selectedLine) {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine];
    }
}
//주어진 포인트 근처의 Line을 가져오는 lineAtPoint: 메소드
- (Line *)lineAtPoint:(CGPoint)p
{
    //p포인트와 가까운 선을 찾는다.
    for (Line *l in self.finishedLines) {
        CGPoint start = l.begin;
        CGPoint end = l.end;
        
        //선 위의 포인트들을 검사한다.
        for (float t = 0.0; t <= 1.0; t += 0.05) {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            
            //탭한 지점이 선과 20포인트 이내에 있다면 이선을 반환한다.
            if (hypot(x - p.x, y - p.y) < 20.0) {
                return l;
            }
        }
    }
    // 탭한 지점과 가까운 선이 없다면 선을 선택하지 않는다
    return nil;
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
