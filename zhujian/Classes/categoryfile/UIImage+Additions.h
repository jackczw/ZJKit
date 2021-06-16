//
//  UIImage+Additions.h
//  YHTodo
//
//  Created by Oboe_b on 16/2/24.
//  Copyright © 2016年 Oboe_b. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

- (UIImage *)tintImageWithColor:(UIColor *)tintColor;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)getScreenSnap;
- (UIImage *)scaleToWidth:(CGFloat)width;

+(NSData *)scaleImageForEditeImage:(UIImage *)image;//编辑器图片500之内
+(NSData *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;

+(UIImage *)imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

+(UIImage *) imageCompressFitSizeScale:(UIImage *)sourceImage targetSize:(CGSize)size;

@end
