//
//  LeboncoinAgent.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 20/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import "LeboncoinAgent.h"

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
    [self searchAndPostNotification];
}

-(void)searchAndPostNotification {
    NSString *requestLink = @"http://www.leboncoin.fr/image_son/offres/ile_de_france/occasions/?f=a&th=1&q=cabasse&it=1";

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
@end
