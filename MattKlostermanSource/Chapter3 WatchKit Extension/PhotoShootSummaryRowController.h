//
//  PhotoShootSummaryRowController.h
//  Chapter3
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface PhotoShootSummaryRowController : NSObject

- (void)setLocationName:(NSString *)locationName;
- (void)setProjectDescription:(NSString *)projectDescription;
- (void)setRelevantDate:(NSDate *)relevantDate;

@end
