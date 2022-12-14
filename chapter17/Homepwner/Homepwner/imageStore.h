//
//  imageStore.h
//  Homepwner
//
//  Created by deokhee park on 2022/12/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface imageStore : NSObject

+ (instancetype) sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *) imageForKey: (NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end


