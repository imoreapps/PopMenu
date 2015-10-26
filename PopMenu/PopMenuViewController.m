//
//  PopMenuViewController.m
//  filexplorer
//
//  Created by apple on 14-6-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "PopMenuViewController.h"
#import "PopMenuItem.h"
#import "PopMenuItemCell.h"

@interface PopMenuViewController () <
  UIPopoverPresentationControllerDelegate,
  UIAdaptivePresentationControllerDelegate>
@end

@implementation PopMenuViewController {
  NSString *_menuTitle;
  NSArray *_menuItems;
  BOOL _displayInViewBounds;
}

- (instancetype)initWithTitle:(NSString *)title menuItems:(NSArray *)menuItems {
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.modalPresentationStyle = UIModalPresentationPopover;
    self.popoverPresentationController.delegate = self;

    _menuTitle = [title copy];
    _menuItems = menuItems;

    _arrowDirection = UIPopoverArrowDirectionAny;
  }
  return self;
}

- (instancetype)initWithMenuItems:(NSArray *)menuItems {
  return [self initWithTitle:nil menuItems:menuItems];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = _menuTitle ? :NSLocalizedString(@"Actions",nil);

  self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];

  [self.tableView registerClass:[PopMenuItemCell class] forCellReuseIdentifier:@"PopMenuItemCell"];
}

// New Autorotation support.
- (BOOL)shouldAutorotate {
  return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskAll;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return [UIApplication sharedApplication].statusBarStyle;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  PopMenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PopMenuItemCell" forIndexPath:indexPath];
  cell.item = _menuItems[indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];

  PopMenuItem *item = _menuItems[indexPath.row];

  [self dismissViewControllerAnimated:YES completion:^{
      if (item.actionBlock != nil) {
        item.actionBlock();
      }

      if (self.didSelectMenuItem != nil) {
        self.didSelectMenuItem(item);
      }
  }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [PopMenuItemCell height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (_menuTitle && self.navigationController == nil) {
    return 44;
  } else {
    return 0;
  }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  if (_menuTitle && self.navigationController == nil) {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    label.adjustsFontSizeToFitWidth = NO;
    label.numberOfLines = 2;
    label.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f];
    label.text = _menuTitle;
    return label;
  } else {
    return nil;
  }
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController {
  if (self.sourceView) {
    self.popoverPresentationController.sourceView = self.sourceView;
    self.popoverPresentationController.sourceRect = self.sourceRect;
  } else if (self.barButtonItem) {
    self.popoverPresentationController.barButtonItem = self.barButtonItem;
  } else {
    self.popoverPresentationController.sourceView = self.view;
    self.popoverPresentationController.sourceRect = self.sourceRect;
  }
  self.preferredContentSize = CGSizeMake(270, _menuItems.count * [PopMenuItemCell height]
                                         + (_menuTitle ? 44:0));

  popoverPresentationController.permittedArrowDirections = self.arrowDirection;
  popoverPresentationController.passthroughViews = self.passthroughViews;
  popoverPresentationController.popoverLayoutMargins = self.popoverLayoutMargins;

  if (self.backgroundColor) {
    popoverPresentationController.backgroundColor = self.backgroundColor;
  }
  
  if (self.sourceView && CGRectEqualToRect(self.sourceView.bounds, self.sourceRect)) {
    _displayInViewBounds = YES;
  } else {
    _displayInViewBounds = NO;
  }
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
  return YES;
}

- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView  * __nonnull * __nonnull)view {
  if (view != NULL) {
    *view = self.sourceView;
  }
  
  if (rect) {
    if (_displayInViewBounds) {
      *rect = self.sourceView.bounds;
    } else {
      *rect = self.sourceRect;
    }
  }
}

#pragma mark - UIAdaptivePresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ||
    _menuItems.count > 7) {
    return UIModalPresentationFullScreen;
  } else {
    return UIModalPresentationNone;
  }
}

// This will wrap the content view controller in a navigation controller when diplayed in full screen.
- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style {
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller.presentedViewController];
  return navController;
}

#pragma mark - Actions

- (void)dismiss {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
