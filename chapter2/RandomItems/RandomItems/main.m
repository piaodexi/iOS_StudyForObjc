//
//  main.m
//  RandomItems
//
//  Created by deokhee park on 2022/12/07.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {

        //뮤터블 배열 객체를 만들고 items 변수에 그 주소를 저장한다.
        NSMutableArray *items = [[NSMutableArray alloc]init];
        
        //문자열을 인자로 주고 addObject: 메시지를 items 변수가 가리키는 NSMutableArray에 보낸다.
        for(int i = 0; i < 3; i++) {
            [items addObject:[@(i) stringValue]];
        }
        
        //insertObject: atIndex: 메시지를 items에 보낸다.
        [items insertObject:@"zero" atIndex:0];
        
        //items 배열의 모든 항목을 순회한다.
        for (NSString *item in items) {
            NSLog(@"%@",item);
        }
        
        //BNRItem 인스턴스를 만드는 코드와 세 개의 세터 메시지를 삭제 그후
        //지정 초기화 메소드를 사용하여 인스턴스를 만들고 인스턴스 변수를 설정하는 코드를 추가
        //BNRItem *item = [[BNRItem alloc]init];
        // "red sofa" nsstring 을 만들고 bnritem에 할당한다.
        //[item setItemName:@"red sofa"];
        //item.itemName = @"red sofa"; //겟터만 쓴것처럼 보이지만 셋터도 돌아감. (책에 의하면)
        //"a1b2c"nsstring을 만들고 bnritem에 할당한다.
        //[item setSerialNumber:@"a1b2c"];
        //item.serialNumber = @"a1b2c";
        //bnritem의 valueInDollars의. 값으로 100을 전달한다.
        //[item setValueInDollars:100];
        //item.valueInDollars = 100;
//        NSLog(@"%@ %@ %@ %d",[item itemName] ,[item dateCreated] ,[item serialNumber] ,[item valueInDollars]);
//        NSLog(@"%@ %@ %@ %d",item.itemName ,item.dateCreated,item.serialNumber ,item.valueInDollars);
//        BNRItem *item = [[BNRItem alloc] initWithItemName:@"red sofa"
//                                           valueInDollars:100
//                                             serialNumber:@"a1b2c"];
//        //여기서 %@ 토큰은 해당인자에 description 메시지를 보낸 결과로 대체된다.
//        NSLog(@"%@",item);
//
//        //다른 두개의 초기화 메소드를 사용하여 동작확인
//        BNRItem *itemWithName = [[BNRItem alloc]initWithItemName:@"blue sofa"];
//        NSLog(@"%@",itemWithName);
//
//        BNRItem *itemWithNoName = [[BNRItem alloc]init];
//        NSLog(@"%@",itemWithNoName);
        for (int i = 0; i < 10; i++) {
            BNRItem *item = [BNRItem randomItem];
            [items addObject:item];
        }
        for (BNRItem *item in items) {
            NSLog(@"%@",item);
        }
        
//        //예외 발생 테스트용 코드
//        id lastObj = [items lastObject];
//        //lastObj는 BNRItem 인스턴스이고 count 메시지를 인식하지 못한다.
//        [lastObj count];
        //mutable 배열 객체를 제거한다.
        items = nil;
    }
    return 0;
}
