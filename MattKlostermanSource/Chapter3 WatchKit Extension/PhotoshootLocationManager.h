//
//  PhotoshootLocationManager.h
//  Chapter3
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface PhotoshootLocationManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic,strong) CLLocation *lastLocation;

@end
