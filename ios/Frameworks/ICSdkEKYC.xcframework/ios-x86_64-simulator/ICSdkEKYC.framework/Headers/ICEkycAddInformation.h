//
//  ICEkycAddInformation.h
//  ICSdkEKYC
//
//  Created by MinhMinhMinh on 30/10/2023.
//  Copyright © 2023 iOS Team IC - Innovation Center. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICEkycAddInformation : NSObject

@property (nonatomic) NSString *uuidCustomer;

@property (nonatomic) NSString *cardId;

@property (nonatomic) NSInteger cardCategoryId;

@property (nonatomic) NSString *fullName;

@property (nonatomic) NSString *dateOfBirth;

@property (nonatomic) NSString *gender;

@property (nonatomic) NSString *recentLocation;

@property (nonatomic) NSString *originLocation;

@property (nonatomic) NSString *issueDate;

@property (nonatomic) NSString *issuePlace;

@property (nonatomic) NSString *validDate;

@property (nonatomic) NSString *hashImageFront;

@property (nonatomic) NSString *hashImageBack;

@property (nonatomic) NSString *nationality;

@property (nonatomic) NSString *rank;

@property (nonatomic) NSString *token;

@end

NS_ASSUME_NONNULL_END
