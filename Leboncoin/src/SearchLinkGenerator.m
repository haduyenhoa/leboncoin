//
//  SearchLinkGenerator.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 21/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import "SearchLinkGenerator.h"
#import "SearchCondition.h"
static SearchLinkGenerator *_shareSLG;
@implementation SearchLinkGenerator

+(SearchLinkGenerator*)shareSLG {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareSLG = [[SearchLinkGenerator alloc] init];
    });
    return _shareSLG;
}

-(NSString*)getLinkForCondition:(SearchCondition*)aCondition {
    if (aCondition == nil) {
        return nil;
    }
    NSString *result = @"";
    switch (aCondition.searchCategory) {
        case SC_MULTIMEDIA:
        {
            result = @"http://www.leboncoin.fr/_multimedia_/offres/";
        }
            break;
            
        case SC_INFORMATIQUE:
        {
            result = @"http://www.leboncoin.fr/informatique/offres/";
        }
            break;
        case SC_IMAGE_SON:
        {
            result = @"http://www.leboncoin.fr/image_son/offres/";
        }
            break;
        case SC_TELEPHONE:
        {
            result = @"http://www.leboncoin.fr/telephonie/offres/";
        }
            break;
            
        default:
        {
            //ALL
            result = @"http://www.leboncoin.fr/annonces/offres/";
        }
            break;
    }
    
    result = [result stringByAppendingString:@"ile_de_france/"]; //search with ile de france
    
    switch (aCondition.searchRegion) {
        case SL_ILE_DE_FRANCE:
        {
            //add nothing
        }
            break;
        case SL_HAUT_DE_SEINE:
        {
            result = [result stringByAppendingString:@"hauts_de_seine/"];
        }
            break;
        case SL_PARIS:
        {
            result = [result stringByAppendingString:@"paris/"];
        }
            break;
            
        default: {
            //la france
            result = [result stringByAppendingString:@"occasions/"];
        }
            break;
    }
    
    
    if (aCondition.page > 1) {
        result = [result stringByAppendingFormat:@"?o=%d",aCondition.page];
    } else {
        result = [result stringByAppendingFormat:@"?f=a&th=1"];
    }
    
    //only search in title
    result = [result stringByAppendingString:@"&it=1"];
    
    //search key &q=
    if (aCondition.searchKey) {
        result = [result stringByAppendingFormat:@"&q=%@",aCondition.searchKey];
    }
    
    if (aCondition.searchCodePostal > 9999) { //code postale France has 5 digits
        result = [result stringByAppendingFormat:@"&location=%d",aCondition.searchCodePostal];
    }
    
    return result;
}

@end
