//
//  SearchCondition.h
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 21/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import <Foundation/Foundation.h>

enum SearchLocation {
    SL_LA_FRANCE = 0,
    SL_PARIS = 1,
    SL_ILE_DE_FRANCE = 2,
    SL_HAUT_DE_SEINE = 3
    
};

enum SearchCategory {
    SC_ALL      = 0,
    SC_MULTIMEDIA = 1,
    SC_INFORMATIQUE = 2,
    SC_IMAGE_SON = 3,
    SC_TELEPHONE = 4,
    SC_ELECTROMENAGER = 5,
    SC_EQUIPEMENT_AUTO = 6
};


@interface SearchCondition : NSObject

@property (nonatomic) NSString *uuid;
@property (nonatomic) NSString *searchKey;
@property (nonatomic) int searchRegion;
@property (nonatomic) int searchCodePostal;
@property (nonatomic) int searchCategory;
@property (nonatomic) int page;
@property (nonatomic) BOOL searchInTitleOnly;

-(NSString*)getCategoryName;
-(NSString*)getLocationName;

@end
