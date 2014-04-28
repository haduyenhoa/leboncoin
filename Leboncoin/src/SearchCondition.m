//
//  SearchCondition.m
//  Leboncoin
//
//  Created by Duyen Hoa Ha on 21/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import "SearchCondition.h"

@implementation SearchCondition

-(id)init {
    self = [super init];
    if (self) {
        self.uuid = [self uuidString];
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

-(NSString*)getCategoryName {
    switch (self.searchCategory) {
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
            
        default: //all
            return @"All";
            break;
    }
}
-(NSString*)getLocationName {
    switch (self.searchRegion) {
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
        default:
            return @"La France";
            break;
    }
}

@end
