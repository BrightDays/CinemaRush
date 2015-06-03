//
//  CinemasProvider.h
//  CinemaRush
//
//  Created by darya on 6/3/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CinemasProvider : NSObject

+ (CinemasProvider *) sharedProvider;
+ (id) alloc __attribute__((unavailable("alloc not available, call sharedProvider instead")));
- (id) init __attribute__((unavailable("init not available, call sharedProvider instead")));
+ (id) new __attribute__((unavailable("new not available, call sharedProvider instead")));


- (void) setupFilmId:(NSInteger)identifier;

- (NSUInteger) getCountOfCinemas;
- (NSString*) getCinemaNameById:(NSInteger)identifier;
- (UIImage*) getCinemaImageById:(NSInteger)identifier;
- (NSString*) getCinemaInfoBuId:(NSInteger)identifier;
- (CGPoint) getCinemaCoordinatesById:(NSInteger)identifier;

@end
