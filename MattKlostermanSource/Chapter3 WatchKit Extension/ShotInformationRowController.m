//
//  ShotInformationRowController.m
//  Chapter3
//

#import "ShotInformationRowController.h"

#import <WatchKit/WatchKit.h>

@interface ShotInformationRowController ()

@property (nonatomic,weak) IBOutlet WKInterfaceLabel *shotDescription;

@end

@implementation ShotInformationRowController

- (void)setShotInformation:(ShotInformation *)shotInformation
{
    [self.shotDescription setText:shotInformation.shotDescription];
}

@end
