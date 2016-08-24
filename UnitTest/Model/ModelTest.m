/*--------------------------------------------------*/

#import <XCTest/XCTest.h>

/*--------------------------------------------------*/

#import "PersonModel.h"

/*--------------------------------------------------*/

@interface ModelTest : XCTestCase {
    NSBundle* _bundle;
}

@end

/*--------------------------------------------------*/

@implementation ModelTest

- (void)setUp {
    [super setUp];
    
    _bundle = [NSBundle bundleForClass:self.class];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testFromJsonDefaultSheme {
    NSURL* jsonUrl = [_bundle URLForResource:@"PersonModel-DefaultSheme" withExtension:@"json"];
    NSData* jsonData = [NSData dataWithContentsOfURL:jsonUrl];
    XCTAssertNotNil(jsonData, @"Failure test file data");
    
    PersonModel* model = [PersonModel modelWithJsonData:jsonData];
    XCTAssertNotNil(model, @"Failure create PersonModel instanse");
    XCTAssertNotNil(model.uid, @"PersonModel::id");
    XCTAssertNotNil(model.firstName, @"PersonModel::firstName");
    XCTAssertNotNil(model.lastName, @"PersonModel::lastName");
}

- (void)testToJsonDefaultSheme {
    NSURL* jsonUrl = [_bundle URLForResource:@"PersonModel-DefaultSheme" withExtension:@"json"];
    NSData* jsonData = [NSData dataWithContentsOfURL:jsonUrl];
    XCTAssertNotNil(jsonData, @"Failure test file data");
    
    PersonModel* originModel = [PersonModel modelWithJsonData:jsonData];
    XCTAssertNotNil(originModel, @"Failure create PersonModel instanse");
    
    NSDictionary* json = [originModel toJson];
    XCTAssertNotNil(json, @"Failure PersonModel toJson");
    
    PersonModel* jsonModel = [PersonModel modelWithJson:json];
    XCTAssertTrue([jsonModel.uid isEqualToString:originModel.uid], @"Json::uid");
    XCTAssertTrue([jsonModel.firstName isEqualToString:originModel.firstName], @"Json::firstName");
    XCTAssertTrue([jsonModel.lastName isEqualToString:originModel.lastName], @"Json::lastName");
}

- (void)testFromJsonCustomSheme {
    NSURL* jsonUrl = [_bundle URLForResource:@"PersonModel-CustomSheme" withExtension:@"json"];
    NSData* jsonData = [NSData dataWithContentsOfURL:jsonUrl];
    XCTAssertNotNil(jsonData, @"Failure test file data");
    
    PersonModel* model = [PersonModel modelWithJsonData:jsonData sheme:ModelCustomSheme];
    XCTAssertNotNil(model, @"Failure create PersonModel instanse");
    XCTAssertNotNil(model.uid, @"PersonModel::id");
    XCTAssertNotNil(model.firstName, @"PersonModel::firstName");
    XCTAssertNotNil(model.lastName, @"PersonModel::lastName");
}

- (void)testToJsonCustomSheme {
    NSURL* jsonUrl = [_bundle URLForResource:@"PersonModel-CustomSheme" withExtension:@"json"];
    NSData* jsonData = [NSData dataWithContentsOfURL:jsonUrl];
    XCTAssertNotNil(jsonData, @"Failure test file data");
    
    PersonModel* originModel = [PersonModel modelWithJsonData:jsonData sheme:ModelCustomSheme];
    XCTAssertNotNil(originModel, @"Failure create PersonModel instanse");
    
    NSDictionary* json = [originModel toJson:ModelCustomSheme];
    XCTAssertNotNil(json, @"Failure PersonModel toJson");
    
    PersonModel* jsonModel = [PersonModel modelWithJson:json sheme:ModelCustomSheme];
    XCTAssertTrue([jsonModel.uid isEqualToString:originModel.uid], @"Json::uid");
    XCTAssertTrue([jsonModel.firstName isEqualToString:originModel.firstName], @"Json::firstName");
    XCTAssertTrue([jsonModel.lastName isEqualToString:originModel.lastName], @"Json::lastName");
}

- (void)testSerialize {
    NSURL* jsonUrl = [_bundle URLForResource:@"PersonModel-DefaultSheme" withExtension:@"json"];
    NSData* jsonData = [NSData dataWithContentsOfURL:jsonUrl];
    XCTAssertNotNil(jsonData, @"Failure test file data");
    
    PersonModel* originModel = [PersonModel modelWithJsonData:jsonData];
    XCTAssertNotNil(originModel, @"Failure create PersonModel instanse");
    
    NSData* archivedData = [NSKeyedArchiver archivedDataWithRootObject:originModel];
    XCTAssertTrue(archivedData.length > 0, @"Serialize::Data");
    
    PersonModel* unarchivedModel = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
    XCTAssertTrue([unarchivedModel.uid isEqualToString:originModel.uid], @"Serialize::uid");
    XCTAssertTrue([unarchivedModel.firstName isEqualToString:originModel.firstName], @"Serialize::firstName");
    XCTAssertTrue([unarchivedModel.lastName isEqualToString:originModel.lastName], @"Serialize::lastName");
}

- (void)testPack {
    NSURL* jsonUrl = [_bundle URLForResource:@"PersonModel-DefaultSheme" withExtension:@"json"];
    NSData* jsonData = [NSData dataWithContentsOfURL:jsonUrl];
    XCTAssertNotNil(jsonData, @"Failure test file data");
    
    PersonModel* originModel = [PersonModel modelWithJsonData:jsonData];
    XCTAssertNotNil(originModel, @"Failure create PersonModel instanse");
    
    NSData* packData = [originModel packData];
    XCTAssertTrue(packData.length > 0, @"Pack::Data");
    
    PersonModel* packModel = [PersonModel modelWithPackData:packData];
    XCTAssertTrue([packModel.uid isEqualToString:originModel.uid], @"Pack::uid");
    XCTAssertTrue([packModel.firstName isEqualToString:originModel.firstName], @"Pack::firstName");
    XCTAssertTrue([packModel.lastName isEqualToString:originModel.lastName], @"Pack::lastName");
}

@end

/*--------------------------------------------------*/
