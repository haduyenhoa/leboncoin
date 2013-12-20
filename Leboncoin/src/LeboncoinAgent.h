//
//  LeboncoinAgent.h
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 20/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"
#import "HTMLParser.h"

enum SearchLocation {
    PARIS = 0,
    ILE_DE_FRANCE = 1,
    HAUT_DE_SEINE = 2,
    LA_FRANCE = 3
    };

enum SearchCategory {
    MULTIMEDIA = 0,
    INFORMATIQUE = 1,
    IMAGE_SON = 2,
    TELEPHONE = 3,
    ALL      = 4
    };

@interface LeboncoinAgent : NSObject


+(LeboncoinAgent*)shareAgent;

-(void)scheduleSearch;

@end
