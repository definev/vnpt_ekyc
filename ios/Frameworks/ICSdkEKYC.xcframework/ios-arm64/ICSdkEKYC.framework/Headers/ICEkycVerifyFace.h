//
//  ICEkycVerifyFace.h
//  ICSdkEKYC
//
//  Created by MinhMinhMinh on 31/10/2023.
//  Copyright © 2023 iOS Team IC - Innovation Center. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICEkycVerifyFace : NSObject

// Mã HASH ảnh chân dung được dùng để thực hiện xác thực khuôn mặt. Mặc định ""
@property (nonatomic) NSString *hashFace;

// Định danh Unit của mỗi khách hàng. Mặc định ""
@property (nonatomic) NSString *uuidUnit;

// Định danh Unit của mỗi người dùng, đi kèm với 1 thông tin khôn mặt & số giấy tờ. Mặc định ""
@property (nonatomic) NSString *uuidCustomer;

// Số ID của mỗi người dùng. Mặc định ""
@property (nonatomic) NSString *cardId;

// Token truyền từ bên ngoài vào SDK. Mặc định ""
@property (nonatomic) NSString *token;


@end

NS_ASSUME_NONNULL_END
