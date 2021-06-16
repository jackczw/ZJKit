//
//  UIImage+Additions.m
//  YHTodo
//
//  Created by Oboe_b on 16/2/24.
//  Copyright © 2016年 Oboe_b. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

- (UIImage *)tintImageWithColor:(UIColor *)tintColor {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);

    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, rect, self.CGImage);

    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [tintColor setFill];
    CGContextFillRect(context, rect);

    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return coloredImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    UIImage *img = [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
    return img;
}

- (void)c {
    UIButton *btn;
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor]] forState:UIControlStateHighlighted];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

// 获取屏幕截图
+ (UIImage *)getScreenSnap {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 打开上下文
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0);
    
    //将window的内容渲染到上下文中
    [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:false];
    
    //获取上下文种的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

// 缩放
- (UIImage *)scaleToWidth:(CGFloat)width {
    if (self.size.width <= width) {
        return self;
    }
    
    CGFloat height = self.size.height * (width / self.size.width);
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb{
//    
//    if (!image) {
//        return image;
//    }
//    if (kb<1) {
//        return image;
//    }
//    
//    kb*=1024;//字节
//    CGFloat compression = 0.9f;
//    CGFloat maxCompression = 0.1f;
//    //字节
//    NSData *imageData = UIImageJPEGRepresentation(image, compression);
//    while ([imageData length] > kb && compression > maxCompression) {
//        compression -= 0.1;
//        imageData = UIImageJPEGRepresentation(image, compression);
//    }
//    
//    if([imageData length] > kb) {
//        maxCompression = 0.01f;
//        while ([imageData length] > kb && compression > maxCompression) {
//            compression -= 0.01;
//            imageData = UIImageJPEGRepresentation(image, compression);
//        }
//    }
//    if([imageData length] > kb) {
//        maxCompression = 0.001f;
//        while ([imageData length] > kb && compression > maxCompression) {
//            compression -= 0.001;
//            imageData = UIImageJPEGRepresentation(image, compression);
//        }
//    }
//    NSLog(@"当前大小:%fkb",(float)[imageData length]/1024.0f);
//    UIImage *compressedImage = [UIImage imageWithData:imageData];
//    return compressedImage;
//}
+(NSData *)scaleImageForEditeImage:(UIImage *)image
{
    int toKb = 70;
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < toKb*1024.0) return data;
    return  [self scaleImage:image toKb:toKb];
}
+(NSData *)scaleImage:(UIImage *)image toKb:(NSInteger)kb{
    //改成下面的这个方法：是应该这个方法可以保证压缩到指定Kb内容，保证可以正常跳转微信
    kb*=1024;//字节
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < kb) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < kb * 0.9) {
            min = compression;
        } else if (data.length > kb) {
            max = compression;
        } else {
            break;
        }
    }
    //
    if (data.length < kb) {
        NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
        return data;
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > kb && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)kb / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
//    CGFloat compression = 0.9f;
//    CGFloat maxCompression = 0.1f;
//    //字节
//    NSData *imageData = UIImageJPEGRepresentation(image, compression);
//    NSInteger length = imageData.length;
//    while ([imageData length] > kb && compression > maxCompression) {
//        compression -= 0.1;
//        imageData = UIImageJPEGRepresentation(image, compression);
//        if (length==imageData.length) {
//            break;
//        }
//    }
//
//    NSInteger length1 = imageData.length;
//    if([imageData length] > kb) {
//        maxCompression = 0.01f;
//        while ([imageData length] > kb && compression > maxCompression) {
//            compression -= 0.01;
//            imageData = UIImageJPEGRepresentation(image, compression);
//            if (length1==imageData.length) {
//                break;
//            }
//        }
//    }
//
//    NSInteger length2 = imageData.length;
//    if([imageData length] > kb) {
//        maxCompression = 0.001f;
//        while ([imageData length] > kb && compression > maxCompression) {
//            compression -= 0.001;
//            imageData = UIImageJPEGRepresentation(image, compression);
//            if (length2==imageData.length) {
//                break;
//            }
//        }
//    }
//    NSLog(@"当前大小:%fkb",(float)[imageData length]/1024.0f);
//    return imageData;
}

//指定宽度按比例缩放
+(UIImage *)imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *) imageCompressFitSizeScale:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
            
        }
        else{
            
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

@end
