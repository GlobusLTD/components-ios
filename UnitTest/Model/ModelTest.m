/*--------------------------------------------------*/

#import <XCTest/XCTest.h>

/*--------------------------------------------------*/

#import "PersonModel+Private.h"

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

- (void)testDefaults {
    PersonModel* emptyModel = [PersonModel new];
    XCTAssertTrue([emptyModel.uid isEqualToString:@"Unknown"], @"Failure default PersonModel.uid");
    XCTAssertTrue([emptyModel.firstName isEqualToString:@"Alex"], @"Failure default PersonModel.firstName");
    XCTAssertNil(emptyModel.lastName, @"Failure default PersonModel.lastName");
    
    PersonModel* copyModel = [emptyModel copy];
    XCTAssertTrue([copyModel.uid isEqualToString:@"Unknown"], @"Failure default PersonModel.uid");
    XCTAssertTrue([copyModel.firstName isEqualToString:@"Alex"], @"Failure default PersonModel.firstName");
    XCTAssertNil(copyModel.lastName, @"Failure default PersonModel.lastName");
    
    PersonModel* jsonModel = [[PersonModel alloc] initWithJson:nil];
    XCTAssertTrue([jsonModel.uid isEqualToString:@"Unknown"], @"Failure default PersonModel.uid");
    XCTAssertTrue([jsonModel.firstName isEqualToString:@"Alex"], @"Failure default PersonModel.firstName");
    XCTAssertNil(jsonModel.lastName, @"Failure default PersonModel.lastName");
    
    PersonModel* loadModel = [[PersonModel alloc] initWithStoreName:@"Test" userDefaults:nil];
    XCTAssertTrue([loadModel.uid isEqualToString:@"Unknown"], @"Failure default PersonModel.uid");
    XCTAssertTrue([loadModel.firstName isEqualToString:@"Alex"], @"Failure default PersonModel.firstName");
    XCTAssertNil(loadModel.lastName, @"Failure default PersonModel.lastName");
    
    NSData* archivedData = [NSKeyedArchiver archivedDataWithRootObject:jsonModel];
    XCTAssertTrue(archivedData.length > 0, @"Serialize::Data");
    
    PersonModel* unarchivedModel = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
    XCTAssertTrue([unarchivedModel.uid isEqualToString:@"Unknown"], @"Failure default PersonModel.uid");
    XCTAssertTrue([unarchivedModel.firstName isEqualToString:@"Alex"], @"Failure default PersonModel.firstName");
    XCTAssertNil(unarchivedModel.lastName, @"Failure default PersonModel.lastName");
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

- (void)testSave {
    PersonModel* model = [PersonModel new];
    XCTAssertNotNil(model, @"Failure create PersonModel instanse");
    model.storeName = PersonModel.glb_className;
    
    if([model save] == YES) {
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        for(NSUInteger i = 0; i < 10000; i++) {
            [self save:model uid:[NSString stringWithFormat:@"%d", (int)i] group:group queue:queue];
        }
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    } else {
        XCTFail(@"Save");
    }
}

- (void)save:(PersonModel*)model uid:(NSString*)uid group:(dispatch_group_t)group queue:(dispatch_queue_t)queue {
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        model.uid = uid;
        [model saveQueue:queue success:^{
            dispatch_group_leave(group);
        } failure:^{
            XCTFail(@"Save::%@", uid);
            dispatch_group_leave(group);
        }];
    });
}

@end

/*--------------------------------------------------*/
