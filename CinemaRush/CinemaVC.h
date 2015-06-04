//
//  CinemaVC.h
//  CinemaRush
//
//  Created by darya on 6/3/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilmVC.h"

@interface CinemaVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (id) initWithCinemaId:(NSUInteger)identifier;
@property (nonatomic, weak) FilmVC *mainController;

@end
