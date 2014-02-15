//
//  MSButtonPanel.m
//  MSButtonPanel
//
//  Created by Mason Silber on 2/11/14.
//  Copyright (c) 2014 MasonSilber. All rights reserved.
//

#import "MSButtonPanel.h"

#define GAP_BETWEEN_BUTTONS 10.0f
#define BUTTON_PANEL_WIDTH [[UIScreen mainScreen] bounds].size.width
#define DEFAULT_FONT_SIZE 14.0f
#define BUTTON_CORNER_RADIUS 3.0f
#define ANIMATION_DURATION 0.25f

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
    NSAssert([buttonTitles count] > 1, @"Need more than one button title");
    NSAssert([buttonTitles count] < 11, @"Too many buttons will break the panel");
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.buttons = [NSMutableArray array];
        self.selectedButtonIndex = 0;
        self.buttonTitles = buttonTitles;
        _selectedBackgroundColor = [UIColor whiteColor];
        _selectedTextColor = [UIColor blackColor];
        _unselectedBackgroundColor = [UIColor blackColor];
        _unselectedTextColor = [UIColor whiteColor];
        _selectedFont = [UIFont fontWithName:@"HelveticaNeue" size:DEFAULT_FONT_SIZE];
        _unselectedFont = [UIFont fontWithName:@"HelveticaNeue" size:DEFAULT_FONT_SIZE];
        for (int i = 0; i < [buttonTitles count]; i++) {
            UIButton *newButton = [self _buttonWithIndex:i isSelected:(i == self.selectedButtonIndex)];
            [self addSubview:newButton];
        }
        [self _calculateButtonWidths];
    }
    return self;
}

- (instancetype)initWithButtonTitles:(NSArray *)buttonTitles target:(id)target andSelectors:(NSArray *)selectors
{
    self = [self initWithButtonTitles:buttonTitles];
    if (self) {
        for (int i = 0; i < [_buttons count]; i++) {
            UIButton *button = [_buttons objectAtIndex:i];
            [button addTarget:target action:[[selectors objectAtIndex:i] pointerValue] forControlEvents:UIControlEventTouchUpInside];
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
            button.frame = CGRectMake(xOrigin, 3.0f, self.selectedButtonWidth, 44.0f);
            xOrigin += 10.0f + self.selectedButtonWidth;
        } else {
            button.frame = CGRectMake(xOrigin, 3.0f, self.normalButtonWidth, 44.0f);
            xOrigin += 10.0f + self.normalButtonWidth;
        }
        [self addSubview:button];
    }
}

#pragma mark - Setter methods

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor
{
    if (_selectedBackgroundColor != selectedBackgroundColor) {
        _selectedBackgroundColor = selectedBackgroundColor;
        ((UIButton *)[self.buttons objectAtIndex:self.selectedButtonIndex]).backgroundColor = _selectedBackgroundColor;
    }
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor
{
    if (_selectedTextColor != selectedTextColor) {
        _selectedTextColor = selectedTextColor;
        [((UIButton *)[self.buttons objectAtIndex:self.selectedButtonIndex]) setTitleColor:_selectedTextColor forState:UIControlStateNormal];
    }
}

- (void)setUnselectedBackgroundColor:(UIColor *)unselectedBackgroundColor
{
    if (_unselectedBackgroundColor != unselectedBackgroundColor) {
        _unselectedBackgroundColor = unselectedBackgroundColor;
        for (UIButton *button in self.buttons) {
            if ([self.buttons indexOfObject:button] != self.selectedButtonIndex) {
                button.backgroundColor = _unselectedBackgroundColor;
            }
        }
    }
}

- (void)setUnselectedTextColor:(UIColor *)unselectedTextColor
{
    if (_unselectedTextColor != unselectedTextColor) {
        _unselectedTextColor = unselectedTextColor;
        for (UIButton *button in self.buttons) {
            if ([self.buttons indexOfObject:button] != self.selectedButtonIndex) {
                [button setTitleColor:_unselectedTextColor forState:UIControlStateNormal];
            }
        }
    }
}

- (void)setSelectedFont:(UIFont *)selectedFont
{
    if (_selectedFont != selectedFont) {
        _selectedFont = selectedFont;
        ((UIButton *)[self.buttons objectAtIndex:self.selectedButtonIndex]).titleLabel.font = _selectedFont;
    }
}

- (void)setUnselectedFont:(UIFont *)unselectedFont
{
    if (_unselectedFont != unselectedFont) {
        _unselectedFont = unselectedFont;
        for (UIButton *button in self.buttons) {
            if ([self.buttons indexOfObject:button] != self.selectedButtonIndex) {
                button.titleLabel.font = self.unselectedFont;
            }
        }
    }
}

#pragma mark - Private methods

- (UIButton *)_buttonWithIndex:(NSInteger)index isSelected:(BOOL)selected
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(_buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.buttons addObject:button];

    if (selected) {
        [button setTitle:[NSString stringWithFormat:@"%d. %@", (index + 1), [self.buttonTitles objectAtIndex:index]] forState:UIControlStateNormal];
        [self _selectButton:button];
    } else {
        [button setTitle:[NSString stringWithFormat:@"%d", (index + 1)] forState:UIControlStateNormal];
        [self _unselectButton:button];
    }

    return button;
}

