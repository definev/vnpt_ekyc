//
//  ICEkycRequestService.h
//  ICSdkEKYC
//
//  Created by MinhMinh on 08/12/2022.
//  Copyright © 2022 iOS Team IC - Innovation Center. All rights reserved.
//

#import <Foundation/Foundation.h>


# pragma mark - OnLoad/OnError Block
typedef void (^OnSuccessBlock)(NSDictionary* value);
typedef void (^OnFailureBlock)(NSError* error);

@interface ICEkycRequestService : NSObject

// 1. thực hiện tải ảnh MẶT TRƯỚC (Chụp giấy tờ) lên máy chủ
// 2. thực hiện tải ảnh MẶT SAU (Chụp giấy tờ) lên máy chủ
// 3. thực hiện tải ảnh CHÂN DUNG THẲNG (Chụp chân dung 1 hướng hoặc xoay mặt) lên máy chủ
// 4. thực hiện tải ảnh CHÂN DUNG QUAY TRÁI (Chụp chân dung xoay mặt) lên máy chủ
// 5. thực hiện tải ảnh CHÂN DUNG QUAY PHẢI (Chụp chân dung xoay mặt) lên máy chủ
// 6. thực hiện tải ảnh CHÂN DUNG XA (Chụp chân dung Oval) lên máy chủ
// 7. thực hiện tải ảnh CHÂN DUNG GẦN (Chụp chân dung Oval) lên máy chủ
+ (void) sendRequestUploadImage:(NSData *)imageData toUrl:(NSString *)url headers:(NSDictionary *)headers title:(NSString *)title description:(NSString *)description onSuccess:(OnSuccessBlock )onSuccess onFailure:(OnFailureBlock)onFailure;


// 8. thực hiện tải dữ liệu QUÉT 3 CHIỀU (Chụp chân dung Oval) lên máy chủ
+ (void) sendRequestUploadLogData:(NSData *)logData toUrl:(NSString *)url headers:(NSDictionary *)headers title:(NSString *)title description:(NSString *)description onSuccess:(OnSuccessBlock)onSuccess onFailure:(OnFailureBlock)onFailure;


// 9. thực hiện BÓC TÁCH THÔNG TIN GIẤY TỜ MẶT TRƯỚC (Chụp giấy tờ)
+ (void) sendRequestGetInfoFrontCardWithUrl:(NSString *)url headers:(NSDictionary *)headers body:(NSString *)body onSuccess:(OnSuccessBlock )onSuccess onFailure:(OnFailureBlock)onFailure;


// 11. thực hiện BÓC TÁCH THÔNG TIN GIẤY TỜ MẶT TRƯỚC VÀ MẶT SAU (Chụp giấy tờ)
+ (void) sendRequestGetInformationCardWithUrl:(NSString *)url headers:(NSDictionary *)headers body:(NSString *)body onSuccess:(OnSuccessBlock )onSuccess onFailure:(OnFailureBlock)onFailure;


// 12. thực hiện KIỂM TRA GIẤY TỜ MẶT TRƯỚC ĐƯỢC CHỤP TRỰC TIẾP HOẶC KHÔNG
// 13. thực hiện KIỂM TRA GIẤY TỜ MẶT SAU ĐƯỢC CHỤP TRỰC TIẾP HOẶC KHÔNG
+ (void) sendRequestCheckLivenessCardWithUrl:(NSString *)url headers:(NSDictionary *)headers body:(NSString *)body onSuccess:(OnSuccessBlock )onSuccess onFailure:(OnFailureBlock)onFailure;


// 14. thực hiện SO SÁNH ẢNH CHÂN DUNG ở GIẤY TỜ MẶT TRƯỚC với ẢNH CHÂN DUNG vừa chụp
+ (void) sendRequestCompareFrontAndFaceWithUrl:(NSString *)url headers:(NSDictionary *)headers body:(NSString *)body onSuccess:(OnSuccessBlock )onSuccess onFailure:(OnFailureBlock)onFailure;


// 15. thực hiện SO SÁNH ẢNH CHÂN DUNG đầy đủ (có thể lấy từ ảnh thẻ NFC) với ẢNH CHÂN DUNG vừa chụp (compare-general)
+ (void) sendRequestCompareFacesWithUrl:(NSString *)url headers:(NSDictionary *)headers body:(NSString *)body onSuccess:(OnSuccessBlock )onSuccess onFailure:(OnFailureBlock)onFailure;


// 16. thực hiện KIỂM TRA KHUÔN MẶT ĐƯỢC CHỤP TRỰC TIẾP HOẶC KHÔNG
+ (void) sendRequestCheckLivenessFaceWithUrl:(NSString *)url headers:(NSDictionary *)headers body:(NSString *)body onSuccess:(OnSuccessBlock )onSuccess onFailure:(OnFailureBlock)onFailure;


// 17. thực hiện KIỂM TRA KHUÔN MẶT ĐƯỢC CHỤP TRỰC TIẾP HOẶC KHÔNG KIỂU 3 CHIỀU
+ (void) sendRequestCheckLivenessFace3DWithUrl:(NSString *)url headers:(NSDictionary *)headers body:(NSString *)body onSuccess:(OnSuccessBlock )onSuccess onFailure:(OnFailureBlock)onFailure;


// 18. thực hiện KIỂM TRA KHUÔN MẶT CÓ BỊ CHE HAY KHÔNG
+ (void) sendRequestCheckMaskFaceWithUrl:(NSString *)url headers:(NSDictionary *)headers body:(NSString *)body onSuccess:(OnSuccessBlock )onSuccess onFailure:(OnFailureBlock)onFailure;


// 19. thực hiện ĐĂNG KÝ THÔNG TIN CÁ NHÂN
+ (void) sendRequestAddFaceWithUrl:(NSString *)url headers:(NSDictionary *)headers body:(NSString *)body onSuccess:(OnSuccessBlock )onSuccess onFailure:(OnFailureBlock)onFailure;


// 19. thực hiện ĐĂNG KÝ THÔNG TIN CÁ NHÂN
+ (void) sendRequestAddCardIDWithUrl:(NSString *)url headers:(NSDictionary *)headers body:(NSString *)body onSuccess:(OnSuccessBlock )onSuccess onFailure:(OnFailureBlock)onFailure;


// 20. thực hiện XÁC THỰC THÔNG TIN CÁ NHÂN
+ (void) sendRequestVerifyFaceWithUrl:(NSString *)url headers:(NSDictionary *)headers body:(NSString *)body onSuccess:(OnSuccessBlock )onSuccess onFailure:(OnFailureBlock)onFailure;


// 21. thực hiện TÌM KIẾM THÔNG TIN CÁ NHÂN
+ (void) sendRequestSearchFaceWithUrl:(NSString *)url headers:(NSDictionary *)headers body:(NSString *)body onSuccess:(OnSuccessBlock )onSuccess onFailure:(OnFailureBlock)onFailure;



@end
