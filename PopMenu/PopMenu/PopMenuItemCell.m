//
//  PopMenuItemCell.m
//  filexplorer
//
//  Created by apple on 14-6-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "PopMenuItemCell.h"

@implementation PopMenuItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
    self.imageView.tintColor = [UIColor colorWithRed:0x68/255.0f
                                               green:0x68/255.0f
                                                blue:0x71/255.0f
                                               alpha:1.0f];

    self.textLabel.adjustsFontSizeToFitWidth = YES;
    self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];

    self.accessoryType = UITableViewCellAccessoryNone;
  }
  return self;
}

#pragma mark - data update

- (void)setItem:(PopMenuItem *)item {
  if (_item != item) {
    _item = item;

    self.imageView.image = item.icon;
    self.textLabel.text = item.title;
  }
}

+ (CGFloat)height {
  return 44;
}

@end
