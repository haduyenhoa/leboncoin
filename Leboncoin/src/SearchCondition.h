//
//  SearchCondition.h
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 21/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import <Foundation/Foundation.h>

enum SearchLocation {
    SL_PARIS = 0,
    SL_ILE_DE_FRANCE = 1,
    SL_HAUT_DE_SEINE = 2,
    SL_LA_FRANCE = 3
};

enum SearchCategory {
    SC_MULTIMEDIA = 0,
    SC_INFORMATIQUE = 1,
    SC_IMAGE_SON = 2,
    SC_TELEPHONE = 3,
    SC_ALL      = 4
};


@interface SearchCondition : NSObject

@property (nonatomic) NSString *uuid;
@property (nonatomic) NSString *searchKey;
@property (nonatomic) int searchRegion;
@property (nonatomic) int searchCodePostal;
@property (nonatomic) int searchCategory;
@property (nonatomic) int page;

-(NSString*)getCategoryName;
-(NSString*)getLocationName;

@end
