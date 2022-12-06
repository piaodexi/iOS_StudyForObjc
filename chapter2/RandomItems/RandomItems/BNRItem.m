//
//  BNRItem.m
//  RandomItems
//
//  Created by deokhee park on 2022/12/07.
//

#import "BNRItem.h"

@implementation BNRItem
- (void)setItemName: (NSString *)str{
    _itemName = str;
}
- (NSString *)itemName {
    return _itemName;
}

- (void)setSerialNumber: (NSString *)str {
    _serialNumber = str;
}
- (NSString *)serialNumber {
    return _serialNumber;
}

- (void)setValueInDollars:(int)v {
    _valueInDollars = v;
}
- (int)valueInDollars {
    return _valueInDollars;
}

- (NSDate *)dateCreated {
    return _dateCreated;
}
/**
 여기서는 인스턴스 변수를 이름으로 전달하지 않는다. (예를 들어 _itemName과 같이)  대신에 점 표기법을 이용해 접근자 메소드를 호출함.
 클래스 내부에 있는 인스턴스 변수라도 접근자 메소드를 사용하는게 좋음. 접근자 메소드로 접근을 시도한 인스턴스 변수에 관한 사항을 변경 할 수 있음) 
 */
- (NSString *)description {
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",self.itemName
     ,self.serialNumber, self.valueInDollars, self.dateCreated];
    return descriptionString;
}
@end
