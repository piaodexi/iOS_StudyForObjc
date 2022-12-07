//
//  BNRItem.h
//  RandomItems
//
//  Created by deokhee park on 2022/12/07.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRItem : NSObject
{
    NSString *_itemName;
    NSString *_serialNumber;
    int _valueInDollars;
    NSDate *_dateCreated;
}
//클래스 메소드
+ (instancetype)randomItem;
//BNRItem의 지정 초기화 메소드
- (instancetype)initWithItemName: (NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;

- (instancetype)initWithItemName:(NSString *)name;

- (void)setItemName: (NSString *)str;
- (NSString *)itemName;

- (void)setSerialNumber: (NSString *)str;
- (NSString *)serialNumber;

- (void)setValueInDollars:(int)v;
- (int)valueInDollars;

- (NSDate *)dateCreated;

@end

NS_ASSUME_NONNULL_END
