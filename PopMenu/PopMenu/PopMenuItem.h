//
//  PopMenuItem.h
//  filexplorer
//
//  Created by apple on 14-6-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PopMenuItem : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) dispatch_block_t actionBlock;

+(instancetype)itemWithIcon:(UIImage *)icon
                      title:(NSString *)title
                      block:(dispatch_block_t)block;
@end
