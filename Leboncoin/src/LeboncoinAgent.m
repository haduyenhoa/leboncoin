//
//  LeboncoinAgent.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 20/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import "LeboncoinAgent.h"
#import "Annonce.h"
#import "SearchCondition.h"
#import "SearchLinkGenerator.h"
#import <Foundation/NSJSONSerialization.h>

#import <AdSupport/AdSupport.h>

#import "Hoa_OpenUDID.h"
#import "TouchXML.h"


static LeboncoinAgent *_shareAgent;

@implementation LeboncoinAgent

+(LeboncoinAgent*)shareAgent {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareAgent = [[LeboncoinAgent alloc] init];
    });
    return _shareAgent;
}

-(id)init {
    self = [super init];
    if (self) {

        
//        //create an annonce
//        SearchCondition *cabasseCondition = [[SearchCondition alloc] init];
//        cabasseCondition.page = 1;
//        cabasseCondition.searchCategory = SC_IMAGE_SON;
//        cabasseCondition.searchRegion = SL_LA_FRANCE;
//        cabasseCondition.searchKey = @"cabasse";
//        
//        SearchCondition *tannoyCondition = [[SearchCondition alloc] init];
//        tannoyCondition.page = 1;
//        tannoyCondition.searchCategory = SC_IMAGE_SON;
//        tannoyCondition.searchRegion = SL_LA_FRANCE;
//        tannoyCondition.searchKey = @"tannoy";
//        
//        SearchCondition *thielCondition = [[SearchCondition alloc] init];
//        thielCondition.page = 1;
//        thielCondition.searchCategory = SC_IMAGE_SON;
//        thielCondition.searchRegion = SL_LA_FRANCE;
//        thielCondition.searchKey = @"thiel";
//        
//        SearchCondition *sansuiCondition = [[SearchCondition alloc] init];
//        sansuiCondition.page = 1;
//        sansuiCondition.searchCategory = SC_IMAGE_SON;
//        sansuiCondition.searchRegion = SL_LA_FRANCE;
//        sansuiCondition.searchKey = @"sansui";
//        
//        SearchCondition *regaCondition = [[SearchCondition alloc] init];
//        regaCondition.page = 1;
//        regaCondition.searchCategory = SC_IMAGE_SON;
//        regaCondition.searchRegion = SL_LA_FRANCE;
//        regaCondition.searchKey = @"rega";
//        
//        SearchCondition *linnCondition = [[SearchCondition alloc] init];
//        linnCondition.page = 1;
//        linnCondition.searchCategory = SC_IMAGE_SON;
//        linnCondition.searchRegion = SL_LA_FRANCE;
//        linnCondition.searchKey = @"linn";
//        
//        SearchCondition *aristonCondition = [[SearchCondition alloc] init];
//        aristonCondition.page = 1;
//        aristonCondition.searchCategory = SC_IMAGE_SON;
//        aristonCondition.searchRegion = SL_LA_FRANCE;
//        aristonCondition.searchKey = @"ariston";
//        
//        SearchCondition *transcriptorCondition = [[SearchCondition alloc] init];
//        transcriptorCondition.page = 1;
//        transcriptorCondition.searchCategory = SC_IMAGE_SON;
//        transcriptorCondition.searchRegion = SL_LA_FRANCE;
//        transcriptorCondition.searchKey = @"transcriptor";
//        
//        SearchCondition *michellCondition = [[SearchCondition alloc] init];
//        michellCondition.page = 1;
//        michellCondition.searchCategory = SC_IMAGE_SON;
//        michellCondition.searchRegion = SL_LA_FRANCE;
//        michellCondition.searchKey = @"michell";
//        
//        SearchCondition *mcintoshCondition = [[SearchCondition alloc] init];
//        mcintoshCondition.page = 1;
//        mcintoshCondition.searchCategory = SC_IMAGE_SON;
//        mcintoshCondition.searchRegion = SL_LA_FRANCE;
//        mcintoshCondition.searchKey = @"mcintosh";
//        
//        SearchCondition *iphone5sCondition = [[SearchCondition alloc] init];
//        iphone5sCondition.page = 1;
//        iphone5sCondition.searchCategory = SC_TELEPHONE;
//        iphone5sCondition.searchRegion = SL_ILE_DE_FRANCE;
//        iphone5sCondition.searchKey = @"iphone 5s";
//        
//        SearchCondition *tomtoGoCondition = [[SearchCondition alloc] init];
//        tomtoGoCondition.page = 1;
//        tomtoGoCondition.searchCategory = SC_EQUIPEMENT_AUTO;
//        tomtoGoCondition.searchRegion = SL_ILE_DE_FRANCE;
//        tomtoGoCondition.searchKey = @"tomtom go";
//        
//        SearchCondition *dysonSearch = [[SearchCondition alloc] init];
//        dysonSearch.page = 1;
//        dysonSearch.searchCategory = SC_ELECTROMENAGER;
//        dysonSearch.searchRegion = SL_LA_FRANCE;
//        dysonSearch.searchKey = @"dyson";
//        
//        SearchCondition *demenagementCondition = [[SearchCondition alloc] init];
//        demenagementCondition.page = 1;
//        demenagementCondition.searchCategory = SC_IMAGE_SON;
//        demenagementCondition.searchRegion = SL_LA_FRANCE;
//        demenagementCondition.searchKey = @"demenagement";
//        
//        SearchCondition *demenagementAllCatCondition = [[SearchCondition alloc] init];
//        demenagementAllCatCondition.page = 1;
//        demenagementAllCatCondition.searchCategory = SC_ALL;
//        demenagementAllCatCondition.searchRegion = SL_LA_FRANCE;
//        demenagementAllCatCondition.searchKey = @"demenagement";
//        
//        SearchCondition *neilYoungCondition = [[SearchCondition alloc] init];
//        neilYoungCondition.page = 1;
//        neilYoungCondition.searchCategory = SC_MUSIC;
//        neilYoungCondition.searchRegion = SL_LA_FRANCE;
//        neilYoungCondition.searchKey = @"neil young";
//        
//        SearchCondition *ericClaptonCondition = [[SearchCondition alloc] init];
//        ericClaptonCondition.page = 1;
//        ericClaptonCondition.searchCategory = SC_MUSIC;
//        ericClaptonCondition.searchRegion = SL_LA_FRANCE;
//        ericClaptonCondition.searchKey = @"eric clapton";
//        
//        SearchCondition *vinylesCondition = [[SearchCondition alloc] init];
//        vinylesCondition.page = 1;
//        vinylesCondition.searchCategory = SC_MUSIC;
//        vinylesCondition.searchRegion = SL_LA_FRANCE;
//        vinylesCondition.searchKey = @"vinyles";
//        
//        self.searchConditions = [NSArray arrayWithObjects:cabasseCondition, thielCondition, tannoyCondition, regaCondition, michellCondition, demenagementCondition, dysonSearch, sansuiCondition, iphone5sCondition, mcintoshCondition, transcriptorCondition, aristonCondition, linnCondition, tomtoGoCondition, demenagementAllCatCondition, neilYoungCondition, ericClaptonCondition, vinylesCondition, nil];
        
//        NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:@"leboncoin" ofType:@"xml"];
//        self.searchConditions = [self getSearchConditionsFromFile:bundleFilePath];
        
        
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"leboncoin.xml"];
        
        self.searchConditions = [self getSearchConditionsFromFile:filePath];
//        [self saveSearchConditions:self.searchConditions toFile:filePath];
        
        self.lbcSessionUUID = [Hoa_OpenUDID value];
        self.lbcSessionUUID = @"2a4ff69a2b654dd219568ca6942beefa49c8dde0";
    }
    return self;
}

