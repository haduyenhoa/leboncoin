//
//  Annonce.h
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 20/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Annonce : NSObject

@property (nonatomic) NSString *annonceId;
@property (nonatomic) NSString *title;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSString *dateStr;
@property (nonatomic) NSString *linkAnnonce;
@property (nonatomic) NSString *linkImage;
@property (nonatomic) NSString *location;
@property (nonatomic) NSString *price;

@end
