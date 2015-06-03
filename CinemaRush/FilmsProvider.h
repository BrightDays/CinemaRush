//
//  FilmsProvider.h
//  CinemaRush
//
//  Created by darya on 6/2/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FilmsProvider : NSObject

+ (FilmsProvider *) sharedProvider;
+ (id) alloc __attribute__((unavailable("alloc not available, call sharedProvider instead")));
- (id) init __attribute__((unavailable("init not available, call sharedProvider instead")));
+ (id) new __attribute__((unavailable("new not available, call sharedProvider instead")));


- (NSUInteger) getCountOfFilms;
- (NSString*) getFilmNameById:(NSInteger)identifier;
- (UIImage*) getFilmImageById:(NSInteger)identifier;
- (NSString*) getFilmLinkToKpById:(NSInteger)identifier;


- (NSUInteger) getCountOfFilmsWithSearchText:(NSString*)text;
- (NSString*) getFilmNameById:(NSInteger)identifier searchText:(NSString*)text;
- (UIImage*) getFilmImageById:(NSInteger)identifier searchText:(NSString*)text;
- (NSString*) getFilmLinkToKpById:(NSInteger)identifier searchText:(NSString*)text;

-(NSArray*) getRandomFilmsIdsWithCount:(NSInteger)count;

@end
