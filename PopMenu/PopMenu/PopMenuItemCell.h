//
//  PopMenuItemCell.h
//  filexplorer
//
//  Created by apple on 14-6-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopMenuItem.h"

@interface PopMenuItemCell : UITableViewCell
@property (nonatomic, strong) PopMenuItem *item;
+ (CGFloat)height;
@end
