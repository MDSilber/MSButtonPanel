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

    MSButtonPanel *buttonPanel1 = [[MSButtonPanel alloc] initWithButtonTitles:@[@"Test", @"Test", @"Test", @"Test", @"Test"]];
    buttonPanel1.frame = CGRectMake(0.0f, 50.0f, 320.0f, 50.0f);
    buttonPanel1.delegate = self;
    buttonPanel1.selectedTextColor = [UIColor whiteColor];
    buttonPanel1.unselectedTextColor = [UIColor lightGrayColor];
    buttonPanel1.selectedBackgroundColor = [UIColor colorWithRed:53.0f/255.0f green:75.0f/255.0f blue:94.0f/255.0f alpha:1.0f];
    buttonPanel1.unselectedBackgroundColor = [UIColor colorWithRed:71.0f/255.0f green:95.0f/255.0f blue:119.0f/255.0f alpha:1.0f];
    [self.view addSubview:buttonPanel1];

    MSButtonPanel *buttonPanel2 = [[MSButtonPanel alloc] initWithButtonTitles:@[@"Test", @"Test", @"Test", @"Test", @"Test"] target:self andSelectors:@[[NSValue valueWithPointer:@selector(selector1)], [NSValue valueWithPointer:@selector(selector2)], [NSValue valueWithPointer:@selector(selector3)], [NSValue valueWithPointer:@selector(selector4)], [NSValue valueWithPointer:@selector(selector5)]]];
    buttonPanel2.frame = CGRectMake(0.0f, CGRectGetMaxY(buttonPanel1.frame) + 10, 320.0f, 50.0f);
    buttonPanel2.selectedTextColor = [UIColor whiteColor];
    buttonPanel2.unselectedTextColor = [UIColor lightGrayColor];
    buttonPanel2.selectedBackgroundColor = [UIColor colorWithRed:53.0f/255.0f green:75.0f/255.0f blue:94.0f/255.0f alpha:1.0f];
    buttonPanel2.unselectedBackgroundColor = [UIColor colorWithRed:71.0f/255.0f green:95.0f/255.0f blue:119.0f/255.0f alpha:1.0f];
    [self.view addSubview:buttonPanel2];
}

- (void)buttonPanelDidSelectButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [self selector1];
            break;
        case 1:
            [self selector2];
            break;
        case 2:
            [self selector3];
            break;
        case 3:
            [self selector4];
            break;
        case 4:
            [self selector5];
            break;
        default:
            break;
    }
}

- (void)selector1
{
    NSLog(@"AAAA");
}

- (void)selector2
{
    NSLog(@"BBBB");
}

- (void)selector3
{
    NSLog(@"CCCC");
}

- (void)selector4
{
    NSLog(@"DDDD");
}

- (void)selector5
{
    NSLog(@"EEEE");
}

@end
