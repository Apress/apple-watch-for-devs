//
//  Photoshoot.h
//  Chapter3

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Photoshoot : NSObject

@property (nonatomic,strong) NSString *locationName;
@property (nonatomic,assign) CLLocationCoordinate2D locationCoordinate;
@property (nonatomic,strong) NSUUID *locationBeacon;

@property (nonatomic,strong) NSDate *beginTime;
@property (nonatomic,strong) NSDate *endTime;

@property (nonatomic,strong) NSString *shootDescription;
@property (nonatomic,strong) NSString *projectDescription;

@property (nonatomic,strong) NSString *clientContactName;

@property (nonatomic,strong) NSArray *plannedShots;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary NS_DESIGNATED_INITIALIZER;

@end
