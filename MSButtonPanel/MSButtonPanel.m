//
//  MSButtonPanel.m
//  MSButtonPanel
//
//  Created by Mason Silber on 2/11/14.
//  Copyright (c) 2014 MasonSilber. All rights reserved.
//

#import "MSButtonPanel.h"

@interface MSButtonPanel ()
@property (nonatomic) CGFloat normalButtonWidth;
@property (nonatomic) CGFloat selectedButtonWidth;
@property (nonatomic) NSArray *buttonTitles;
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
        self.buttonTitles = buttonTitles;
        for (int i = 0; i < [buttonTitles count]; i++) {
            UIButton *newButton = [self _buttonWithIndex:i isSelected:(i == self.selectedButtonIndex)];
            [self addSubview:newButton];
        }
        [self _calculateButtonWidths];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat xOrigin = 10.0f;
    for (UIButton *button in self.buttons) {
        if ([self.buttons indexOfObject:button] == self.selectedButtonIndex) {
            button.frame = CGRectMake(xOrigin, 3.0f, self.selectedButtonWidth, 44.0f);
            xOrigin += 10.0f + self.selectedButtonWidth;
        } else {
            button.frame = CGRectMake(xOrigin, 3.0f, self.normalButtonWidth, 44.0f);
            xOrigin += 10.0f + self.normalButtonWidth;
        }
        [self addSubview:button];
    }
}

- (UIButton *)_buttonWithIndex:(NSInteger)index isSelected:(BOOL)selected
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(_buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 3.0f;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.buttons addObject:button];

    if (selected) {
        [self _selectButton:button];
    } else {
        [self _deselectButton:button];
    }

    return button;
}

- (void)_buttonPressed:(UIButton *)sender
{
    if (self.selectedButtonIndex < [self.buttons indexOfObject:sender]) {
        //Button tapped is to the right of the currently selected button
        [UIView animateWithDuration:0.25f animations:^{
            //Deselect old button
            UIButton *oldSelectedButton = (UIButton *)[self.buttons objectAtIndex:self.selectedButtonIndex];
            CGRect oldSelectedButtonFrame = oldSelectedButton.frame;
            oldSelectedButtonFrame.size.width = self.normalButtonWidth;
            oldSelectedButton.frame = oldSelectedButtonFrame;
            [self _deselectButton:[self.buttons objectAtIndex:self.selectedButtonIndex]];

            //Select new button
            CGRect newSelectedButtonFrame = sender.frame;
            newSelectedButtonFrame.origin.x -= [self _widthDifference];
            newSelectedButtonFrame.size.width = self.selectedButtonWidth;
            sender.frame = newSelectedButtonFrame;
            [self _selectButton:sender];

            //Adjust position of buttons between the two
            for (int i = self.selectedButtonIndex + 1; i < [self.buttons indexOfObject:sender]; i++) {
                UIButton *button = (UIButton *)[self.buttons objectAtIndex:i];
                CGRect buttonFrame = button.frame;
                buttonFrame.origin.x -= [self _widthDifference];
                button.frame = buttonFrame;
            }
        }];
    } else if (self.selectedButtonIndex > [self.buttons indexOfObject:sender]) {
        //Button tapped is to the left of the currently selected button
        [UIView animateWithDuration:0.25f animations:^{
            //Deselect old button
            UIButton *oldSelectedButton = (UIButton *)[self.buttons objectAtIndex:self.selectedButtonIndex];
            CGRect oldSelectedButtonFrame = oldSelectedButton.frame;
            oldSelectedButtonFrame.origin.x += [self _widthDifference];
            oldSelectedButtonFrame.size.width = self.normalButtonWidth;
            oldSelectedButton.frame = oldSelectedButtonFrame;
            [self _deselectButton:oldSelectedButton];

            //Select new button
            CGRect newSelectedButtonFrame = sender.frame;
            newSelectedButtonFrame.size.width = self.selectedButtonWidth;
            sender.frame = newSelectedButtonFrame;
            [self _selectButton:sender];

            //Adjust position of buttons between the two
            for (int i = [self.buttons indexOfObject:sender] + 1; i < self.selectedButtonIndex; i++) {
                UIButton *button = (UIButton *)[self.buttons objectAtIndex:i];
                CGRect buttonFrame = button.frame;
                buttonFrame.origin.x += [self _widthDifference];
                button.frame = buttonFrame;
            }
        }];
    } else {
        return;
    }
    self.selectedButtonIndex = [self.buttons indexOfObject:sender];
}

- (void)_selectButton:(UIButton *)button
{
    NSInteger buttonIndex = [self.buttons indexOfObject:button];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"%d. %@", (buttonIndex + 1), [self.buttonTitles objectAtIndex:buttonIndex]] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
}

- (void)_deselectButton:(UIButton *)button
{
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"%d", ([self.buttons indexOfObject:button] + 1)] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
}

- (CGFloat)_widthDifference
{
    return self.selectedButtonWidth- self.normalButtonWidth;
}

- (void)_calculateButtonWidths
{
    //Subtraction accounts for gaps between buttons
    CGFloat availableWidth = 320.0f - 10.0f * ([self.buttonTitles count] + 1);
    self.selectedButtonWidth = floorf(availableWidth/2.0f);
    self.normalButtonWidth = floorf(availableWidth/(2.0f * ([self.buttonTitles count] - 1)));
}

@end
