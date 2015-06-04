//
//  FilmVC.h
//  CinemaRush
//
//  Created by darya on 6/2/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilmVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (id) initWithFilmId:(NSUInteger)identifier;
@property (nonatomic, weak) UIViewController *mainController;

@end
