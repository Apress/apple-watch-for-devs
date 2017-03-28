//
//  ModalInterfaceController.m
//  watchkitdemo
//
//  Created by Gary Riches on 11/05/2015.
//  Copyright (c) 2015 Bouncing Ball. All rights reserved.
//

#import "DescriptionInterfaceController.h"

@interface DescriptionInterfaceController ()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *descriptionLabel;

@end

@implementation DescriptionInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
	
	[self.descriptionLabel setText:context];
	
	[self setTitle:@"Info"];
	
	[self addMenuItemWithItemIcon:WKMenuItemIconRepeat
	title:@"Restart"
	action:@selector(restart)];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)restart {
	[WKInterfaceController reloadRootControllersWithNames: @[@"NavigationChoiceInterfaceController"]
												 contexts:nil];
}

@end



