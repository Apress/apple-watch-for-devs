//
//  InterfaceController.m
//  watchkitdemo WatchKit Extension
//
//  Created by Gary Riches on 06/05/2015.
//  Copyright (c) 2015 Bouncing Ball. All rights reserved.
//

#import "TableInterfaceController.h"
#import "ListTableRowController.h"

@interface TableInterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceTable *listTable;

@end


@implementation TableInterfaceController

- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier
{

	NSLog(@"%@", segueIdentifier);
	return @"";
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
	
	NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc]
	initWithSuiteName:@"group.mobi.bouncingball.watchkitdemo"];
	
	NSArray *listOfActions = [sharedDefaults objectForKey:@"listOfActions"];
	
	NSString *selectedActionDescription = listOfActions[rowIndex][@"description"];
	
	[self pushControllerWithName:@"DescriptionInterfaceController" context:selectedActionDescription];
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
	
	NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.mobi.bouncingball.watchkitdemo"];
	NSArray *listOfActions = [sharedDefaults objectForKey:@"listOfActions"];

    // Configure interface objects here.
	[self.listTable setNumberOfRows:listOfActions.count withRowType:@"ListTableRowController"];
	
	for (int i = 0; i < listOfActions.count; i++) {
		ListTableRowController *row = [self.listTable rowControllerAtIndex:i];
		[row.name setText:listOfActions[i][@"name"]];
	}
	
	[self setTitle:@"Actions"];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end