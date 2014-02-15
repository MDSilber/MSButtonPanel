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
    self.view.backgroundColor = [UIColor whiteColor];
    MSButtonPanel *buttonPanel = [[MSButtonPanel alloc] initWithButtonTitles:@[@"Test", @"Test", @"Test", @"Test", @"Test"] target:self andSelectors:@[[NSValue valueWithPointer:@selector(test1)], [NSValue valueWithPointer:@selector(test2)], [NSValue valueWithPointer:@selector(test3)], [NSValue valueWithPointer:@selector(test4)], [NSValue valueWithPointer:@selector(test5)]]];
    buttonPanel.selectedTextColor = [UIColor whiteColor];
    buttonPanel.unselectedTextColor = [UIColor lightGrayColor];
    buttonPanel.selectedBackgroundColor = [UIColor colorWithRed:53.0f/255.0f green:75.0f/255.0f blue:94.0f/255.0f alpha:1.0f];
    buttonPanel.unselectedBackgroundColor = [UIColor colorWithRed:71.0f/255.0f green:95.0f/255.0f blue:119.0f/255.0f alpha:1.0f];
    [self.view addSubview:buttonPanel];
}

- (void)test1
{
    NSLog(@"AAAA");
}

- (void)test2
{
    NSLog(@"BBBB");
}

- (void)test3
{
    NSLog(@"CCCC");
}

- (void)test4
{
    NSLog(@"DDDD");
}

- (void)test5
{
    NSLog(@"EEEE");
}

@end
