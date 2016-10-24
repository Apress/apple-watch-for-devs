//
//  GlanceInterfaceController.m
//  watchkitdemo
//
//  Created by Gary Riches on 08/05/2015.
//  Copyright (c) 2015 Bouncing Ball. All rights reserved.
//

#import "GlanceInterfaceController.h"

@interface GlanceInterfaceController ()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *nameLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *descriptionLabel;


@end

@implementation GlanceInterfaceController

- (void)awakeWithContext:(id)context {
	[super awakeWithContext:context];
	
	NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc]
									  initWithSuiteName:@"group.mobi.bouncingball.watchkitdemo"];
	
	NSArray *listOfActions = [sharedDefaults objectForKey:@"listOfActions"];
	
	NSUInteger randomIndex = arc4random() % listOfActions.count;
	
	NSString *selectedActionName = listOfActions[randomIndex][@"name"];
	NSString *selectedActionDescription = listOfActions[randomIndex][@"description"];
	
	if ([sharedDefaults boolForKey:@"voiceForGlance"]) {
		[self.nameLabel setText:@"Voice Recognition"];
		[self.descriptionLabel setText:@"Tap to start"];
		
		[self updateUserActivity:@"glance.mobi.bouncingball.watchkitdemo"
						userInfo:@{@"voiceRecognition" : [NSNumber numberWithBool:TRUE]}
					  webpageURL:nil];
	} else {
		[self.nameLabel setText:selectedActionName];
		[self.descriptionLabel setText:selectedActionDescription];
		
		[self updateUserActivity:@"glance.mobi.bouncingball.watchkitdemo"
						userInfo:@{@"randomIndex" : [NSNumber numberWithUnsignedInteger:randomIndex]}
					  webpageURL:nil];
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



