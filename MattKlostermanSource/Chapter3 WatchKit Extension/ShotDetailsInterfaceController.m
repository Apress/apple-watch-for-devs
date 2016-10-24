//
//  ShotDetailsInterfaceController.m
//  Chapter3
//

#import "ShotDetailsInterfaceController.h"

#import "ShotInformationRowController.h"

@interface ShotDetailsInterfaceController ()

@property (nonatomic,strong) NSArray *shotDetails;

@property (nonatomic,weak) IBOutlet WKInterfaceTable *table;

@end

@implementation ShotDetailsInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    NSArray *shotDetails = context[@"shotDetails"];
    self.shotDetails = shotDetails;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];

    [self updateTable];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)updateTable
{
    [self.table setNumberOfRows:[self.shotDetails count] withRowType:@"shotinformation"];

    for (NSInteger idx = 0; idx < [self.table numberOfRows] && idx < [self.shotDetails count]; idx++) {
        ShotInformationRowController *rowController = [self.table rowControllerAtIndex:idx];

        [rowController setShotInformation:self.shotDetails[idx]];
    }
}

@end