- (void)_buttonPressed:(UIButton *)sender
{
    NSInteger newSelectedButtonIndex = [self.buttons indexOfObject:sender];
    if (self.selectedButtonIndex == newSelectedButtonIndex) {
        return;
    }

    if (self.delegate) {
        [self.delegate buttonPanelDidSelectButtonWithIndex:newSelectedButtonIndex];
    }

    UIButton *oldSelectedButton = (UIButton *)[self.buttons objectAtIndex:self.selectedButtonIndex];
    [oldSelectedButton setTitle:[NSString stringWithFormat:@"%d", (self.selectedButtonIndex + 1)] forState:UIControlStateNormal];
    [sender setTitle:[NSString stringWithFormat:@"%d. %@", (newSelectedButtonIndex + 1), [self.buttonTitles objectAtIndex:newSelectedButtonIndex]] forState:UIControlStateNormal];

    if (self.selectedButtonIndex < newSelectedButtonIndex) {
        //Button tapped is to the right of the currently selected button
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            //Deselect old button
            CGRect oldSelectedButtonFrame = oldSelectedButton.frame;
            oldSelectedButtonFrame.size.width = self.normalButtonWidth;
            oldSelectedButton.frame = oldSelectedButtonFrame;
            [self _unselectButton:[self.buttons objectAtIndex:self.selectedButtonIndex]];

            //Select new button
            CGRect newSelectedButtonFrame = sender.frame;
            newSelectedButtonFrame.origin.x -= [self _widthDifference];
            newSelectedButtonFrame.size.width = self.selectedButtonWidth;
            sender.frame = newSelectedButtonFrame;
            [self _selectButton:sender];

            //Adjust position of buttons between the two
            for (int i = self.selectedButtonIndex + 1; i < newSelectedButtonIndex; i++) {
                UIButton *button = (UIButton *)[self.buttons objectAtIndex:i];
                CGRect buttonFrame = button.frame;
                buttonFrame.origin.x -= [self _widthDifference];
                button.frame = buttonFrame;
            }
        }];
    } else if (self.selectedButtonIndex > newSelectedButtonIndex) {
        //Button tapped is to the left of the currently selected button
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            //Deselect old button
            UIButton *oldSelectedButton = (UIButton *)[self.buttons objectAtIndex:self.selectedButtonIndex];
            CGRect oldSelectedButtonFrame = oldSelectedButton.frame;
            oldSelectedButtonFrame.origin.x += [self _widthDifference];
            oldSelectedButtonFrame.size.width = self.normalButtonWidth;
            oldSelectedButton.frame = oldSelectedButtonFrame;
            [self _unselectButton:oldSelectedButton];

            //Select new button
            CGRect newSelectedButtonFrame = sender.frame;
            newSelectedButtonFrame.size.width = self.selectedButtonWidth;
            sender.frame = newSelectedButtonFrame;
            [self _selectButton:sender];

            //Adjust position of buttons between the two
            for (int i = newSelectedButtonIndex + 1; i < self.selectedButtonIndex; i++) {
                UIButton *button = (UIButton *)[self.buttons objectAtIndex:i];
                CGRect buttonFrame = button.frame;
                buttonFrame.origin.x += [self _widthDifference];
                button.frame = buttonFrame;
            }
        }];
    }
    self.selectedButtonIndex = newSelectedButtonIndex;
}

- (void)_selectButton:(UIButton *)button
{
    [button setTitleColor:self.selectedTextColor forState:UIControlStateNormal];
    button.backgroundColor = self.selectedBackgroundColor;
    button.titleLabel.font = self.selectedFont;
}

- (void)_unselectButton:(UIButton *)button
{
    [button setTitleColor:self.unselectedTextColor forState:UIControlStateNormal];
    button.backgroundColor = self.unselectedBackgroundColor;
    button.titleLabel.font = self.unselectedFont;
}

- (CGFloat)_widthDifference
{
    return self.selectedButtonWidth- self.normalButtonWidth;
}

- (void)_calculateButtonWidths
{
    //Subtraction accounts for gaps between buttons
    CGFloat availableWidth = BUTTON_PANEL_WIDTH - GAP_BETWEEN_BUTTONS * ([self.buttonTitles count] + 1);
    self.selectedButtonWidth = floorf(availableWidth/2.0f);
    self.normalButtonWidth = floorf(availableWidth/(2.0f * ([self.buttonTitles count] - 1)));
}

@end
