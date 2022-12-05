//
//  QuizViewController.m
//  Quiz
//
//  Created by deokhee park on 2022/12/05.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@property (nonatomic) int currentQuestionIndex;

@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, copy) NSArray *answer;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UILabel *answerLabel;






@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)showQuestion:(id)sender {
    // 다음 문제로 진행한다.
    self.currentQuestionIndex++;
    
    //마지막 문제를 지나갔는가?
    if (self.currentQuestionIndex == [self.questions count]) {
        // 첫 번째 문제로 돌아간다.
        self.currentQuestionIndex = 0;
    }
    //문제 배열에서 현재 인덱의 문자열을 가져온다
    NSString *question = self.questions[self.currentQuestionIndex];
    //문제라벨에 문자열을 표시한다.
    self.questionLabel.text = question;
    //정답 라벨을 초기화한다.
    self.answerLabel.text = @"????";
}

- (IBAction)showAnswer:(id)sender {
    //현 질문에 대한 정답 얻기
    NSString *answer = self.answer[self.currentQuestionIndex];
    //정답 라벨에 정답을 표시한다.
    self.answerLabel.text = answer;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    //상위 클래스에서 구현한 init 메소드를 호출한다.
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        //문제와 정답을 가진 배열 두 개를 만든다.
        //그리고 포인터가 각 배열을 가리키도록 한다.
        
        self.questions = @[@"지금 너가 하고싶은 건?"
                         , @"지금 시간은??"
                         , @"언제 잘까?"];
        self.answer = @[@"모르겟어"
                         , @"열두시쯤"
                         , @"이것만 하고 자야지"];
        
    }
    //새로운 객체의 주소를 반환한다.
    return self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
