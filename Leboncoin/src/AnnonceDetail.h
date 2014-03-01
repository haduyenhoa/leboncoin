//
//  AnnonceDetail.h
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 22/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnonceDetail : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *annonceId;
@property (nonatomic) NSArray *imageLink;
@property (nonatomic) NSString *text;
@property (nonatomic) NSString *telephoneNumberImageLink;
@property (nonatomic) NSString *telephoneNumber;
@property (nonatomic) UIImage *imgPhoneNumber;
@property (nonatomic) NSString *priceString;
@property (nonatomic) NSString *dateString;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *ville;
@property (nonatomic) NSString *postalCode;
@property (nonatomic) NSData *annonceData;
@end
