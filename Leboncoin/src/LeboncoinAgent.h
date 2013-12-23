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
#import "AnnonceDetail.h"
#import "Annonce.h"
@class SearchCondition;

@interface LeboncoinAgent : NSObject


+(LeboncoinAgent*)shareAgent;

-(void)scheduleSearch;

-(NSArray*)search:(SearchCondition*)aCondition;

-(AnnonceDetail*)getAnnonceDetail:(Annonce*)anAnnonce;
@end
