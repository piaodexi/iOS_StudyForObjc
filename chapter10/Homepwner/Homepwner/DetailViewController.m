//
//  DetailViewController.m
//  Homepwner
//
//  Created by deokhee park on 2022/12/12.
//

#import "DetailViewController.h"
#import "BNRItem.h"
@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;

@property (weak, nonatomic) IBOutlet UITextField *valueField;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation DetailViewController

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
