//
//  DetailViewController.m
//  Homepwner
//
//  Created by deokhee park on 2022/12/12.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "imageStore.h"
#import "ItemStore.h"

// 유아이나비게이션컨트롤러딜레게이트는 왜 필요한걸까? 유아이이미지피커컨트롤러의 델리게이트 프로퍼티는 실제로 그 상위 클래스인 유아이네비게이션컨트롤러로부터 상속된것이다. 하지만 유아이이미지피커컨트롤러는 자기 소유의 델리게이트 프로토콜을 가진다. 그 상속된 델리게이트 프로퍼티는 유아이나비게이션컨트롤러델리게이트를 따르는 객체를 가리키도록 선언돼 있기 때문이다. 
@interface DetailViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate ,UIPopoverControllerDelegate>


//팝 오버 컨트롤러를 저장할 프로퍼티
//UIPopoverController deprecated됨 
//@property (strong, nonatomic)UIPopoverController *imagePickerPopover;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;

@property (weak, nonatomic) IBOutlet UITextField *valueField;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;


@end

@implementation DetailViewController

- (instancetype)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        if (isNew) {
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                            target:self
                                            action:(@selector(cancel:))];
            self.navigationItem.leftBarButtonItem = cancelItem;
            
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]                                                    initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                target:self
                action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            
        }
    }
    return self;
}
- (void)cancel:(id)sender
{
    NSLog(@"check cancel");
    //사용자가 취소하면 저장소에서 Item을 제거한다.
    [[ItemStore sharedStore] removeItem:self.item];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}
- (void)save:(id)sender
{
    NSLog(@"check save");
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}
/**
이 코드는 예외명과 그 이유를 포함한 NSException 인스턴스를 만들고서 그 예외를 던진다. 이는 프로그램을 중단하고 콘솔에서 예외를 보여준다. 던져진 예외를 확인하기 위해 initWithNibName:bundle : 메소드가 현재 호출된 곳 (ItemViewController의 tableView:didSelectRowAtIndexPath: 메소드) 으로 돌아가보자.  이 메소드에서 ItemViewController는 DetailViewController의 인스턴스를 만들어서 init 메시지를 보내고 결국 initWithNibName:bundle:을 호출한다. 그러므로 테이블뷰에서 행을 선택하면 "Wrong initializer"라는 예외가 발생할것이다.
 
 이예외를 다시 보지 않으려면 ItemsViewController.m에서 새 초기화 메소드를 사용하도록 tableView:didSelectRowAtIndexPath: 메소드를 갱신한다.
 */
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw  [NSException exceptionWithName:@"Wrong initializer"
                                    reason:@"Use initForNewItem:"
                                  userInfo:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:nil];
    //xib파일에서 이미지뷰의 contentMode는 Aspect Fit이였다.
    iv.contentMode = UIViewContentModeScaleAspectFit;
    //이미지뷰에서 변환 제약조건을 만들지 않도록 한다.
    iv.translatesAutoresizingMaskIntoConstraints = NO;
    //이미지뷰는 이 뷰의 하위뷰이다
    [self.view addSubview:iv];
    //imageView프로퍼티가 이미지뷰를 가리킨다.
    self.imageView = iv;
    
    //수직 우선순위를 다른 하위뷰들의 값보다 더 작게 설정한다.
    [self.imageView setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
    [self.imageView setContentCompressionResistancePriority:700 forAxis:UILayoutConstraintAxisHorizontal];
    //뷰의 이름을 위한 딕셔너리를 만든다.
    NSDictionary *nameMap = @{@"imageView" : self.imageView
                            , @"dateLabel" : self.dateLabel
                              , @"toolbar" : self.toolbar};
    
    //이미지 뷰의 수평과 수직 제약조건을 만든다.
    
    // imageView의 왼쪽과 오른쪽 여백은 상위뷰부터 0포인트이다.
    NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                options:0
                                                metrics:nil
                                                  views:nameMap];
    
    // imageView의 위쪽 여백은 dateLabel부터 8포인트이다.
    // 그리고 아래쪽 여백은 툴바부터 8포인트이다.
    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLabel]-[imageView]-[toolbar]"
                                                options:0
                                                metrics:nil
                                                  views:nameMap];
    
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
    
}
/**
 아이폰인 경우 가로 모드에서만 이미지뷰를 숨기고 카메라버튼을 비활성화한다.
 
 방향 변경에 대한 응답 코드를 작성할 때는 UIViewController의 willAnimateRotationToInterfaceOrientation:duration: 메소드를 재정의한다. willAnimateRotationToInterfaceOrientation:duration: 메시지는 인터페이스 방향이 성공적으로 변경되면 뷰컨트롤러에 보내진다. 이 메소드의 첫번째 인자가 새 인터페이스 방향 값이다.
 */
