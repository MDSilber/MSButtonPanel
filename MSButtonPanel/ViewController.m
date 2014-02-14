//
//  ViewController.m
//  MSButtonPanel
//
//  Created by Mason Silber on 2/11/14.
//  Copyright (c) 2014 MasonSilber. All rights reserved.
//

#import "ViewController.h"
#import "MSButtonPanel.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    MSButtonPanel *buttonPanel = [[MSButtonPanel alloc] initWithButtonTitles:@[@"Test", @"Test", @"Test", @"Test", @"Test"]];
    [self.view addSubview:buttonPanel];
}

@end
