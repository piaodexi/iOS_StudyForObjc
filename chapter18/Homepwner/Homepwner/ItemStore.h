//
//  ItemStore.h
//  Homepwner
//
//  Created by deokhee park on 2022/12/12.
//

#import <Foundation/Foundation.h>
/**
 @class 지시자는 컴파일러에 BNRItem 클래스가 존재한다는 것을 알리고, 실제로 파일이 존재하면 컴파일러가 이 클래스의 세부사항을 얼 팔요가 없다는 것을 알린다.
 이는 BNRItem.h 파일 임포트 없이 createItem 선언에서 BNRItem 심버을 사용할 수 있게 허용한다. @class 지시자의 사용은 파일 변경됐을 때 보다 적은 수의 파일들만 재 컴파일하기 때문에 컴파일 속도를 상당히 빠르게 할 수 있다.
 
 실제로 BNRItem 클래스나 인스턴스에 메시지를 보내는 파일에서는 반드시 클래스가 선언된 파일을 임포트해야 한다. 그래야 컴파일러가 세부 사항을 알 수 있기 때문이다.
 ItemStore.m 은 특정 시점에 BNRItem 인스턴스에 메시지를 보내기 때문에 파일 상당에 BNRItem.h를 임포트 한다.
 
 여기서 흥미로운 것이 있다. 우리는 품목의 배열을 관리는 ItemStore를 가진다ㅣ. 이 저장소는 배열에 품목을 추가하거나 삭제하고 재정렬 하는 등의 역활을 한다. ItemStore는 배열을 전적으로 제어하기 위해 품목 배열을 readonly 프로퍼티로 선언하고 변경할 수 없는 NSArray로 반환한다. 따라서 ItemStore의 allItems 프로퍼티는 다른 객체에서 새 배열을 할당하거나 배열을 직접 수정하더라도변경 할 수 없다. 하지만 내부에서는 ItemStore가 새 품목을 추가 (또는 삭제, 재정렬) 하기 위해 배열을 변경해야 한다. 이는 내부 데이터를 엄격히 제어하기 위한 클래스 설계 방식이다. 객체는 내부에 변경할 수 있는 자료구조를 유지하지만 다른 객체들은 변경할 수 없는 자료구조에만 접근할 수 있다.
 
 */
@class  BNRItem;

@interface ItemStore : NSObject


@property (nonatomic, readonly) NSArray *allItems;
// - 대신에 +가 붙은 메소드는 클래스 메소드이다.
//ItemStore 클래스가 이 메시지를 받으면 그 클래스는 ItemStore에 이미 생성된 단일 인스턴스가 있는지 확인한다. 만약 있다면 그 인스턴스를 반환하고, 없다면 새 인스턴스를 만들어 반환한다.
+ (instancetype)sharedStore;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex: (NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;
- (BOOL)saveChanges;
@end

