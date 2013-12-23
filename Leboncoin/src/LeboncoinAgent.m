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

static LeboncoinAgent *_shareAgent;

@implementation LeboncoinAgent

+(LeboncoinAgent*)shareAgent {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareAgent = [[LeboncoinAgent alloc] init];
    });
    return _shareAgent;
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
                NSLog(@"%@: %@",dateAnnonce, title);
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
                
                NSLog(@"%@: %@",dateAnnonce, title);
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
-(AnnonceDetail*)getAnnonceDetail:(Annonce*)anAnnonce {
    if (anAnnonce == nil || anAnnonce.linkAnnonce == nil || [anAnnonce.linkAnnonce isEqualToString:@""]) {
        return nil;
    }
    
    NSData *annonceData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:anAnnonce.linkAnnonce]] returningResponse:nil error:nil];
    if (annonceData == nil) {
        return nil;
    }
    
    NSError *errorGetData;
    HTMLParser *parser = [[HTMLParser alloc] initWithData:annonceData error:&errorGetData];
    
    if (errorGetData) {
        NSLog(@"Error: %@", errorGetData.localizedDescription);
        return nil;
    }
    
    HTMLNode *headNode = [parser head];
//    NSLog(@"all page: %@",bodyNode.rawContents);
    NSArray *contentNodes = [headNode findChildrenWithAttribute:@"name" matchingName:@"description" allowPartial:YES];

    HTMLNode *bodyNode = [parser body];
    NSArray *thumbArrays = [bodyNode findChildrenWithAttribute:@"id" matchingName:@"thumbs_carousel" allowPartial:YES];
    
    //get image
    NSMutableArray *listImage = [[NSMutableArray alloc] init];
    if (thumbArrays != nil && thumbArrays.count > 0) {
        HTMLNode *thumbNodes = [thumbArrays objectAtIndex:0];
        NSArray *listThumbs = [thumbNodes findChildrenWithAttribute:@"class" matchingName:@"thumbs" allowPartial:YES];
        
        for (HTMLNode *aThumbNode in listThumbs) {
            NSLog(@"thumbNode: %@",aThumbNode.rawContents);
            NSString *link = [aThumbNode getAttributeNamed:@"style"];
            if (link == nil || [link isEqualToString:@""]) {
                continue;
            }
            link = [link stringByReplacingOccurrencesOfString:@"background-image: url('" withString:@""];
            link = [link stringByReplacingOccurrencesOfString:@"');" withString:@""];
            link = [link stringByReplacingOccurrencesOfString:@"thumbs" withString:@"images"];
            [listImage addObject:link];
        }
    }
    
    //get id
    NSString *annonceId;
    NSArray *idNodes = [bodyNode findChildrenWithAttribute:@"name" matchingName:@"id" allowPartial:YES];
    if (idNodes && idNodes.count == 1) {
        HTMLNode *idNode = [idNodes objectAtIndex:0];
        annonceId = [idNode getAttributeNamed:@"value"];
    }
    
    if (contentNodes && contentNodes.count == 1) {
        HTMLNode *foundContentNode = [contentNodes objectAtIndex:0];
        NSLog(@"content: %@",foundContentNode);
        AnnonceDetail *result = [[AnnonceDetail alloc] init];
        result.text =[foundContentNode getAttributeNamed:@"content"];
        result.annonceId = annonceId;
        result.imageLink = listImage;
        return result;
    } else {
        return nil;
    }
}

-(NSString*)getPhoneImageLink:(NSString*)annonceId {
    if (annonceId == nil || [annonceId isEqualToString:@""]) {
        return nil;
    }
    
    NSString *requestLink = @"http://www2.leboncoin.fr/ajapi/get/phone?list_id=";
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[requestLink stringByAppendingString:annonceId]]] returningResponse:nil error:nil];
    
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
