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
@property (nonatomic) NSString *lbcSessionUUID;

#pragma mark Annonce utilities
/**
 @discussion executes the search and returns all annonces found. This call must be executed in background thead, cause I use direct http download in this application.
 @param aCondition   a search-condition
 
 */
-(NSArray*)search:(SearchCondition*)aCondition;

/**
 @discussion get search conditions from an xml file
 @param filePath    path to the xml file.
 */
-(NSArray*)getSearchConditionsFromFile:(NSString*)filePath;

/**
 @discussion    Save search conditions into a file, in order to be used later
 @param searchConditions    contains all search conditions
 @param filePath            path to the file to which those search conditions will be saved
 */
-(void)saveSearchConditions:(NSArray*)searchConditions toFile:(NSString*)filePath ;

/**
 @discussion get detail of an annonce by parsing the json content
 */
-(AnnonceDetail*)getAnnonceDetailFromJson:(Annonce*)anAnnonce;

/**
 @discussion get detail of an annonce by parsing the html content
 */
-(AnnonceDetail*)getAnnonceDetail:(Annonce*)anAnnonce;

/**
 @discussion use the json webservice of leboncoin to send email to the seller.
 */
-(BOOL)sendEmail:(NSString*)message toAnnonce:(Annonce*)anAnnonce fromEmail:(NSString*)email fromName:(NSString*)contactName fromTelephone:(NSString*)telephoneNumber;
#pragma -

#pragma mark Helper
-(NSString*)getCategoryName:(int)category;
-(NSString*)getLocationName:(int)region;
#pragma -
@end
