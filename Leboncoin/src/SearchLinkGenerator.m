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

-(NSString*)getJsonLinkForCondition:(SearchCondition*)aCondition {
    return @"https://mobile.leboncoin.fr/templates/api/view.json";
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
        case SC_ELECTROMENAGER:
        {
            result = @"http://www.leboncoin.fr/electromenager/offres/";
        }
            break;
        case SC_EQUIPEMENT_AUTO:
        {
            result = @"http://www.leboncoin.fr/equipement_auto/offres/";
        }
            break;
        case SC_MUSIC:
        {
            result = @"http://www.leboncoin.fr/cd_musique/offres/";
        }
            break;
        case SC_AUTO:
        {
            result = @"http://www.leboncoin.fr/voitures/offres/";
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
        case SL_VOISIN_IDF:
        {
            result = [result stringByAppendingString:@"bonnes_affaires/"];
        }
            break;
            
        default: {
            //la france
            result = [result stringByAppendingString:@"occasions/"];
        }
            break;
    }
    
    
    if (aCondition.page > 1) {
        result = [result stringByAppendingFormat:@"?f=p&o=%d",aCondition.page];
    } else {
        result = [result stringByAppendingFormat:@"?f=p&th=1"];
    }
    
    //only search in title
    if (aCondition.searchInTitleOnly) {
        result = [result stringByAppendingString:@"&it=1"];
    }

    
    //search key &q=
    if (aCondition.searchKey) {
        result = [result stringByAppendingFormat:@"&q=%@", [self htmlEncode:aCondition.searchKey]];
    }
    
    if (aCondition.searchCodePostal > 9999) { //code postale France has 5 digits
        result = [result stringByAppendingFormat:@"&location=%d",aCondition.searchCodePostal];
    }
    
    if (aCondition.rs > 0) {
        result = [result stringByAppendingFormat:@"&rs=%d",aCondition.rs];
    }
    
    if (aCondition.me > 0) {
        result = [result stringByAppendingFormat:@"&me=%d",aCondition.me];
    }
    
    return result;
}

-(NSString*)htmlEncode:(NSString*)input {
    return [input stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
}

@end