- (NSString *)uuidString {
    // Returns a UUID
    
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
    
    return uuidString;
}


-(NSArray*)getSearchConditionsFromFile:(NSString*)filePath {
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@"files %@ does not exist",filePath);
        return nil;
    }
    
    NSMutableArray *searchConditions  = [[NSMutableArray alloc] init];
    
    NSError *readXmlError;
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:[NSData dataWithContentsOfFile:filePath] encoding:NSUTF8StringEncoding options:0 error:&readXmlError];
    if (doc == nil || readXmlError) {
        NSLog(@"Cannot get content: %@", readXmlError? readXmlError.localizedDescription : @"");
        return nil;
    }
    
    CXMLElement *root = doc.rootElement;
    if (root) {
        for (CXMLElement *aSearchElement in [root elementsForName:@"SearchCondition"]) {
            SearchCondition *aSearchCondition = [[SearchCondition alloc] init];
            
            //get page
            CXMLElement *pageElement = nil;
            NSArray *temp = [aSearchElement elementsForName:@"Page"];
            if (temp && temp.count > 0) {
                pageElement = [temp firstObject];
            }
            aSearchCondition.page = pageElement.stringValue == nil ? 0 : pageElement.stringValue.intValue;
            
            //get search category
            CXMLElement *searchCategoryElement = nil;
            temp = [aSearchElement elementsForName:@"Category"];
            if (temp && temp.count > 0) {
                searchCategoryElement = [temp firstObject];
            }
            aSearchCondition.searchCategory = searchCategoryElement.stringValue == nil ? 0 : searchCategoryElement.stringValue.intValue;
            
            //get region
            CXMLElement *searchRegionElement = nil;
            temp = [aSearchElement elementsForName:@"Region"];
            if (temp && temp.count > 0) {
                searchRegionElement = [temp firstObject];
            }
            aSearchCondition.searchRegion = searchRegionElement.stringValue == nil ? 0 : searchRegionElement.stringValue.intValue;
            
            //get key
            CXMLElement *searchKeyElement = nil;
            temp = [aSearchElement elementsForName:@"Key"];
            if (temp && temp.count > 0) {
                searchKeyElement = [temp firstObject];
            }
            aSearchCondition.searchKey = searchKeyElement.stringValue == nil ? @"" : searchKeyElement.stringValue;
            
            //get title
            CXMLElement *searchTitleElement = nil;
            temp = [aSearchElement elementsForName:@"Title"];
            if (temp && temp.count > 0) {
                searchTitleElement = [temp firstObject];
            }
            aSearchCondition.searchTitle = searchTitleElement.stringValue == nil ? @"" : searchTitleElement.stringValue;
            
            //get search in title
            CXMLElement *searchInTitleOnlyElement = nil;
            temp = [aSearchElement elementsForName:@"SearchInTitleOnly"];
            if (temp && temp.count > 0) {
                searchInTitleOnlyElement = [temp firstObject];
                
                aSearchCondition.searchInTitleOnly = searchInTitleOnlyElement.stringValue == nil ? NO : searchInTitleOnlyElement.stringValue.boolValue;
            } else {
                aSearchCondition.searchInTitleOnly = NO;
            }
            
            //get search in title
            CXMLElement *searchCodePostalElement = nil;
            temp = [aSearchElement elementsForName:@"CodePostal"];
            if (temp && temp.count > 0) {
                searchCodePostalElement = [temp firstObject];
                
                if (searchCodePostalElement.stringValue) {
                    aSearchCondition.searchCodePostal = searchCodePostalElement.stringValue.intValue;
                }
            } else {
                
            }
            
            //get ME
            CXMLElement *meElement = nil;
            temp = [aSearchElement elementsForName:@"ME"];
            if (temp && temp.count > 0) {
                meElement = [temp firstObject];
                
                if (meElement.stringValue) {
                    aSearchCondition.me = meElement.stringValue.intValue;
                }
            } else {
                
            }
            
            //get RS
            CXMLElement *rsElement = nil;
            temp = [aSearchElement elementsForName:@"RS"];
            if (temp && temp.count > 0) {
                rsElement = [temp firstObject];
                
                if (rsElement.stringValue) {
                    aSearchCondition.rs = rsElement.stringValue.intValue;
                }
            } else {
                
            }
            
            [searchConditions addObject:aSearchCondition];
        }
    }
    
    return searchConditions;
}