/**
 prepareViewsForOrientation:이라는 새 메소드를 만들어 장치를 확인하고 그 인터페이스 방향을 검사한다. 장치가 아이폰이고 새 인터페이스 방향이 가로라면 이미지뷰를 숨기고 버튼을 비활성화한다. 뷰가 화면에 처음 나타날 때와 방향이 바뀔 때마다 이 메소드를 호출한다.
 */

//- (void)prepareViewsForOrientation: (UIInterfaceOrientation)orientation
//{
//    //아이패드인가? 그럼 준비안해도된다.
//    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
//        return;
//    }
//
//    //가로 모드인가?
//    if (UIInterfaceOrientationIsLandscape(orientation)) {
//        self.imageView.hidden = YES;
//        self.cameraButton.enabled = NO;
//    } else {
//        self.imageView.hidden = NO;
//        self.cameraButton.enabled = YES;
//    }
//}
//deprecated됨
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    [self prepareViewsForOrientation:toInterfaceOrientation];
//}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text =item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d",item.valueInDollars];
    
    //날짜를 간단한 문자열로 변환하기 위해 NSDateFormatter가 필요함
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    //NSDate 객체를 문자열로 변환하면 dateLabel의 내용으로 설정한다.
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *imageKey = self.item.itemKey;
    
    //이미지 저장소에서 imageKey로 이미지를 얻는다.
    UIImage *imageToDisplay = [[imageStore sharedStore] imageForKey:imageKey];
    
    //화면의 imageView에 그 이미지를 놓는다.
    self.imageView.image = imageToDisplay;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //퍼스트 리스폰더가 해재된다.
    /**
     뷰가 엔드에디팅 메시지를 받으면 뷰 자신이나 그 하위뷰가 현재 퍼스트 리스폰더라면 퍼스트 리스폰더 상태가 해재되고 키보드가 사라지게 된다. (퍼스트 리스폰더가 강제로 물러나게 될지는 이 메소드에 전달된 인자에 따라 결정된다. 일부 퍼스트 리스폰더는 해재를 거부할 수도 있다. 하지만 예스를 전달하면 그 거부를 무시한다.)
     */
    [self.view endEditing:YES];
    
    // 변경내용을 item에 저장한다.
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}
//didFinishPickingMediaWithInfo 선택한 이미지를 UIImageView에 넣고 이미지 피커가 사라지도록 구현함.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    //info 딕셔너리에서 선택된 이미지를 가져온다.
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //이미지를 이 키로 ImageStore에 저장한다.
    [[imageStore sharedStore] setImage:image forKey:self.item.itemKey];
    //이미지뷰에 이미지를 넣는다.
    self.imageView.image = image;
    
    //dlalwlvlzjfmf ghkausdptj tkfkwlrp gksek.
    //이 dismiss 메소드를 호출해야한다.
    [self dismissViewControllerAnimated:YES completion:nil];
}
//DetailViewController.m에서 takePicture: 스텁을 찾아 이미지 피커를 만들고 sourceType을 설정하도록 다음 코드를 추가한다.
- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //카메라가 있는 장치라면 사진을 찍고
    //아니면 사진 라이브러리에서 사진을 가져온다
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    //화면에 이미지 피커를 표시한다.
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

//모호한 레이아웃 테스트 코드
//- (void)viewDidLayoutSubviews
//{
//    for (UIView *subview in self.view.subviews) {
//        if ([subview hasAmbiguousLayout]){
//            NSLog(@"AMBIGUOS : %@",subview);
//        }
//    }
//}
//
//- (IBAction)testBt:(id)sender {
//    [self.view endEditing:YES];
//
//    for (UIView *subview in self.view.subviews) {
//        if ([subview hasAmbiguousLayout]){
//            [subview exerciseAmbiguityInLayout];
//        }
//    }
//}


@end
