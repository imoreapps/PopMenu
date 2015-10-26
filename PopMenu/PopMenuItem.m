//
//  PopMenuItem.m
//  filexplorer
//
//  Created by apple on 14-6-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "PopMenuItem.h"
#import "PopMenuItemCell.h"

@implementation PopMenuItem

+(instancetype)itemWithIcon:(UIImage *)icon title:(NSString *)title block:(dispatch_block_t)block {
  PopMenuItem *result = [[PopMenuItem alloc] init];
  result.title = title;
  result.icon = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  result.actionBlock = block;
  return result;
}

@end
