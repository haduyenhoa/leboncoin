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

#import "Tesseract.h"

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

        
        //create an annonce
        SearchCondition *cabasseCondition = [[SearchCondition alloc] init];
        cabasseCondition.page = 1;
        cabasseCondition.searchCategory = SC_IMAGE_SON;
        cabasseCondition.searchRegion = SL_LA_FRANCE;
        cabasseCondition.searchKey = @"cabasse";
        
        SearchCondition *tannoyCondition = [[SearchCondition alloc] init];
        tannoyCondition.page = 1;
        tannoyCondition.searchCategory = SC_IMAGE_SON;
        tannoyCondition.searchRegion = SL_LA_FRANCE;
        tannoyCondition.searchKey = @"tannoy";
        
        SearchCondition *thielCondition = [[SearchCondition alloc] init];
        thielCondition.page = 1;
        thielCondition.searchCategory = SC_IMAGE_SON;
        thielCondition.searchRegion = SL_LA_FRANCE;
        thielCondition.searchKey = @"thiel";
        
        SearchCondition *sansuiCondition = [[SearchCondition alloc] init];
        sansuiCondition.page = 1;
        sansuiCondition.searchCategory = SC_IMAGE_SON;
        sansuiCondition.searchRegion = SL_LA_FRANCE;
        sansuiCondition.searchKey = @"sansui";
        
        SearchCondition *regaCondition = [[SearchCondition alloc] init];
        regaCondition.page = 1;
        regaCondition.searchCategory = SC_IMAGE_SON;
        regaCondition.searchRegion = SL_LA_FRANCE;
        regaCondition.searchKey = @"rega";
        
        SearchCondition *linnCondition = [[SearchCondition alloc] init];
        linnCondition.page = 1;
        linnCondition.searchCategory = SC_IMAGE_SON;
        linnCondition.searchRegion = SL_LA_FRANCE;
        linnCondition.searchKey = @"linn";
        
        SearchCondition *aristonCondition = [[SearchCondition alloc] init];
        aristonCondition.page = 1;
        aristonCondition.searchCategory = SC_IMAGE_SON;
        aristonCondition.searchRegion = SL_LA_FRANCE;
        aristonCondition.searchKey = @"ariston";
        
        SearchCondition *transcriptorCondition = [[SearchCondition alloc] init];
        transcriptorCondition.page = 1;
        transcriptorCondition.searchCategory = SC_IMAGE_SON;
        transcriptorCondition.searchRegion = SL_LA_FRANCE;
        transcriptorCondition.searchKey = @"transcriptor";
        
        SearchCondition *michellCondition = [[SearchCondition alloc] init];
        michellCondition.page = 1;
        michellCondition.searchCategory = SC_IMAGE_SON;
        michellCondition.searchRegion = SL_LA_FRANCE;
        michellCondition.searchKey = @"michell";
        
        SearchCondition *mcintoshCondition = [[SearchCondition alloc] init];
        mcintoshCondition.page = 1;
        mcintoshCondition.searchCategory = SC_IMAGE_SON;
        mcintoshCondition.searchRegion = SL_LA_FRANCE;
        mcintoshCondition.searchKey = @"mcintosh";
        
        SearchCondition *iphone5sCondition = [[SearchCondition alloc] init];
        iphone5sCondition.page = 1;
        iphone5sCondition.searchCategory = SC_TELEPHONE;
        iphone5sCondition.searchRegion = SL_ILE_DE_FRANCE;
        iphone5sCondition.searchKey = @"iphone 5s";
        
        SearchCondition *tomtoGoCondition = [[SearchCondition alloc] init];
        tomtoGoCondition.page = 1;
        tomtoGoCondition.searchCategory = SC_EQUIPEMENT_AUTO;
        tomtoGoCondition.searchRegion = SL_ILE_DE_FRANCE;
        tomtoGoCondition.searchKey = @"tomtom go";
        
        SearchCondition *dysonSearch = [[SearchCondition alloc] init];
        dysonSearch.page = 1;
        dysonSearch.searchCategory = SC_ELECTROMENAGER;
        dysonSearch.searchRegion = SL_LA_FRANCE;
        dysonSearch.searchKey = @"dyson";
        
        SearchCondition *demenagementCondition = [[SearchCondition alloc] init];
        demenagementCondition.page = 1;
        demenagementCondition.searchCategory = SC_IMAGE_SON;
        demenagementCondition.searchRegion = SL_LA_FRANCE;
        demenagementCondition.searchKey = @"demenagement";
        
        SearchCondition *demenagementAllCatCondition = [[SearchCondition alloc] init];
        demenagementAllCatCondition.page = 1;
        demenagementAllCatCondition.searchCategory = SC_ALL;
        demenagementAllCatCondition.searchRegion = SL_LA_FRANCE;
        demenagementAllCatCondition.searchKey = @"demenagement";
        
        SearchCondition *neilYoungCondition = [[SearchCondition alloc] init];
        neilYoungCondition.page = 1;
        neilYoungCondition.searchCategory = SC_MUSIC;
        neilYoungCondition.searchRegion = SL_LA_FRANCE;
        neilYoungCondition.searchKey = @"neil young";
        
        SearchCondition *ericClaptonCondition = [[SearchCondition alloc] init];
        ericClaptonCondition.page = 1;
        ericClaptonCondition.searchCategory = SC_MUSIC;
        ericClaptonCondition.searchRegion = SL_LA_FRANCE;
        ericClaptonCondition.searchKey = @"eric clapton";
        
        SearchCondition *vinylesCondition = [[SearchCondition alloc] init];
        vinylesCondition.page = 1;
        vinylesCondition.searchCategory = SC_MUSIC;
        vinylesCondition.searchRegion = SL_LA_FRANCE;
        vinylesCondition.searchKey = @"vinyles";
        
        self.searchConditions = [NSArray arrayWithObjects:cabasseCondition, thielCondition, tannoyCondition, regaCondition, michellCondition, demenagementCondition, dysonSearch, sansuiCondition, iphone5sCondition, mcintoshCondition, transcriptorCondition, aristonCondition, linnCondition, tomtoGoCondition, demenagementAllCatCondition, neilYoungCondition, ericClaptonCondition, vinylesCondition, nil];
    }
    return self;
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
            int lastIndexOfId = range1.location - 1;
            
            NSRange range2 = [link rangeOfString:@"/" options:NSBackwardsSearch];
            int firstIndexOfId = range2.location + 1;
            
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

