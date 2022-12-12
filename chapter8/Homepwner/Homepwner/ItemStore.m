//
//  ItemStore.m
//  Homepwner
//
//  Created by deokhee park on 2022/12/12.
//

#import "ItemStore.h"
#import "BNRItem.h"

@interface ItemStore ()
//변경 가능한 배열 추가
@property (nonatomic) NSMutableArray *privateItems;

@end
@implementation ItemStore
/**
 sharedStore 변수가 static으로 선언된 것에 주목해야한다. 정적 변수는 메소드가 완료되어도 소멸되지 않는다. 전역 변수와 마찬가지로 스택에 저장되지 않는다.
 sharedStored의 초기값은 nil이다. sharedStored 메소드가 처음 호출될때 ItemStore 인스턴스가 만들어지고 sharedStore는 그 인스턴스를 가리키게 된다. sharedStore는 이 메소드가 호출된 이후에도 여전히 ItemStore인스턴스를 가리키게 된다. 이 변수는 ItemStore에 대한 강한 참조를 가진다. 이 변수는 절대 소멸되지 않기 때문에 변수가 가리키고 있는 객체 또한 절대 소멸되지 않을 것이다.
 */

/**
 ItemsViewController는 새로운 BNRItem을 만들기 원할 때 ItemStore에 메시지를 보낼 것이다. ItemStore는 객체를 만들고 그 객체를 BNRItem 인스턴스 배열에 추가할 의무가 있다. 또한 ItemsViewcontroller는 자신의 UITableView에 항목을 담길 원할 때  ItemStore에 저장소의 모든 항목을 요청한다. 
 */
+ (instancetype)sharedStore
{
    static ItemStore *sharedStore = nil;
    
    //sharedStore를 만들어야 하나?
    
    if(!sharedStore) {
        sharedStore = [[self alloc] initPrivate];// initPrivate?가 뭔지 검색 ㄱ
        
    }
    return sharedStore;
}
// aksdir vmfhrmfoajrk [[ITemStore alloc] init]를 호출하면 오류를 알린다.
- (instancetype) init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[ItemStore sharedStore]" userInfo:nil];
    return nil;
}

//진짜 초기화 메소드
//privateItems를 직접 인스턴스화하는 initPrivate 메소드를 구현, 또한 allItems의 게터를 privateItems를 반환하도록 재정의
- (instancetype) initPrivate
{
    self = [super init];
    if (self != nil) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems
{
    return self.privateItems;
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}
@end
