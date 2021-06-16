//
//  UIView+DestIBnspectable.m
//  RPSystem
//
//  Created by admin on 2018/3/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "UIView+DestIBnspectable.h"

@implementation UIView (DestIBnspectable)

#pragma mark - setCornerRadius/borderWidth/borderColor

- (void)setCornerRadius:(NSInteger)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
//    self.layer.masksToBounds = cornerRadius > 0;
}

- (NSInteger)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(NSInteger)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (NSInteger)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

-(void)setShadowColor:(UIColor *)shadowColor
{
    self.layer.shadowColor = shadowColor.CGColor;
}

-(UIColor *)shadowColor
{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

-(void)setShadowRadius:(CGFloat)shadowRadius
{
    self.layer.shadowRadius = shadowRadius;
}

-(CGFloat)shadowRadius
{
    return self.layer.shadowRadius;
}

-(void)setShadowOpacity:(CGFloat)shadowOpacity
{
    self.layer.shadowOpacity = shadowOpacity;
}

-(CGFloat)shadowOpacity
{
    return self.layer.shadowOpacity;
}

- (CGSize)shadowOffset
{
    return self.layer.shadowOffset;
}

- (void)setShadowOffset:(CGSize)shadowOffset
{
    self.layer.shadowOffset = shadowOffset;
    self.clipsToBounds = NO;
}

- (BOOL)masksToBounds
{
    return self.layer.masksToBounds;
}

- (void)setMasksToBounds:(BOOL)masksToBounds
{
    self.layer.masksToBounds = masksToBounds;
}

@end
