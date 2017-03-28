//
//  NavigationChoiceInterfaceController.m
//  watchkitdemo
//
//  Created by Gary Riches on 13/05/2015.
//  Copyright (c) 2015 Bouncing Ball. All rights reserved.
//

#import "NavigationChoiceInterfaceController.h"

@interface NavigationChoiceInterfaceController ()

@end

@implementation NavigationChoiceInterfaceController

#pragma mark - Handoff -
- (void)handleUserActivity:(NSDictionary *)userInfo
{
	if ([userInfo[@"voiceRecognition"] boolValue]) {
		[self selectVoice];
	} else {
		NSUInteger randomIndex = [userInfo[@"randomIndex"] unsignedIntegerValue];
		
		NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc]
										  initWithSuiteName:@"group.mobi.bouncingball.watchkitdemo"];
		
		NSArray *listOfActions = [sharedDefaults objectForKey:@"listOfActions"];
		
		NSString *selectedActionDescription = listOfActions[randomIndex][@"description"];
		
		[self presentControllerWithName:@"ModalInterfaceController" context:selectedActionDescription];
	}
}

- (IBAction)selectVoice {
	
	[self presentTextInputControllerWithSuggestions:@[@"page based", @"hierarchical"] allowedInputMode:WKTextInputModePlain completion:^(NSArray *results) {
		
		if (results != nil) {
			
			NSString *dictation = [results[0] lowercaseString];
			
			if ([dictation isEqualToString:@"page based"]) {
				[self selectPageBased];
			} else if ([dictation isEqualToString:@"hierarchical"]) {
				[self selectHierarchical];
			}
		}
	}];
}

- (IBAction)selectPageBased {
	
	NSMutableArray *pages = [NSMutableArray array];
	NSMutableArray *contexts = [NSMutableArray array];
	
	NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc]
	initWithSuiteName:@"group.mobi.bouncingball.watchkitdemo"];
	
	NSArray *listOfActions = [sharedDefaults objectForKey:@"listOfActions"];
	
	for (int i = 0; i < listOfActions.count; i++) {
		NSString *selectedActionDescription = listOfActions[i][@"description"];
		[pages addObject:@"DescriptionInterfaceController"];
		[contexts addObject:selectedActionDescription];
	}
	
	[WKInterfaceController reloadRootControllersWithNames:pages contexts:contexts];
}

- (IBAction)selectHierarchical {
	[self pushControllerWithName:@"TableInterfaceController" context:nil];
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
	
	[self setTitle:@"Menu"];
	
	NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc]
	initWithSuiteName:@"group.mobi.bouncingball.watchkitdemo"];
	
	int menuStyle = [[sharedDefaults objectForKey:@"menuStyle"] intValue];
	
	if (menuStyle == 1) {
		[self selectPageBased];
	} else if (menuStyle == 2) {
		[self selectHierarchical];
	}
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



