//
//  imageStore.m
//  Homepwner
//
//  Created by deokhee park on 2022/12/12.
//

#import "imageStore.h"

@interface imageStore ()

@property (nonatomic, strong) NSMutableDictionary *dic;

@end

@implementation imageStore
+ (instancetype)sharedStore
{
    static imageStore *sharedStore;
//
//    if (!sharedStore) {
//        sharedStore = [[self alloc] initPrivate];
//    }
    //정확히 한 번만 실행되는 것을 보장하여 스레드에 안전한 싱글톤을 만들기 위한 코드
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });

    return sharedStore;
}
// init을 직접 호출해서는 안된다.
- (instancetype)init
{
    @throw  [NSException exceptionWithName:@"Singleton"
                                    reason:@"Use +[ImageStore sharedStore"
                                  userInfo:nil];
    return nil;
}
//비공개 지정 초기화 메소드
- (instancetype)initPrivate
{
    self = [super init];

    if (self) {
        _dic = [[NSMutableDictionary alloc] init];
    }

    return self;
}
- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    self.dic[key] = image;
}
- (UIImage *)imageForKey:(NSString *)key
{
    return self.dic[key];
}
- (void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [self.dic removeObjectForKey:key];
}
@end
