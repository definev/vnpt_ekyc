//
//  ICEkycSearchFace.h
//  ICSdkEKYC
//
//  Created by MinhMinhMinh on 31/10/2023.
//  Copyright © 2023 iOS Team IC - Innovation Center. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICEkycSearchFace : NSObject

@property (nonatomic) NSString *hashFace;

@property (nonatomic) NSString *uuidUnit;

@property (nonatomic) NSInteger maxResult;

@property (nonatomic) CGFloat threshold;

@property (nonatomic) NSString *token;

@end

NS_ASSUME_NONNULL_END