#pragma mark Annonce detail
-(AnnonceDetail*)getAnnonceDetailFromJson:(Annonce*)anAnnonce {
    NSString *key = @"2a4ff69a2b654dd219568ca6942beefa49c8dde0";
    NSString *jsonUrl = [NSString stringWithFormat:@"https://mobile.leboncoin.fr/templates/api/view.json"];
    NSData *postData = [[NSString stringWithFormat:@"ad_id=%@&key=%@&app_id=leboncoin_iphone", anAnnonce.annonceId, key] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:jsonUrl]];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"Leboncoin/310182 CFNetwork/672.1.12 Darwin/14.0.0" forHTTPHeaderField:@"User-Agent"];
    [req setHTTPBody:postData];
    [req setValue:[NSString stringWithFormat:@"%d",postData.length] forHTTPHeaderField:@"Content-Length"];
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
        NSString *annonceFilePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"annonce.tmp"];
        [[NSFileManager defaultManager] removeItemAtPath:annonceFilePath error:nil];
        [annonceContent writeToFile:annonceFilePath atomically:YES];
    }
    
    
    NSString *utf8String =[[NSString alloc] initWithData:annonceContent encoding:NSUTF8StringEncoding];
    NSString *asciiString = [[NSString alloc] initWithData:annonceContent encoding:NSASCIIStringEncoding];
    
    NSLog(@"utf8 annonce: %@",utf8String);
    NSLog(@"ascii annonce: %@",asciiString);
    
    id jsonObject = nil;
//    NSData *jsonData = nil;
//    if (utf8String != nil) {
//        jsonObject = [NSJSONSerialization JSONObjectWithData:annonceContent options:NSJSONReadingAllowFragments error:&error];
//    } else if (asciiString != nil) {
//        jsonData = [asciiString dataUsingEncoding:NSASCIIStringEncoding];
//        
//        jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
//    } else {
//        NSLog(@"unknown string encoding");
//    }
//
    NSInputStream *is = [NSInputStream inputStreamWithData:annonceContent];
    [is open];
    
    jsonObject = [NSJSONSerialization JSONObjectWithStream:is options:NSJSONReadingMutableContainers error:&error];
    
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
                }
                
                if ([[aParam objectForKey:@"id"] isEqualToString:@"zipcode"]) {
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
    
    //body:
    NSUInteger firstIndex = [annonceContent rangeOfString:@"\"body\": \""].location + 9;
    NSUInteger lastIndex = [annonceContent rangeOfString:@"\"phone\": \""].location;
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
    
    HTMLNode *headNode = [parser head];
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
    
    NSData *dataPhoneNumber = nil;
    NSString *phoneNumberLink = [self getPhoneImageLink:annonceId];
    if (phoneNumberLink) {
        dataPhoneNumber = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phoneNumberLink]] returningResponse:nil error:nil];
        if (dataPhoneNumber) {
            Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
            [tesseract setVariableValue:@"0123456789" forKey:@"tessedit_char_whitelist"];
            [tesseract setImage:[UIImage imageWithData:dataPhoneNumber]];
            [tesseract recognize];
            
            NSLog(@"v: %@ - %@", [Tesseract version],  [tesseract recognizedText]);
            [tesseract clear];
        }
    }
    
    if (contentNodes && contentNodes.count == 1) {
        HTMLNode *foundContentNode = [contentNodes objectAtIndex:0];
        AnnonceDetail *result = [[AnnonceDetail alloc] init];
//        result.text = [foundContentNode getAttributeNamed:@"content"];
        result.text = annonceText;
//        NSLog(@"content: %@",foundContentNode.rawContents);
        result.annonceId = annonceId;
        result.imageLink = listImage;
        result.telephoneNumberImageLink = phoneNumberLink;
        if (dataPhoneNumber) {
            result.imgPhoneNumber = [UIImage imageWithData:dataPhoneNumber];
        }
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

@end
