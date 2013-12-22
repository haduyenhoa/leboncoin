//
//  SearchLinkGenerator.h
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 21/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchCondition;
@interface SearchLinkGenerator : NSObject

+(SearchLinkGenerator*)shareSLG;

-(NSString*)getLinkForCondition:(SearchCondition*)aCondition;

@end
