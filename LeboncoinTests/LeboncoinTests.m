//
//  LeboncoinTests.m
//  LeboncoinTests
//
//  Created by Duyen Hoa Ha on 20/12/2013.
//  Copyright (c) 2013 Duyen Hoa Ha. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "SearchLinkGenerator.h"
#import "SearchCondition.h"

@interface LeboncoinTests : XCTestCase {
    SearchLinkGenerator *slg;
    
    SearchCondition *mediaOnlySC;
    SearchCondition *withPostalValidSC;
    SearchCondition *withPostalInvalidSC;
    SearchCondition *detailSC;
    SearchCondition *nilSC;
}

@end

@implementation LeboncoinTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    slg = [SearchLinkGenerator shareSLG];
    
    mediaOnlySC = [[SearchCondition alloc] init];
    mediaOnlySC.searchCategory = SC_MULTIMEDIA;
    
    withPostalValidSC = [[SearchCondition alloc] init];
    withPostalValidSC.searchCategory = SC_IMAGE_SON;
    withPostalValidSC.searchCodePostal = 13333;
    
    withPostalInvalidSC = [[SearchCondition alloc] init];
    withPostalInvalidSC.searchCodePostal = 123;
    
    detailSC = [[SearchCondition alloc] init];
    detailSC.searchKey = @"test";
    detailSC.searchCodePostal = 12345;
    detailSC.searchCategory = SC_INFORMATIQUE;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    slg = nil;
    mediaOnlySC = nil;
    withPostalInvalidSC = nil;
    withPostalValidSC  = nil;
    detailSC = nil;
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}


#pragma mark Test SearchLinkGenerator
-(void)testGetJsonLinkForConditionNil {
    NSString *jsonLink = [slg getJsonLinkForCondition:nil];
    NSAssert1(jsonLink != nil && ![jsonLink isEqualToString:@""], @"jsonlink must not be nil", nil);
}

-(void)testGetLinkForConditionNil {
    NSString *nilLink = [slg getLinkForCondition:nilSC];
    NSAssert1(nilLink == nil, @"This <%@> must be nil", nilLink);
}

-(void)testGetLinkForConditionMedia {
    NSString *mediaLink = [slg getLinkForCondition:mediaOnlySC];
    NSAssert1(mediaLink != nil && ![mediaLink isEqualToString:@""], @"MediaLink must not be nil", nil);
    NSAssert1([mediaLink hasPrefix:@"http://www.leboncoin.fr/_multimedia_/offres/"], @"Link <%@> must has prefix 'http://www.leboncoin.fr/_multimedia_/offres/'", mediaLink);
}

-(void)testGetLinkForConditionWithValidCodePostal {
    NSString *link = [slg getLinkForCondition:withPostalValidSC];
    NSAssert1( link != nil && ![link isEqualToString:@""] && [link containsString:@"&location="], @"Link <%@> must  contain '&location='", link);
}

-(void)testGetLinkForConditionWithInvalidCodePostal {
    NSString *link = [slg getLinkForCondition:withPostalInvalidSC];
    NSAssert1( link != nil && ![link isEqualToString:@""] && ![link containsString:@"&location="], @"Link <%@> must not contain '&location='", link);
}

#pragma -

@end
