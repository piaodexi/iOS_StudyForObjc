//
//  BNRItem.m
//  RandomItems
//
//  Created by deokhee park on 2022/12/07.
//

#import "BNRItem.h"

@implementation BNRItem
//클래스 메소드 구현하기
+ (instancetype)randomItem {
    //3개의 형용사 배열을 만든다.
    NSArray *randomAdjectiveList = @[@"fluffy" ,@"rusty" ,@"shiny"];
    
    //3개의 명사 배열을 만든다.
    NSArray *randomNounList = @[@"Bear" , @"spork" ,@"mac"];
    
    //목록에서 임의의 형용사/명사의 인덱스를 가져온다.
    //참고 : %연산자는 나머지를 돌려주는 모듈로 연산자이다.
    //따라서 adjectiveIndex는 0과 2 사이의 난수이다.
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    //NSInteger는 객체가 아닌 long 타입으로 정의되어있다.
//    NSString * randomName = [NSString stringWithFormat:@"%@ %@", [randomAdjectiveList objectAtIndex:adjectiveIndex],[randomNounList objectAtIndex:nounIndex]];
    //축약문법
    NSString *randomName = [NSString stringWithFormat:@"%@ %@", randomAdjectiveList[adjectiveIndex],
                            randomNounList[nounIndex]];
    
    int randomValue = arc4random() % 100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c", '0' +arc4random() %10
                                    ,'A' +arc4random() %26
                                    ,'0' +arc4random() %10
                                    ,'A' +arc4random() %26
                                    ,'0' +arc4random() %10];

    BNRItem *newItem = [[self alloc] initWithItemName:randomName
                                       valueInDollars:randomValue serialNumber:randomSerialNumber];
    
    return newItem;
}
//지정초기화 메소드 구현하기
- (instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber {
    //상위 클래스의 지정 초기화 메소드를 호출한다.
    self = [super init];
    
    //상위 클래스의 지정 초기화 메소드가 성공했는가?
    if (self != nil) {
        //인스턴스 변수에 초기값을 대입한다.
        _itemName = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        //_dateCreated를 현재 날짜와 시간으로 설정한다.
        _dateCreated = [[NSDate alloc]init];
    }
    //새로 초기화된 객체의 주소를 반환한다.
    return self;
}
- (instancetype)initWithItemName:(NSString *)name {
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}
//init 재정의 품목명을 기본값으로 전달하여 initWithItemNamedmf ghcnfgkehfhr.. 
- (instancetype)init {
    return [self initWithItemName:@"item"];
}

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

- (void)dealloc {
    NSLog(@"destroyed : %@",self);
}
@end
