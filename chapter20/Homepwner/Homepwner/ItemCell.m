//
//  ItemCell.m
//  Homepwner
//
//  Created by deokhee park on 2022/12/14.
//

#import "ItemCell.h"
@interface ItemCell ()
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageViewWidthConstraint;
@end
@implementation ItemCell

- (void)updateInterfaceForDynamicTypeSize
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.valueLabel.font = font;
    
    static NSDictionary *imageSizeDictionary;
    
    if (!imageSizeDictionary) {
        imageSizeDictionary = @{ UIContentSizeCategoryExtraSmall : @40
                                 , UIContentSizeCategorySmall : @40
                                 , UIContentSizeCategoryMedium : @40
                                 , UIContentSizeCategoryLarge : @40
                                 , UIContentSizeCategoryExtraLarge : @45
                                 , UIContentSizeCategoryExtraExtraLarge : @55
                                 , UIContentSizeCategoryExtraExtraExtraLarge : @65};
    }
    NSString *userSize = [[UIApplication sharedApplication] preferredContentSizeCategory];
    NSNumber *imageSize = imageSizeDictionary[userSize];
    self.imageViewHeightConstraint.constant = imageSize.floatValue;
//    self.imageViewWidthConstraint.constant = imageSize.floatValue;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateInterfaceForDynamicTypeSize];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(updateInterfaceForDynamicTypeSize)
               name:UIContentSizeCategoryDidChangeNotification
             object:nil];
}

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showImage:(id)sender
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
