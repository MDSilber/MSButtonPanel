//
//  MSButtonPanel.h
//  MSButtonPanel
//
//  Created by Mason Silber on 2/11/14.
//  Copyright (c) 2014 MasonSilber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSButtonPanel : UIView

@property (nonatomic) UIColor *selectedBackgroundColor;
@property (nonatomic) UIColor *unselectedBackgroundColor;
@property (nonatomic) UIColor *selectedTextColor;
@property (nonatomic) UIColor *unselectedTextColor;
@property (nonatomic) UIFont *selectedFont;
@property (nonatomic) UIFont *unselectedFont;

- (instancetype)initWithButtonTitles:(NSArray *)buttonTitles;

@end
