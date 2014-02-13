//
//  MSButtonPanel.m
//  MSButtonPanel
//
//  Created by Mason Silber on 2/11/14.
//  Copyright (c) 2014 MasonSilber. All rights reserved.
//

#import "MSButtonPanel.h"

@interface MSButtonPanel ()
@property (nonatomic) NSMutableArray *buttons;
@property (nonatomic) NSInteger selectedButtonIndex;
@end

@implementation MSButtonPanel

- (instancetype)initWithButtonTitles:(NSArray *)buttonTitles
{
    self = [super initWithFrame:CGRectMake(10, 50, 300, 50)];
    if (self) {
        self.buttons = [NSMutableArray array];
        self.selectedButtonIndex = 0;
        for (NSString *buttonTitle in buttonTitles) {
            UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [newButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttons addObject:newButton];
        }
    }
    return self;
}

- (void)buttonPressed:(id)sender
{
    self.selectedButtonIndex = [self.buttons indexOfObject:sender];
}

@end
