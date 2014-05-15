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

@property (nonatomic) NSArray *searchConditions;

+(LeboncoinAgent*)shareAgent;

-(void)scheduleSearch;

@property (nonatomic) NSDate *lastSearchTime;

-(NSArray*)search:(SearchCondition*)aCondition;

-(NSArray*)getSearchConditionsFromFile:(NSString*)filePath;
-(void)saveSearchConditions:(NSArray*)searchConditions toFile:(NSString*)filePath ;

-(AnnonceDetail*)getAnnonceDetailFromJson:(Annonce*)anAnnonce;
-(AnnonceDetail*)getAnnonceDetail:(Annonce*)anAnnonce;

-(BOOL)sendEmail:(NSString*)message toAnnonce:(Annonce*)anAnnonce fromEmail:(NSString*)email fromName:(NSString*)contactName fromTelephone:(NSString*)telephoneNumber;

@property (nonatomic) NSString *lbcSessionUUID;

-(NSString*)getCategoryName:(int)category;
-(NSString*)getLocationName:(int)region;
@end
