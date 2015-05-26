//
//  Categories.h
//  SettingsToDo
//
//  Created by Eugene Marchukevich on 7/30/14.
//  Copyright (c) 2014 AppyFurious. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (PerformBlockAfterDelay)

- (void)performAfterDelay:(NSTimeInterval)delay block:(void (^)(void))block;

@end

@interface UIColor (ColorCode)

+ (UIColor *)colorWithColorCode:(NSString *)colorCode;

@end

@interface UIColor (HexColor)

+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (UIColor *)colorFromHexString:(NSString *)hexString withAlpha:(CGFloat)alpha;
@end

@interface UIColor (HexFromColor)

- (NSString *) hexStringValue;

@end

@interface UIColor (getAlpha)

- (CGFloat) getAlpha;

@end

@interface UIColor (cellColor)

+ (UIColor *)defaultCellColor;

@end

@interface UIColor (whiteColorWithAlpha)

+ (UIColor *)whiteColorWithAlpha:(CGFloat)alpha;

@end

@interface UIColor (tableViewColor)

+ (UIColor *)defaultTableViewColor;

@end


@interface NSString (ExtraSpaces)

- (NSString*)deleteExtraSpacesFromString;

@end

@interface UIImage (imageWithView)

+ (UIImage*)imageWithView:(UIView*)view;

@end

@interface UIView (Coordinates)

@property (nonatomic) CGFloat originX;
@property (nonatomic) CGFloat originY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGSize size;

@end