-(void)saveSearchConditions:(NSArray*)searchConditions toFile:(NSString*)filePath {
    NSString *xmlDoc = @"<Leboncoin>\n";
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@"remove old file at %@",filePath);
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    
    for (SearchCondition *aSC in searchConditions) {
        xmlDoc = [xmlDoc stringByAppendingString:@"\t<SearchCondition>\n"];
        xmlDoc = [xmlDoc stringByAppendingFormat:@"\t\t<Page>%d</Page>\n",aSC.page];
        xmlDoc = [xmlDoc stringByAppendingFormat:@"\t\t<Category>%d</Category>\n",aSC.searchCategory];
        xmlDoc = [xmlDoc stringByAppendingFormat:@"\t\t<Region>%d</Region>\n",aSC.searchRegion];
        if (aSC.searchTitle) {
            xmlDoc = [xmlDoc stringByAppendingFormat:@"\t\t<Title>%@</Title>\n",aSC.searchTitle];
        }
        xmlDoc = [xmlDoc stringByAppendingFormat:@"\t\t<Key>%@</Key>\n",aSC.searchKey];
        xmlDoc = [xmlDoc stringByAppendingFormat:@"\t\t<SearchInTitleOnly>%@</SearchInTitleOnly>\n",aSC.searchInTitleOnly ? @"true" : @"false"];
        if (aSC.searchCodePostal > 0) {
            xmlDoc = [xmlDoc stringByAppendingFormat:@"\t\t<CodePostal>%d</CodePostal>\n",aSC.searchCodePostal];
        }
        if (aSC.rs) {
            xmlDoc = [xmlDoc stringByAppendingFormat:@"\t\t<RS>%d</RS>\n",aSC.rs];
        }
        if (aSC.me) {
            xmlDoc = [xmlDoc stringByAppendingFormat:@"\t\t<ME>%d</ME>\n",aSC.me];
        }
        
        xmlDoc = [xmlDoc stringByAppendingString:@"\t</SearchCondition>\n"];
    }
    xmlDoc = [xmlDoc stringByAppendingString:@"</Leboncoin>"];
    
    [xmlDoc writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

-(void)beginSchedule {
    
}


-(void)scheduleSearch {
    NSLog(@"%s",__FUNCTION__);
    
    SearchCondition *newSearchCondition = [[SearchCondition alloc] init];
    newSearchCondition.page = 1;
    newSearchCondition.searchCategory = SC_IMAGE_SON;
    newSearchCondition.searchRegion = SL_ILE_DE_FRANCE;
    newSearchCondition.searchKey = @"cabasse";
    
    [self searchAndPostNotification:newSearchCondition];
}

-(NSArray*)search:(SearchCondition*)aCondition {
    
    self.lastSearchTime = [NSDate date]; //update last search
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSString *requestLink = [[SearchLinkGenerator shareSLG] getLinkForCondition:aCondition];
    
    NSLog(@"request link: %@",requestLink);
    
    NSError *errorGetData;
    NSString *content = [NSString stringWithContentsOfURL:[NSURL URLWithString:requestLink] encoding:NSASCIIStringEncoding error:&errorGetData];
    //    content = [self xmlSimpleEscape:content];
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString:content error:&errorGetData];
    
    if (errorGetData) {
        NSLog(@"Error: %@", errorGetData.localizedDescription);
        return nil;
    }
    
    HTMLNode *bodyNode = [parser body];
    NSArray *temp = [bodyNode findChildrenWithAttribute:@"class" matchingName:@"list-lbc" allowPartial:NO];
    
    HTMLNode *foundNode;
    if (temp && temp.count > 0) {
        foundNode = [temp objectAtIndex:0];
    }
    
    if (foundNode) {
//        int i=0;
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"HH:mm";
        
        for (HTMLNode *aNode in [foundNode findChildTags:@"a"]) {
            //annonce title
            NSString *title = [aNode getAttributeNamed:@"title"];
            
            //annonce url
            NSString *link = [aNode getAttributeNamed:@"href"];
            
            
            NSString *annonceId = nil;
            NSRange range1 = [link rangeOfString:@"htm?"];
            NSInteger lastIndexOfId = range1.location - 1;
            
            NSRange range2 = [link rangeOfString:@"/" options:NSBackwardsSearch];
            NSUInteger firstIndexOfId = range2.location + 1;
            
            if (lastIndexOfId > firstIndexOfId) {
                NSRange annonceIdRange = {firstIndexOfId, lastIndexOfId - firstIndexOfId};
                annonceId = [link substringWithRange:annonceIdRange];
            } else {
                NSLog(@"cannot found annonce Id");
                
            }
            
            
            //image url
            NSString *imageLink;
            
            NSArray *imageNodes = [aNode findChildrenWithAttribute:@"class" matchingName:@"image-and-nb" allowPartial:NO];
            if (imageNodes.count == 1) {
                HTMLNode *imageAndNB = [imageNodes objectAtIndex:0];
                
                NSArray *annonceImageNodes = [imageAndNB findChildTags:@"img"];
                
                if (annonceImageNodes.count == 1) {
                    HTMLNode *annonceImageNode = [annonceImageNodes objectAtIndex:0];
                    if (annonceImageNode) {
                        imageLink = [annonceImageNode getAttributeNamed:@"src"];
                    }
                }
            }

            //create ANnonce object
            Annonce *foundAnnonce = [[Annonce alloc] init];
            foundAnnonce.title = title;
            foundAnnonce.linkAnnonce = link;
            foundAnnonce.linkImage = imageLink;
            foundAnnonce.annonceId = annonceId;
            
            //post date
            NSArray *dateNodes = [aNode findChildrenWithAttribute:@"class" matchingName:@"date" allowPartial:NO];
            if (dateNodes && dateNodes.count == 1) {
                HTMLNode *temp = [dateNodes objectAtIndex:0];
                NSArray *detailDateNodes = [temp findChildTags:@"div"];
                
                NSString *dateAnnonceStr = @"";
                NSDate *dateAnnonce = nil ;
                if (detailDateNodes.count == 1) {
                    //today
                    dateAnnonceStr = ((HTMLNode*)[detailDateNodes objectAtIndex:0]).contents;
                } else if (detailDateNodes.count == 2) {
                    //yesterday
                    NSString *dateStr =((HTMLNode*)[detailDateNodes objectAtIndex:1]).contents;
                    if (dateStr) {
                        dateAnnonce = [df dateFromString:dateStr];
                    }
                    dateAnnonceStr = [NSString stringWithFormat:@"(%@) %@",((HTMLNode*)[detailDateNodes objectAtIndex:0]).contents,((HTMLNode*)[detailDateNodes objectAtIndex:1]).contents];
                }
                
                foundAnnonce.dateStr = dateAnnonceStr;
//                NSLog(@"%@: %@",dateAnnonce, title);
            }

            //location
            NSArray *locationNodes = [aNode findChildrenWithAttribute:@"class" matchingName:@"placement" allowPartial:NO];
            if (locationNodes.count == 1) {
                HTMLNode *locationNode = [locationNodes objectAtIndex:0];
                foundAnnonce.location = [locationNode.contents stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                foundAnnonce.location = [foundAnnonce.location stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                foundAnnonce.location = [foundAnnonce.location stringByReplacingOccurrencesOfString:@" " withString:@""];
                foundAnnonce.location = [foundAnnonce.location stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
                foundAnnonce.location = [foundAnnonce.location stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                foundAnnonce.location = [foundAnnonce.location stringByReplacingOccurrencesOfString:@"/" withString:@" / "];
            }
            
            HTMLNode *priceNode = [aNode findChildWithAttribute:@"class" matchingName:@"price" allowPartial:NO];
            if (priceNode) {
                foundAnnonce.price = priceNode.contents;
                foundAnnonce.price = [foundAnnonce.price stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            }
            
            [result addObject:foundAnnonce];
        }
        
        NSLog(@"----------------");
    }
    
    return result;
}

-(void)searchAndPostNotification:(SearchCondition*)aCondition {
    
    
    NSString *requestLink = [[SearchLinkGenerator shareSLG] getLinkForCondition:aCondition];

    NSError *errorGetData;
    NSString *content = [NSString stringWithContentsOfURL:[NSURL URLWithString:requestLink] encoding:NSASCIIStringEncoding error:&errorGetData];
//    content = [self xmlSimpleEscape:content];
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString:content error:&errorGetData];
    
    if (errorGetData) {
        NSLog(@"Error: %@", errorGetData.localizedDescription);
        return;
    }
    
    HTMLNode *bodyNode = [parser body];
    NSArray *temp = [bodyNode findChildrenWithAttribute:@"class" matchingName:@"list-lbc" allowPartial:NO];
    
    HTMLNode *foundNode;
    if (temp && temp.count > 0) {
        foundNode = [temp objectAtIndex:0];
    }
    
    if (foundNode) {
        int i=0;
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"HH:mm";
        
        for (HTMLNode *aNode in [foundNode findChildTags:@"a"]) {
            
            NSString *title = [aNode getAttributeNamed:@"title"];
            
            NSArray *dateNodes = [aNode findChildrenWithAttribute:@"class" matchingName:@"date" allowPartial:NO];
            if (dateNodes && dateNodes.count == 1) {
                HTMLNode *temp = [dateNodes objectAtIndex:0];
                NSArray *detailDateNodes = [temp findChildTags:@"div"];
                
                NSString *dateAnnonceStr = @"";
                NSDate *dateAnnonce = nil ;
                if (detailDateNodes.count == 1) {
                    //today
                    dateAnnonceStr = ((HTMLNode*)[detailDateNodes objectAtIndex:0]).contents;
                } else if (detailDateNodes.count == 2) {
                    //yesterday
                    NSString *dateStr =((HTMLNode*)[detailDateNodes objectAtIndex:1]).contents;
                    if (dateStr) {
                        dateAnnonce = [df dateFromString:dateStr];
                    }
                    dateAnnonceStr = [NSString stringWithFormat:@"(%@) %@",((HTMLNode*)[detailDateNodes objectAtIndex:0]).contents,((HTMLNode*)[detailDateNodes objectAtIndex:1]).contents];
                }
                
                // Set up Local Notifications
                [[UIApplication sharedApplication] cancelAllLocalNotifications];
                UILocalNotification *localNotification = [[UILocalNotification alloc] init];
                NSDate *now = [NSDate date];
                localNotification.fireDate = now;
                localNotification.alertBody = [NSString stringWithFormat:@"%@ %@",dateAnnonce, title];
//                localNotification.soundName = i == 0 ? UILocalNotificationDefaultSoundName : nil;
                i++;
//                localNotification.applicationIconBadgeNumber = [getWeather.currentTemperature intValue];
                [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
                
//                NSLog(@"%@: %@",dateAnnonce, title);
            }
            
            
        }
        
        NSLog(@"----------------");
    }
}

-(void)searchForCondition:(SearchCondition*)aCondition {
    
}

- (NSString *)xmlSimpleEscape:(NSString*)inputStr
{
    NSMutableString *result = [NSMutableString stringWithString:inputStr];
    
    [result replaceOccurrencesOfString:@"&"  withString:@"&amp;"  options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"'"  withString:@"&#x27;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@">"  withString:@"&gt;"   options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"<"  withString:@"&lt;"   options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    
    return result;
}

-(HTMLNode*)searchListAnnonceNode:(HTMLNode*)parentNode {
    NSLog(@"search node: %@",parentNode.tagName);
    if (parentNode.tagName && [parentNode.tagName isEqualToString:@"div"]
        && [parentNode getAttributeNamed:@"class"] != nil
        && [[parentNode getAttributeNamed:@"class"] isEqualToString:@"list-lbc"]
        ) {
        return parentNode;
    }
    
    for (HTMLNode *child in parentNode.children) {
        if (child.contents == nil) {
            continue;
        }
        
        NSLog(@"search child: \n-----\n%@\n-----",child.contents);
        HTMLNode *temp = [self searchListAnnonceNode:child];
        if (temp != nil) {
            return temp;
        }
    }

    NSLog(@"do not found list-lbc");
    return nil;
}

-(CXMLElement*)searchListBC:(CXMLElement*)root {
    if (root == nil) {
        return nil;
    }
    
    if ([root.name isEqualToString:@"div"]
        && [root attributeForName:@"class"] && [[root attributeForName:@"class"].stringValue isEqualToString:@"list-lbc"]
        ) {
        return root;
    }
    
    for (CXMLElement *childElement in root.children) {
        CXMLElement *temp = [self searchListBC:childElement];
        if (temp != nil) {
            return temp;
        }
    }
    
    NSLog(@"does not found list-lbc");
    return nil;
}

#pragma mark Send email to Seller
-(BOOL)sendEmail:(NSString*)message toAnnonce:(Annonce*)anAnnonce fromEmail:(NSString*)email fromName:(NSString*)contactName fromTelephone:(NSString*)telephoneNumber {
    
    BOOL sent = NO;
    
    NSString *key =self.lbcSessionUUID;
    NSString *jsonUrl = [NSString stringWithFormat:@"https://mobile.leboncoin.fr/templates/api/sendmail.json"];
    NSString *postString = [NSString stringWithFormat:@"adreply_body=%@&key=%@&app_id=leboncoin_iphone&email=%@&id=%@&name=%@&phone=%@", message, key,email,  anAnnonce.annonceId, contactName, telephoneNumber == nil ?@"" : telephoneNumber];
    postString = [postString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:jsonUrl]];
    

    
//    [req setValue:message forKey:@"adreply_body"];
//    [req setValue:@"leboncoin_iphone" forKey:@"app_id"];
//    [req setValue:(key == nil ? @"" : key) forKey:@"key"];
//    [req setValue:(email == nil? @"": email) forKey:@"email"];
//    [req setValue:(telephoneNumber == nil ? @"": telephoneNumber) forKey:@"email"];
//    [req setValue:(contactName == nil ? @"" : contactName) forKey:@"name"];
//    [req setValue:anAnnonce.annonceId forKey:@"id"];
    
    [req setHTTPMethod:@"POST"];
    [req setValue:@"Leboncoin/310182 CFNetwork/672.1.12 Darwin/14.0.0" forHTTPHeaderField:@"User-Agent"];
    [req setHTTPBody:postData];
    [req setValue:[NSString stringWithFormat:@"%lu",(unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [req setValue:@"fr/fr" forHTTPHeaderField:@"Accept-Language"];
    [req setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [req setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    
    NSURLResponse *resp;
    NSError *error;
    NSData *annonceContent = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&error];
    
    if (error) {
        NSLog(@"error while getting content: %@",error.localizedDescription);
    }
    
    if (annonceContent) {
        NSString *annonceFilePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"sendMail.tmp"];
        [[NSFileManager defaultManager] removeItemAtPath:annonceFilePath error:nil];
        [annonceContent writeToFile:annonceFilePath atomically:YES];
    }
    
    
    NSString *utf8String =[[NSString alloc] initWithData:annonceContent encoding:NSUTF8StringEncoding];
    NSString *asciiString = [[NSString alloc] initWithData:annonceContent encoding:NSASCIIStringEncoding];
    
    NSLog(@"utf8 annonce: %@",utf8String);
    NSLog(@"ascii annonce: %@",asciiString);
    
    id jsonObject = nil;
    NSInputStream *is = [NSInputStream inputStreamWithData:annonceContent];
    [is open];
    
    jsonObject = [NSJSONSerialization JSONObjectWithStream:is options:NSJSONReadingMutableContainers error:&error];
    
    [is close];
    
    if (jsonObject) {
        error = nil;
        
        NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
        NSString *sendStatus = [jsonDictionary objectForKey:@"status"];

        if (sendStatus!=nil && [sendStatus.lowercaseString isEqualToString:@"ok"]) {
            sent = YES;
        }
    }
    
    NSLog(@"email has been sent: %@",sent ? @"YES" : @"NO");
    return sent;
}
#pragma -


#pragma mark Annonce detail
-(AnnonceDetail*)getAnnonceDetailFromJson:(Annonce*)anAnnonce {
    NSString *key = self.lbcSessionUUID;
    NSString *jsonUrl = [NSString stringWithFormat:@"https://mobile.leboncoin.fr/templates/api/view.json"];
    NSData *postData = [[NSString stringWithFormat:@"ad_id=%@&key=%@&app_id=leboncoin_iphone", anAnnonce.annonceId, key] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:jsonUrl]];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"Leboncoin/310182 CFNetwork/672.1.12 Darwin/14.0.0" forHTTPHeaderField:@"User-Agent"];
    [req setHTTPBody:postData];
    [req setValue:[NSString stringWithFormat:@"%lu",(unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    [req setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [req setValue:@"fr/fr" forHTTPHeaderField:@"Accept-Language"];
    [req setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [req setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    
    NSURLResponse *resp;
    NSError *error;
    NSData *annonceContent = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&error];
    
    if (error) {
        NSLog(@"error while getting content: %@",error.localizedDescription);
    }
    
    if (annonceContent) {
        NSString *annonceFilePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"annonce.tmp"];
        [[NSFileManager defaultManager] removeItemAtPath:annonceFilePath error:nil];
        [annonceContent writeToFile:annonceFilePath atomically:YES];
    }
    
    
    NSString *utf8String =[[NSString alloc] initWithData:annonceContent encoding:NSUTF8StringEncoding];
    NSString *asciiString = [[NSString alloc] initWithData:annonceContent encoding:NSASCIIStringEncoding];
    
    NSLog(@"utf8 annonce: %@",utf8String);
    NSLog(@"ascii annonce: %@",asciiString);
    
    id jsonObject = nil;
    NSInputStream *is = [NSInputStream inputStreamWithData:annonceContent];
    [is open];
    
    jsonObject = [NSJSONSerialization JSONObjectWithStream:is options:NSJSONReadingAllowFragments error:&error];
    
    [is close];
    
    if (jsonObject) {
        error = nil;
        
        
        NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
        NSString *phoneNumer = [jsonDictionary objectForKey:@"phone"];
        NSString *annonceDetail = [jsonDictionary objectForKey:@"body"];
        NSArray *images = [jsonDictionary objectForKey:@"images"];
        
        AnnonceDetail *result = [[AnnonceDetail alloc] init];
        //        result.text = [foundContentNode getAttributeNamed:@"content"];
        result.text = annonceDetail;
        //        NSLog(@"content: %@",foundContentNode.rawContents);
        result.annonceId = anAnnonce.annonceId;
        result.imageLink = images;
        result.telephoneNumber = phoneNumer;
        result.title = [jsonDictionary objectForKey:@"subject"];
        
        NSArray *listParams = [jsonDictionary objectForKey:@"parameters"];
        if (listParams && listParams.count > 0) {
            for (NSDictionary *aParam in listParams) {
                if ([[aParam objectForKey:@"id"] isEqualToString:@"city"]) {
                    result.ville = [aParam objectForKey:@"value"];
                } else if ([[aParam objectForKey:@"id"] isEqualToString:@"zipcode"]) {
                    result.postalCode = [aParam objectForKey:@"value"];
                }
                
            }
        }
        result.priceString = [jsonDictionary objectForKey:@"price_range_formatted"];
        if (result.priceString) {
            result.priceString = [result.priceString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
            result.priceString = [result.priceString stringByReplacingOccurrencesOfString:@"&euro;" withString:@"€"];
        }
        
        result.dateString = [jsonDictionary objectForKey:@"formatted_date"];
        if (result.dateString) {
            result.dateString = [result.dateString stringByReplacingOccurrencesOfString:@"&agrave;" withString:@"à"];
        }
        return result;
    } else if (asciiString!= nil) {
        //special process
        AnnonceDetail *result = [self manualGetDetail:asciiString];
        result.annonceId = anAnnonce.annonceId;
        return result;
    } else {
        return nil;
    }
}

-(AnnonceDetail*)manualGetDetail:(NSString*)annonceContent {
    AnnonceDetail *result = [[AnnonceDetail alloc] init];
    
    //annonce id
    NSUInteger firstIndex = [annonceContent rangeOfString:@"\"list_id\": \""].location + 12;
    NSUInteger lastIndex = [annonceContent rangeOfString:@"\"subject\": \""].location;
    
    if (firstIndex != NSNotFound && lastIndex > firstIndex && lastIndex != NSNotFound) {
        NSRange findRange = {firstIndex, lastIndex - firstIndex};
        result.annonceId = [annonceContent substringWithRange:findRange];
        result.annonceId = [result.annonceId substringToIndex:[result.annonceId rangeOfString:@"\"," options:NSBackwardsSearch].location];
    }
    
    //body:
    firstIndex = [annonceContent rangeOfString:@"\"body\": \""].location + 9;
    lastIndex = [annonceContent rangeOfString:@"\"phone\": \""].location;
    if (lastIndex == NSNotFound) {
        lastIndex = [annonceContent rangeOfString:@"\"date\": \""].location;
    }
    
    if (firstIndex != NSNotFound && lastIndex > firstIndex && lastIndex != NSNotFound) {
        NSRange findRange = {firstIndex, lastIndex - firstIndex};
        result.text = [annonceContent substringWithRange:findRange];
        result.text = [result.text substringToIndex:[result.text rangeOfString:@"\"," options:NSBackwardsSearch].location];
    }

    firstIndex = [annonceContent rangeOfString:@"\"phone\": \""].location + 10;
    lastIndex = [annonceContent rangeOfString:@"\"phonegifs\":"].location;
    
    if (lastIndex > firstIndex && firstIndex > 9) {
        NSRange findRange = {firstIndex, lastIndex - firstIndex};
        result.telephoneNumber = [annonceContent substringWithRange:findRange];
        result.telephoneNumber = [result.telephoneNumber substringToIndex:[result.telephoneNumber rangeOfString:@"\"," options:NSBackwardsSearch].location];
    }
    
    
    firstIndex = [annonceContent rangeOfString:@"\"subject\": \""].location + 12;
    lastIndex = [annonceContent rangeOfString:@"\"body\":"].location;
    
    if (firstIndex != NSNotFound && lastIndex > firstIndex && lastIndex != NSNotFound) {
        NSRange findRange = {firstIndex, lastIndex - firstIndex};
        result.title = [annonceContent substringWithRange:findRange];
        result.title = [result.title substringToIndex:[result.title rangeOfString:@"\"," options:NSBackwardsSearch].location];
    }
    
    firstIndex = [annonceContent rangeOfString:@"\"price\": \""].location + 10;
    lastIndex = [annonceContent rangeOfString:@"\"price_range_formatted\":"].location;
    
    if (firstIndex != NSNotFound && lastIndex > firstIndex && lastIndex != NSNotFound) {
        NSRange findRange = {firstIndex, lastIndex - firstIndex};
        result.priceString = [annonceContent substringWithRange:findRange];
        result.priceString = [result.priceString substringToIndex:[result.priceString rangeOfString:@"\"," options:NSBackwardsSearch].location];
        result.priceString = [result.priceString stringByAppendingString:@" €"];
    }
    
    firstIndex = [annonceContent rangeOfString:@"\"images\": ["].location + 11;
    lastIndex = [annonceContent rangeOfString:@"]" options:NSBackwardsSearch].location;
    
    if (firstIndex != NSNotFound && lastIndex > firstIndex && lastIndex != NSNotFound) {
        NSRange findRange = {firstIndex, lastIndex - firstIndex};
        NSMutableArray *listImageUrl = [[NSMutableArray alloc] init];
        NSString *temp = [annonceContent substringWithRange:findRange];
        temp = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        NSArray *allLinks = [temp componentsSeparatedByString:@","];
        for (NSString *aLink in allLinks) {
            NSString *str = [aLink stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            str = [str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            [listImageUrl addObject:str];
        }
        result.imageLink = listImageUrl;
    }
    
    firstIndex = [annonceContent rangeOfString:@"\"parameters\": ["].location + 15;
    lastIndex = [annonceContent rangeOfString:@"\"images\":"].location;
    
    if (firstIndex != NSNotFound && lastIndex > firstIndex && lastIndex != NSNotFound) {
        NSRange findRange = {firstIndex, lastIndex - firstIndex};
        NSString *temp = [annonceContent substringWithRange:findRange];
        temp = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
        lastIndex = [temp rangeOfString:@"]" options:NSBackwardsSearch].location;
        NSRange range2 = {0, lastIndex};
        temp = [temp substringWithRange:range2];

        
        firstIndex = [temp rangeOfString:@"{"].location ;
        lastIndex = [temp rangeOfString:@"}"].location +1;
        
        NSRange firstParms = {firstIndex, lastIndex - firstIndex};
        NSString *firstJson = [temp substringWithRange:firstParms];
        
        NSError *error;
        id json = [NSJSONSerialization JSONObjectWithData:[firstJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        
        if (json) {
            NSString *idJs = [json objectForKey:@"id"];
            NSString *valueJs = [json objectForKey:@"value"];
            if ([idJs isEqualToString:@"city"]) {
                result.ville = valueJs;
            }
        }
        
        //get last params
        temp = [temp substringFromIndex:lastIndex];
        firstIndex = [temp rangeOfString:@"{"].location ;
        lastIndex = [temp rangeOfString:@"}"].location +1;
        
        
        NSRange secondParam = {firstIndex, lastIndex - firstIndex};
        NSString *secondJson = [temp substringWithRange:secondParam];
        
        json = [NSJSONSerialization JSONObjectWithData:[secondJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
        
        if (json) {
            NSString *idJs = [json objectForKey:@"id"];
            NSString *valueJs = [json objectForKey:@"value"];
            if ([idJs isEqualToString:@"zipcode"] ) {
                result.postalCode = valueJs;
            }
        }
//        
//        
//        
//        
//        NSArray *listParams = [NSJSONSerialization JSONObjectWithData:[temp dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
//        
//        
//        
//        
//        NSArray *allLinks = [temp componentsSeparatedByString:@"\r\n"];
//        for (NSString *aLink in allLinks) {
//            NSString *str = [aLink stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            NSLog(@"get line: %@",str);
//        }
        
    }
    
    //
//    NSArray *listParams = [jsonDictionary objectForKey:@"parameters"];
//    if (listParams && listParams.count > 0) {
//        for (NSDictionary *aParam in listParams) {
//            if ([[aParam objectForKey:@"id"] isEqualToString:@"city"]) {
//                result.ville = [aParam objectForKey:@"value"];
//            }
//            
//            if ([[aParam objectForKey:@"id"] isEqualToString:@"zipcode"]) {
//                result.postalCode = [aParam objectForKey:@"value"];
//            }
//            
//        }
//    }
//    result.priceString = [jsonDictionary objectForKey:@"price_range_formatted"];
//    if (result.priceString) {
//        result.priceString = [result.priceString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
//        result.priceString = [result.priceString stringByReplacingOccurrencesOfString:@"&euro;" withString:@"€"];
//    }
//    
//    result.dateString = [jsonDictionary objectForKey:@"formatted_date"];
//    if (result.dateString) {
//        result.dateString = [result.dateString stringByReplacingOccurrencesOfString:@"&agrave;" withString:@"à"];
//    }
    return result;
    
}

-(AnnonceDetail*)getAnnonceDetail:(Annonce*)anAnnonce {
    if (anAnnonce == nil || anAnnonce.linkAnnonce == nil || [anAnnonce.linkAnnonce isEqualToString:@""]) {
        return nil;
    }
    
    NSData *annonceData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:anAnnonce.linkAnnonce]] returningResponse:nil error:nil];
    if (annonceData == nil) {
        return nil;
    }
    
    NSString *annonceContent = [[NSString alloc] initWithData:annonceData encoding:NSASCIIStringEncoding];
    
    NSRange firstRange = [annonceContent rangeOfString:@"<div class=\"content\">"];
    NSUInteger firstIndex = firstRange.location;
    NSUInteger nextIndex = [[annonceContent substringFromIndex:firstIndex + firstRange.length] rangeOfString:@"</div>"].location;
    
    NSRange aRange = {firstIndex + firstRange.length, nextIndex};
    
    NSString *annonceText = [annonceContent substringWithRange:aRange];
    
//    NSLog(@"ANnonce data: %@",[[NSString alloc] initWithData:annonceData encoding:NSASCIIStringEncoding]);
    
    NSError *errorGetData;
    HTMLParser *parser = [[HTMLParser alloc] initWithData:annonceData error:&errorGetData];
    
    if (errorGetData) {
        NSLog(@"Error: %@", errorGetData.localizedDescription);
        return nil;
    }
    
//    HTMLNode *headNode = [parser head];
    HTMLNode *bodyNode = [parser body];
//    NSLog(@"all page: %@",bodyNode.rawContents);
    NSArray *contentNodes = [bodyNode findChildrenWithAttribute:@"class" matchingName:@"AdviewContent" allowPartial:NO];

    
    NSArray *thumbArrays = [bodyNode findChildrenWithAttribute:@"id" matchingName:@"thumbs_carousel" allowPartial:YES];
    
    //get image
    NSMutableArray *listImage = [[NSMutableArray alloc] init];
    if (thumbArrays != nil && thumbArrays.count > 0) {
        HTMLNode *thumbNodes = [thumbArrays objectAtIndex:0];
        NSArray *listThumbs = [thumbNodes findChildrenWithAttribute:@"class" matchingName:@"thumbs" allowPartial:YES];
        
        for (HTMLNode *aThumbNode in listThumbs) {
//            NSLog(@"thumbNode: %@",aThumbNode.rawContents);
            NSString *link = [aThumbNode getAttributeNamed:@"style"];
            if (link == nil || [link isEqualToString:@""]) {
                continue;
            }
            link = [link stringByReplacingOccurrencesOfString:@"background-image: url('" withString:@""];
            link = [link stringByReplacingOccurrencesOfString:@"');" withString:@""];
            link = [link stringByReplacingOccurrencesOfString:@"thumbs" withString:@"images"];
            [listImage addObject:link];
        }
    } else {
        //search in class="print-lbcImages"
        NSArray *listPrintImage = [bodyNode findChildrenWithAttribute:@"class" matchingName:@"print-image1" allowPartial:NO];
        
        if (listPrintImage && listPrintImage.count > 0) {
            HTMLNode *mainImage = [listPrintImage objectAtIndex:0];
            
            HTMLNode *imgNode = [mainImage findChildTag:@"img"];
            if (imgNode) {
                [listImage addObject:[imgNode getAttributeNamed:@"src"]];
            }
        }
    }
    
    //get id
    NSString *annonceId;
    NSArray *idNodes = [bodyNode findChildrenWithAttribute:@"name" matchingName:@"id" allowPartial:YES];
    if (idNodes && idNodes.count == 1) {
        HTMLNode *idNode = [idNodes objectAtIndex:0];
        annonceId = [idNode getAttributeNamed:@"value"];
    }
    
    //get ville - code postal
    NSString *ville = @"";
    NSString *codePostal = @"";
    NSArray *listLbcParams = [bodyNode findChildrenWithAttribute:@"class" matchingName:@"lbcParams" allowPartial:YES];
    if (listLbcParams.count > 0) {
        NSArray *listTr = [((HTMLNode*)[listLbcParams objectAtIndex:0]) findChildTags:@"tr"];
        for (HTMLNode *aTr in listTr) {
            NSArray *listTh = [aTr findChildTags:@"th"];
            NSArray *listTd = [aTr findChildTags:@"td"];
            if (listTh.count == 1 && listTd.count == 1) {
                HTMLNode *th = [listTh objectAtIndex:0];
                HTMLNode *td = [listTd objectAtIndex:0];
                
//                NSLog(@"check:\n%@ \n and \n%@",th.rawContents, td.rawContents);
                
                if ([th.tagName isEqualToString:@"th"]
                    && [th.contents isEqualToString:@"Ville :"]) {
                    ville = td.contents;
                } else if ([th.tagName isEqualToString:@"th"]
                           && [th.contents isEqualToString:@"Code postal :"]) {
                    codePostal = td.contents;
                }
            }
        }
    }
    
//    NSData *dataPhoneNumber = nil;
//    NSString *phoneNumberLink = [self getPhoneImageLink:annonceId];
//    if (phoneNumberLink) {
//        dataPhoneNumber = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneNumberLink]] returningResponse:nil error:nil];
//        if (dataPhoneNumber) {
//            Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
//            [tesseract setVariableValue:@"0123456789" forKey:@"tessedit_char_whitelist"];
//            [tesseract setImage:[UIImage imageWithData:dataPhoneNumber]];
//            [tesseract recognize];
//            
//            NSLog(@"v: %@ - %@", [Tesseract version],  [tesseract recognizedText]);
//            [tesseract clear];
//        }
//    }
    
    if (contentNodes && contentNodes.count == 1) {
//        HTMLNode *foundContentNode = [contentNodes objectAtIndex:0];
        AnnonceDetail *result = [[AnnonceDetail alloc] init];
//        result.text = [foundContentNode getAttributeNamed:@"content"];
        result.text = annonceText;
//        NSLog(@"content: %@",foundContentNode.rawContents);
        result.annonceId = annonceId;
        result.imageLink = listImage;
//        result.telephoneNumberImageLink = phoneNumberLink;
//        if (dataPhoneNumber) {
//            result.imgPhoneNumber = [UIImage imageWithData:dataPhoneNumber];
//        }
        result.ville = ville;
        result.postalCode = codePostal;
        result.annonceData = annonceData;
        return result;
    } else {
        return nil;
    }
}

-(NSString*)getPhoneImageLink:(NSString*)annonceId {
    if (annonceId == nil || [annonceId isEqualToString:@""]) {
        return nil;
    }
    
    NSString *requestLink = [@"http://www2.leboncoin.fr/ajapi/get/phone?list_id=" stringByAppendingString:annonceId];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestLink]] returningResponse:nil error:nil];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data //1
                          options:kNilOptions
                          error:&error];
    
    NSString *result = [json objectForKey:@"phoneUrl"];
    
    return result;
}

#pragma -

#pragma mark Search Helpers
-(NSString*)getCategoryName:(int)category {
    switch (category) {
        case SC_ALL:
            return @"All Categories";
            break;
        case SC_AUTO:
            return @"Automobiles";
            break;
        case SC_ELECTROMENAGER:
            return @"Electromenager";
            break;
        case SC_MULTIMEDIA:
            return @"Multimedia";
            break;
            
        case SC_INFORMATIQUE:
            return @"Informatique";
            break;
        case SC_IMAGE_SON:
            return @"Image & Son";
            break;
        case SC_TELEPHONE:
            return @"Telephone";
            break;
        case SC_MUSIC:
            return @"Music";
            break;
        default: //all
            return @"All";
            break;
    }
}
-(NSString*)getLocationName:(int)region {
    switch (region) {
        case SL_HAUT_DE_SEINE:
            return @"Haut de Seine" ;
            break;
        case SL_ILE_DE_FRANCE:
            return @"IDF" ;
            break;
        case SL_PARIS:
            return @"Paris" ;
            break;
        case SL_VOISIN_IDF:
            return @"Voisin IdF";
            break;
        case SL_LA_FRANCE:
            return @"La France";
            break;
        default:
            return @"La France";
            break;
    }
}

#pragma -

@end
