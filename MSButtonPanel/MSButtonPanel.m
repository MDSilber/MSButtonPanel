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
    self = [super initWithFrame:CGRectMake(0, 50, 320, 50)];
    if (self) {
        self.buttons = [NSMutableArray array];
        self.selectedButtonIndex = 0;
        for (NSString *buttonTitle in buttonTitles) {
            UIButton *newButton = [self _buttonWithTitle:buttonTitle];
            [self.buttons addObject:newButton];
            [self addSubview:newButton];
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat xOrigin = 10.0f;
    for (UIButton *button in self.buttons) {
        if ([self.buttons indexOfObject:button] == self.selectedButtonIndex) {
            button.frame = CGRectMake(xOrigin, 3.0f, [self _selectedButtonWidth], 44.0f);
            xOrigin += 10.0f + [self _selectedButtonWidth];
        } else {
            button.frame = CGRectMake(xOrigin, 3.0f, [self _normalButtonWidth], 44.0f);
            xOrigin += 10.0f + [self _normalButtonWidth];
        }
    }
}

- (UIButton *)_buttonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor blackColor];
    button.titleLabel.text = title;
    button.titleLabel.textColor = [UIColor whiteColor];
    return button;
}

- (void)buttonPressed:(id)sender
{
    self.selectedButtonIndex = [self.buttons indexOfObject:sender];
}

- (CGFloat)_normalButtonWidth
{
    return 0.0f;
}

- (CGFloat)_selectedButtonWidth
{
    return 0.0f;
}

@end
