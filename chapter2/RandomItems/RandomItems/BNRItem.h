//
//  BNRItem.h
//  RandomItems
//
//  Created by deokhee park on 2022/12/07.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 인스턴스들을 아카이브하고 언아카이브해야 할 클래스들은 NSCoding프로토콜을 반드시 따라야 한다.
 */
@interface BNRItem : NSObject <NSCopying>
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

@property (nonatomic, copy)NSString *itemKey;

@end

NS_ASSUME_NONNULL_END
