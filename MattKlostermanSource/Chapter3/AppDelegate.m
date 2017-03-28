//
//  AppDelegate.m
//  Chapter3
//

#import "AppDelegate.h"

#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()

@property (nonatomic,strong) CLLocationManager *manager;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    [manager requestAlwaysAuthorization];
    self.manager = manager;
}

@end
