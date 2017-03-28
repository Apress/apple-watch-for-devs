//
//  GlanceController.m
//  Chapter3

#import "GlanceController.h"

#import "Photoshoot.h"

#import "PhotoshootSummarizer.h"
#import "PhotoshootManager.h"

@interface GlanceController ()

@property (nonatomic,weak) IBOutlet WKInterfaceLabel *userSummaryLine1;
@property (nonatomic,weak) IBOutlet WKInterfaceLabel *userSummaryLine2;
@property (nonatomic,weak) IBOutlet WKInterfaceTimer *userSummaryLine2Timer;
@property (nonatomic,weak) IBOutlet WKInterfaceLabel *userSummaryLine3;
@property (nonatomic,weak) IBOutlet WKInterfaceLabel *userSummaryLine4;

@property (nonatomic,strong) NSDictionary *userSummaryInformation;

@end

@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self.userSummaryLine1 setText:@""];
    [self.userSummaryLine2 setText:@""];
    [self.userSummaryLine3 setText:@""];
    [self.userSummaryLine4 setText:@""];

    
    [self registerForNotifications];
}

- (void)registerForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSummaryChange:) name:@"PhotoshootSummaryChanged" object:nil];
}

- (void)unregisterForNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    [self unregisterForNotifications];
}

- (void)handleSummaryChange:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refreshData];
    });
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [self refreshData];
}

- (void)refreshData
{
    NSDictionary *userSummary = [PhotoshootSummarizer currentSummaryInformation:[PhotoshootManager photoshoots]];
    
    NSDictionary *lastSummaryInformation = self.userSummaryInformation;
    
    if (![lastSummaryInformation[@"line1"] isEqualToString:userSummary[@"line1"]]) {
        [self.userSummaryLine1 setText:userSummary[@"line1"]];
    }

    if (![lastSummaryInformation[@"line2"] isEqualToString:userSummary[@"line2"]] ||
        ![lastSummaryInformation[@"relevantStart"] isEqualToDate:userSummary[@"relevantStart"]] ||
        ![lastSummaryInformation[@"relevantEnd"] isEqualToDate:userSummary[@"relevantEnd"]] ||
        [lastSummaryInformation[@"onLocation"] boolValue] != [userSummary[@"onLocation"] boolValue]) {
        if ([userSummary[@"line2"] isEqualToString:@"#countdown#"]) {
            [self.userSummaryLine2 setHidden:YES];
            [self.userSummaryLine2Timer setHidden:NO];

            if ([userSummary[@"onLocation"] boolValue]) {
                NSDate *relevantDate = userSummary[@"relevantStart"];
                [self.userSummaryLine2Timer setDate:relevantDate];

                [self.userSummaryLine2Timer setTextColor:[UIColor redColor]];
            } else {
                NSDate *relevantDate = userSummary[@"relevantEnd"];
                [self.userSummaryLine2Timer setDate:relevantDate];

                [self.userSummaryLine2Timer setTextColor:[UIColor whiteColor]];
            }
            [self.userSummaryLine2Timer start];
        } else {
            [self.userSummaryLine2 setHidden:NO];
            [self.userSummaryLine2Timer setHidden:YES];
            [self.userSummaryLine2Timer stop];
            [self.userSummaryLine2 setText:userSummary[@"line2"]];
        }
    }

    if (![lastSummaryInformation[@"line3"] isEqualToString:userSummary[@"line3"]]) {
        [self.userSummaryLine3 setText:userSummary[@"line3"]];
    }
    if (![lastSummaryInformation[@"line4"] isEqualToString:userSummary[@"line4"]]) {
        [self.userSummaryLine4 setText:userSummary[@"line4"]];
    }
    
    self.userSummaryInformation = userSummary;
}

@end



