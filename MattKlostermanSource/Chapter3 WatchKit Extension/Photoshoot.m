//
//  Photoshoot.m
//  Chapter3

#import "Photoshoot.h"
#import "ShotInformation.h"

@implementation Photoshoot

- (instancetype)initWithDictionary:(NSDictionary *)data
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.locationName = data[@"locationName"];
    self.locationCoordinate = CLLocationCoordinate2DMake([data[@"locationCoordinate"][@"latitude"] doubleValue], [data[@"locationCoordinate"][@"longitude"] doubleValue]);
    self.locationBeacon = [[NSUUID alloc] initWithUUIDString:data[@"locationBeacon"]];
    
    self.beginTime = [self dateForRFC3339DateTimeString:data[@"beginTime"]] ?: [NSDate distantPast];
    self.endTime = [self dateForRFC3339DateTimeString:data[@"endTime"]] ?: [NSDate distantPast];
    self.shootDescription = data[@"shootDescription"];
    self.projectDescription = data[@"projectDescription"];
    self.clientContactName = data[@"clientContactName"];
    
    NSMutableArray *plannedShots = [NSMutableArray array];
    
    [data[@"plannedShots"] enumerateObjectsUsingBlock:^(NSDictionary *shotData, NSUInteger idx, BOOL *stop) {
        ShotInformation *shot = [[ShotInformation alloc]initWithDictionary:shotData];
        [plannedShots addObject:shot];
    }];
    
    self.plannedShots = plannedShots;
    
    return self;
}

// Modified example code from https://developer.apple.com/library/ios/qa/qa1480/_index.html
- (NSDate *)dateForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString
// Returns a user-visible date time string that corresponds to the
// specified RFC 3339 date time string. Note that this does not handle
// all possible RFC 3339 date time strings, just one of the most common
// styles.
{
    static NSDateFormatter *    sRFC3339DateFormatter;
    NSString *                  userVisibleDateTimeString;
    NSDate *                    date;
    
    // If the date formatters aren't already set up, do that now and cache them
    // for subsequence reuse.
    
    if (sRFC3339DateFormatter == nil) {
        NSLocale *                  enUSPOSIXLocale;
        
        sRFC3339DateFormatter = [[NSDateFormatter alloc] init];
        
        enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        
        [sRFC3339DateFormatter setLocale:enUSPOSIXLocale];
        [sRFC3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [sRFC3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }

    // Convert the RFC 3339 date time string to an NSDate.
    // Then convert the NSDate to a user-visible date string.
    
    userVisibleDateTimeString = nil;
    
    date = [sRFC3339DateFormatter dateFromString:rfc3339DateTimeString];
   
    return date;
}

@end
