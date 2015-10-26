//
//  PopMenuViewController.h
//  filexplorer
//
//  Created by apple on 14-6-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopMenuViewController : UITableViewController
/// Use this property to configure where popover's arrow should be pointing.
@property(nonatomic, assign) UIPopoverArrowDirection arrowDirection;

/// The view containing the anchor rectangle for the popover.
@property(nonatomic, weak) UIView *sourceView;

/// The rectangle in the specified view in which to anchor the popover.
@property(nonatomic, assign) CGRect sourceRect;

/// The bar button item containing the anchor rectangle for the popover.
@property(nonatomic, weak) UIBarButtonItem *barButtonItem;

/// The color of the popover’s backdrop view.
@property(nonatomic, strong) UIColor *backgroundColor;

/// An array of views that the user can interact with while the popover is visible.
@property(nonatomic, strong) NSArray *passthroughViews;

///The margins that define the portion of the screen in which it is permissible to display the popover.
@property(nonatomic, assign) UIEdgeInsets popoverLayoutMargins;

/// The handler for menu item selection
@property(nonatomic, copy) void (^didSelectMenuItem)(id item);

- (instancetype)initWithTitle:(NSString *)title menuItems:(NSArray *)menuItems;

- (instancetype)initWithMenuItems:(NSArray *)menuItems;
@end
