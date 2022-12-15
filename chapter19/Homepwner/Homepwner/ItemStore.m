//
//  ItemStore.m
//  Homepwner
//
//  Created by deokhee park on 2022/12/12.
//

#import "ItemStore.h"
#import "BNRItem.h"
#import "imageStore.h"
@interface ItemStore ()
//변경 가능한 배열 추가
@property (nonatomic) NSMutableArray *privateItems;

@end
@implementation ItemStore
/**
 archiveRootObject:toFile: 메시지를 NSKeyedArchiver 클래스에 보내도록한다.
 
 */
- (BOOL)saveChanges
{
//    NSString *path = [self itemArchivePath];
//
//    //성공은 YES를 반환한다.
//    //deprecated 됨 ..
//    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
    return NO;
}
- (NSString *)itemArchivePath
{
    // 첫 번째 인자가 NSCocumentationdirectory가 아닌 NSDocumentDirectory인지 확인한다.
    /**
     NSSearchPathForDirectoriesInDomains 함수는 주어진 인자들에 따른 기준에 부합하는 경로를 파일시스템에서 검색한다. 이 함수의 마지막 두 인자는 iOS에서 항상 같다.(이 함수는 OS X에서 빌려온 것으로 상당히 많은 옵션을 가지고 있다. 첫번째 인자는 샌드박스에서 경로를 얻고자 하는 디렉터리를 지정한 상수이다. 예를 들어 NSCachesDirectory를 검색하면 앱 샌드박스에서 Caches 디렉터리를 반환할것이다. 다른 옵션을 지정하기 위한 NSDocumentDirectory와 같은 상수들 중 하나를 위해 문서를 검색할 수도 있다. 이들 상수는 iOS와 OS X가 함깨 사용한다. 따라서 모든 상수가 iOS에서 작동하는 것은 아니다.
     
     NSSearchPathForDirectoriesInDomains의 반환값은 문자열 배열이다. 이것이 문자열 배열인 것은 OS X 에서 왔기 때문이다. OS X에서는 검색 기준에 부합하는 경로가 여러 개 있을 수 있다. 반면 iOS에서는 오직하나뿐이다 (검색한 디렉터리가 적절한 샌드박스 디렉터리일 경우) 그러므로 아카이브 파일의 이름은 그 배열에서 오직 하나뿐인 첫 번째 결과에 덧붙여진다. 이는 BNRItem인스턴스가 살아있을 아카이브의 위치이다.*/
    NSArray *documentDirectoris =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                            NSUserDomainMask,
                                            YES);
    
    //그 목록에서 오직 하나의 도큐멘트 디렉터리를 얻는다.
    NSString *doucmentDirectory = [documentDirectoris firstObject];
    
    return [doucmentDirectory stringByAppendingPathComponent:@"items.archive"];
}
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
/**
 여기서 removeObjectIdenticalTo: 는 이 메시지에 전달된 객체와 정확히 동일한 객체인 경우에만 그 객체를 삭제한다. 하지만 현재 BNRItem에서 isEqual: 메소드는 별도로 검사하도록 재정의 하지 않았다. 앞으로도 그럴 것이다. 그러므로 특정 인스턴스를 명시할때  removeObjectIdenticalTo: 를 사용해야한다. 
 */
- (void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemKey;
    [[imageStore sharedStore] deleteImageForKey:key];
    [self.privateItems removeObjectIdenticalTo:item];
}
- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    //객체가 이동할 포인터를 얻어 다시 삽입한다.
    BNRItem *item = self.privateItems[fromIndex];
    
    //item을 배열에서 삭제한다.
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    // 배열에서 itemdmf to dnlcldp tkqdlqgksek.
    [self.privateItems insertObject:item atIndex:toIndex];
}
@end
