//
//  Categories.m
//  SettingsToDo
//
//  Created by Eugene Marchukevich on 7/30/14.
//  Copyright (c) 2014 AppyFurious. All rights reserved.
//

#import "Categories.h"
#import <UIKit/UIKit.h>

@implementation NSObject (PerformBlockAfterDelay)

- (void)performAfterDelay:(NSTimeInterval)delay block:(void (^)(void))block
{
    block = [block copy];
    [self performSelector:@selector(fireBlockAfterDelay:) withObject:block afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block
{
    block();
}

@end




@implementation NSString (ExtraSpaces)

- (NSString*) deleteExtraSpacesFromString
{
    int i = 0;
    while (i < self.length)
    {
        if ([self characterAtIndex:i] == ' ')
        {
            i++;
        } else
            break;
    }
    
    int j = (int)(self.length - 1);
    while (j >= 0)
    {
        if ([self characterAtIndex:j] == ' ')
        {
            j--;
        } else
            break;
    }
    
    if (j >= i)
        return [self substringWithRange:NSMakeRange(i, j - i + 1)];
    else
        return @"";
}

@end

@implementation UIColor (HexColor)

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
+ (UIColor *)colorFromHexString:(NSString *)hexString withAlpha:(CGFloat)alpha
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}

@end

@implementation UIColor (HexFromColor)

- (NSString *) hexStringValue
{
    CGFloat red,green,blue,alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)(red * 255), (int)(green * 255), (int)(blue * 255)];
}

@end

@implementation UIColor (getAlpha)

- (CGFloat) getAlpha
{
    CGFloat red,green,blue,alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return alpha;
}

@end


@implementation UIColor (ColorCode)

+ (UIColor *)colorWithColorCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if (cleanString.length == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)], [cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)], [cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)], [cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if (cleanString.length == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }

    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];

    float red = ((baseValue >> 24) & 0xFF) / 255.f;
    float green = ((baseValue >> 16) & 0xFF) / 255.f;
    float blue = ((baseValue >> 8) & 0xFF) / 255.f;
    float alpha = ((baseValue >> 0) & 0xFF) / 255.f;

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end

@implementation UIColor (cellColor)

+ (UIColor *)defaultCellColor
{
    return [UIColor whiteColor];
}

@end

@implementation UIColor (whiteColorWithAlpha)

+ (UIColor *)whiteColorWithAlpha:(CGFloat)alpha;
{
    return [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:alpha];
}

@end


@implementation UIColor (tableViewColor)

+ (UIColor *)defaultTableViewColor
{
    return [UIColor colorWithRed:241.f/255.f green:241.f/255.f blue:241.f/255.f alpha:1.0];
}

@end

@implementation UIImage (ImageWithVIew)

+(UIImage*) imageWithView: (UIView*)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.f);
	[view drawViewHierarchyInRect: view.bounds afterScreenUpdates: NO];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end

@implementation UIView (Coordinates)

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setOrigin:(CGPoint)origin
{
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGPoint)origin
{
    return CGPointMake(self.frame.origin.x, self.frame.origin.y);
}

- (void)setOriginX:(CGFloat)originX
{
    self.frame = CGRectMake(originX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (void)setOriginY:(CGFloat)originY
{
    self.frame = CGRectMake(self.frame.origin.x, originY, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGSize)size
{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

@end
