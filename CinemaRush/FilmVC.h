//
//  FilmVC.h
//  CinemaRush
//
//  Created by darya on 6/2/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilmVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSUInteger filmId;
@property (nonatomic, weak) UITabBarController *tabBarController;

- (id) initWithFilmId:(NSUInteger)identifier;
- (void) reload;

@end
