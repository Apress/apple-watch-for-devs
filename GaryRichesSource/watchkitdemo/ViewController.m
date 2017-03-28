//
//  ViewController.m
//  watchkitdemo
//
//  Created by Gary Riches on 06/05/2015.
//  Copyright (c) 2015 Bouncing Ball. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.mobi.bouncingball.watchkitdemo"];
	
	NSArray *listOfActions = @[
							 @{@"name": @"Lights On", @"description": @"Turns the lights on"},
							 @{@"name": @"Lights Off", @"description": @"Turns the lights off"},
							 @{@"name": @"Garage Open", @"description": @"Opens the garage door"},
							 @{@"name": @"Garage Close", @"description": @"Closes the garage door"}
							 ];
	
	[sharedDefaults setObject:listOfActions forKey:@"listOfActions"];
	[sharedDefaults synchronize];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
