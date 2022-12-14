//
//  DetailViewController.h
//  Homepwner
//
//  Created by deokhee park on 2022/12/12.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController
- (instancetype)initForNewItem:(BOOL)isNew;
@property (nonatomic, strong) BNRItem *item;
//블록 포인터 프로퍼티
@property (nonatomic, copy) void (^dismissBlock)(void);
@end

