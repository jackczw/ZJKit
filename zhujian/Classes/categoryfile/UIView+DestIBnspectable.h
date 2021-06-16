//
//  UIView+DestIBnspectable.h
//  RPSystem
//
//  Created by admin on 2018/3/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DestIBnspectable)

@property (assign, nonatomic) IBInspectable NSInteger cornerRadius;

@property (assign, nonatomic) IBInspectable NSInteger borderWidth;

@property (strong, nonatomic) IBInspectable UIColor *borderColor;

@property (strong, nonatomic) IBInspectable UIColor *shadowColor;

@property (assign, nonatomic) IBInspectable CGFloat shadowRadius;

@property (assign, nonatomic) IBInspectable CGFloat shadowOpacity;

@property (assign, nonatomic) IBInspectable CGSize shadowOffset;

@property (assign, nonatomic) IBInspectable BOOL masksToBounds;

@end
