//
//  PhotoshootLocationManager.m
//  Chapter3
//

#import "PhotoshootLocationManager.h"

@interface PhotoshootLocationManager () <CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *manager;

@end

@implementation PhotoshootLocationManager

+ (instancetype)sharedManager {
    static dispatch_once_t pred;
    static PhotoshootLocationManager *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[[self class] alloc] init];
        
        shared->_manager = [[CLLocationManager alloc] init];
        [shared->_manager setDelegate:shared];
        [shared->_manager startUpdatingLocation];
    });
    return shared;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.lastLocation = [locations lastObject];
}

- (void)setLastLocation:(CLLocation *)lastLocation
{
    BOOL changed = !(_lastLocation.coordinate.latitude == lastLocation.coordinate.latitude &&
                     _lastLocation.coordinate.longitude == lastLocation.coordinate.longitude);

    _lastLocation = lastLocation;

    if (changed) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PhootshootLocationChange" object:nil userInfo:@{@"newLocation": lastLocation}];
    }
}

@end
