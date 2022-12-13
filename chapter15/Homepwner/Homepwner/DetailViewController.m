//
//  DetailViewController.m
//  Homepwner
//
//  Created by deokhee park on 2022/12/12.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "imageStore.h"
// 유아이나비게이션컨트롤러딜레게이트는 왜 필요한걸까? 유아이이미지피커컨트롤러의 델리게이트 프로퍼티는 실제로 그 상위 클래스인 유아이네비게이션컨트롤러로부터 상속된것이다. 하지만 유아이이미지피커컨트롤러는 자기 소유의 델리게이트 프로토콜을 가진다. 그 상속된 델리게이트 프로퍼티는 유아이나비게이션컨트롤러델리게이트를 따르는 객체를 가리키도록 선언돼 있기 때문이다. 
@interface DetailViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;

@property (weak, nonatomic) IBOutlet UITextField *valueField;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation DetailViewController
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

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}


@end
