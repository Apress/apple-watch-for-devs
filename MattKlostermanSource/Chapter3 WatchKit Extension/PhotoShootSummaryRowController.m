//
//  PhotoShootSummaryRowController.m
//  Chapter3
//

#import "PhotoShootSummaryRowController.h"

@interface PhotoShootSummaryRowController ()

@property (nonatomic,weak) IBOutlet WKInterfaceLabel *locationLabel;
@property (nonatomic,weak) IBOutlet WKInterfaceLabel *projectLabel;
@property (nonatomic,weak) IBOutlet WKInterfaceLabel *dateLabel;

@end

@implementation PhotoShootSummaryRowController


- (void)setLocationName:(NSString *)locationName
{
    [self.locationLabel setText:locationName];
}

- (void)setProjectDescription:(NSString *)projectDescription
{
    [self.projectLabel setText:projectDescription];
}

- (void)setRelevantDate:(NSDate *)relevantDate
{
    [self.dateLabel setText:[relevantDate description]];
}

@end
