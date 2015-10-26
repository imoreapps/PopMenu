//
//  ViewController.m
//  PopMenu
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "PopMenu.h"

#ifndef  UIImageNamed
#define UIImageNamed(_NAME)     \
[UIImage imageNamed:(_NAME)]
#endif


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (IBAction)showPopMenu:(id)sender {
  // Build popup menu item(s)
  NSMutableArray *items = [NSMutableArray array];
  PopMenuItem *newfolderMI =
  [PopMenuItem itemWithIcon:UIImageNamed(@"button-folder")
                      title:@"New Folder"
                      block:^{
                        self.view.backgroundColor = [UIColor lightGrayColor];
                      }];
  [items addObject:newfolderMI];
  
  PopMenuItem *newtxtfileMI =
  [PopMenuItem itemWithIcon:UIImageNamed(@"button-txtfile")
                      title:@"New Text File"
                      block:^{
                        self.view.backgroundColor = [UIColor grayColor];
                      }];
  [items addObject:newtxtfileMI];
  
  PopMenuItem *fromlibraryMI =
  [PopMenuItem itemWithIcon:UIImageNamed(@"button-photo")
                      title:@"Import Photos from Library"
                      block:^{
                        self.view.backgroundColor = [UIColor cyanColor];
                      }];
  [items addObject:fromlibraryMI];
  
  PopMenuItem *fromcameraMI =
  [PopMenuItem itemWithIcon:UIImageNamed(@"button-camera")
                      title:@"Take Photo from Camera"
                      block:^{
                        self.view.backgroundColor = [UIColor purpleColor];
                      }];
  [items addObject:fromcameraMI];
  
  PopMenuItem *frommusicMI =
  [PopMenuItem itemWithIcon:UIImageNamed(@"button-iclouddrive")
                      title:@"Import from iCloud Drive"
                      block:^{
                        self.view.backgroundColor = [UIColor darkGrayColor];
                      }];
  [items addObject:frommusicMI];
  
  PopMenuViewController *pmvc = [[PopMenuViewController alloc] initWithMenuItems:items];
  pmvc.sourceView = (UIView *)sender;
  pmvc.sourceRect = [(UIView *)sender bounds];
  [self presentViewController:pmvc animated:YES completion:nil];
}

@end
