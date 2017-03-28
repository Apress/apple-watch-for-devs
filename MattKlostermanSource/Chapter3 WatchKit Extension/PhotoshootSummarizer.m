//
//  PhotoshootSummarizer.m
//  Chapter3
//

#import "PhotoshootSummarizer.h"

#import "Photoshoot.h"
#import "ShotInformation.h"
#import "PhotoshootLocationManager.h"

@implementation PhotoshootSummarizer

+ (instancetype)sharedManager {
    static dispatch_once_t pred;
    static PhotoshootSummarizer *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[[self class] alloc] init];
        [shared registerForNotifications];
    });
    return shared;
}

- (void)registerForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLocationUpdate:) name:@"PhootshootLocationChange" object:nil];
}

- (void)unregisterForNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    [self unregisterForNotifications];
}

- (void)handleLocationUpdate:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PhotoshootSummaryChanged" object:nil];
}

+ (NSDictionary *)currentSummaryInformation:(NSArray *)photoshoots
{
    // Behind the scenes we'll instantiate an instance of PhotoshootSummarizer that monitors data that can affect summaries
    [self sharedManager];

    Photoshoot *mostRelevantShoot = [self mostRelevantShoot:photoshoots];
    
    // If there isn't a relevant shoot we'll return an information summary
    if (mostRelevantShoot) {
        CLLocation *currentUserLocation = [[PhotoshootLocationManager sharedManager] lastLocation];
        
        CLCircularRegion *testRegion = [[CLCircularRegion alloc] initWithCenter:currentUserLocation.coordinate radius:5000 identifier:@"CurrentUserRegion"];
        
        if ([testRegion containsCoordinate:mostRelevantShoot.locationCoordinate]) {
            return [self summaryInformationForOnLocationShoot:mostRelevantShoot];
        } else {
            return [self summaryInformationForShoot:mostRelevantShoot];
        }
    }
    
    return [self summaryInformationForNoRelevantShoot];
}

+ (Photoshoot *)mostRelevantShoot:(NSArray *)shoots
{
    // Initial rule: the most relevant shoot is the soonest to occur.
    // Future rules could be added e.g. a shoot that is nearby is more
    // relevant than one schedule to happen soon
    return [shoots firstObject];
}

+ (NSDictionary *)summaryInformationForNoRelevantShoot
{
    return @{
             @"line1" : @"No photoshoots scheduled",
             };
}

+ (NSDictionary *)summaryInformationForOnLocationShoot:(Photoshoot *)shoot
{
    __block NSInteger completedShots = 0;
    [shoot.plannedShots enumerateObjectsUsingBlock:^(ShotInformation *shot, NSUInteger idx, BOOL *stop) {
        if ([shot hasBeenCompleted]) {
            completedShots++;
        }
    }];
    
    NSInteger remainingShots = [shoot.plannedShots count] - completedShots;
    
    return @{
             @"line1" : shoot.locationName,
             @"line2" : @"#countdown#",
             @"line3" : shoot.clientContactName,
             @"line4" : [NSString stringWithFormat:@"%td shots remaining", remainingShots],
             @"relevantStart" : shoot.beginTime,
             @"relevantEnd" : shoot.endTime,
             @"onLocation" : @YES,
             @"relevantShoot" : shoot,
             };
}

+ (NSDictionary *)summaryInformationForShoot:(Photoshoot *)shoot
{
    return @{
             @"line1" : shoot.locationName,
             @"line2" : @"#countdown#",
             @"line3" : shoot.shootDescription,
             @"line4" : shoot.projectDescription,
             @"relevantStart" : shoot.beginTime,
             @"relevantEnd" : shoot.endTime,
             @"onLocation" : @NO,
             @"relevantShoot" : shoot,
             };
}

@end
