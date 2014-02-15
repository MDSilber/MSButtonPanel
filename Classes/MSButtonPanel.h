//
//  MSButtonPanel.h
//  MSButtonPanel
//
//  Created by Mason Silber on 2/11/14.
//  Copyright (c) 2014 MasonSilber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSButtonPanel;

@protocol MSButtonPanelDelegate <NSObject>
- (void)buttonPanelDidSelectButtonWithIndex:(NSInteger)index;
@end

@interface MSButtonPanel : UIView

@property (nonatomic) UIColor *selectedBackgroundColor;
@property (nonatomic) UIColor *unselectedBackgroundColor;
@property (nonatomic) UIColor *selectedTextColor;
@property (nonatomic) UIColor *unselectedTextColor;
@property (nonatomic) UIFont *selectedFont;
@property (nonatomic) UIFont *unselectedFont;
@property (nonatomic, weak) id<MSButtonPanelDelegate> delegate;

- (instancetype)initWithButtonTitles:(NSArray *)buttonTitles;
- (instancetype)initWithButtonTitles:(NSArray *)buttonTitles target:(id)target andSelectors:(NSArray *)selectors;
@end
