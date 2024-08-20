//
//  ICEkycAddFace.h
//  ICSdkEKYC
//
//  Created by MinhMinhMinh on 30/10/2023.
//  Copyright © 2023 iOS Team IC - Innovation Center. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICEkycAddFace : NSObject

// Mã HASH ảnh chân dung được dùng để thực hiện đăng ký thông tin khuôn mặt. Mặc định ""
@property (nonatomic) NSString *hashFace;

// Tên người dùng ứng với mã HASH ảnh chân dung. Mặc định ""
@property (nonatomic) NSString *fullName;

// Email của người dùng ứng với mã HASH ảnh chân dung. Mặc định ""
@property (nonatomic) NSString *email;

// Số điện thoại của người dùng ứng với mã HASH ảnh chân dung. Mặc định ""
@property (nonatomic) NSString *phone;

// Định danh Unit của mỗi khách hàng. Mặc định ""
@property (nonatomic) NSString *uuidUnit;

// Giá trị tuỳ chọn kiểm tra trùng khớp khi thực hiện đăng ký thông tin khuôn mặt. Mặc định 0
// - 1: Kiểm tra trùng khớp ngưỡng cao >= 97%
// - 2: Kiểm tra trùng khớp ngưỡng trung bình >= 85%
// - 3: Kiểm tra trùng khớp ngưỡng thấp >= 70%
// - 4: Không kiểm tra trùng khớp
// - 5: Ngưỡng kiểm tra trùng khớp người dùng tùy chọn. Trường hợp chọn ngưỡng này thì cần nhập thông tin 'threshold'
@property (nonatomic) NSInteger thresholdOptional;

// Ngưỡng trùng khớp khi thực hiện đăng ký thông tin khuôn mặt. Ngưỡng trong khoảng [70.0 - 99.7]
@property (nonatomic) CGFloat threshold;

// - 1 thì thực hiện add face sang face id và db
// - 0 thì chỉ gọi add vào db
@property (nonatomic) NSInteger status;

// Token truyền từ bên ngoài vào SDK. Mặc định ""
@property (nonatomic) NSString *token;

@end

NS_ASSUME_NONNULL_END
