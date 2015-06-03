//
//  CinemaVC.m
//  CinemaRush
//
//  Created by darya on 6/3/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import "CinemaVC.h"
#import "Colors.h"
#import "Categories.h"
#import "CinemasProvider.h"

@interface CinemaVC ()

@property (nonatomic) NSUInteger cinemaId;

@end

@implementation CinemaVC


#pragma mark - init

- (id) initWithCinemaId:(NSUInteger)identifier
{
    self = [super init];
    if (self)
    {
        self.cinemaId = identifier;
    }
    return self;
}

#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = defaultColor;
    [self initUI];
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) initUI
{
    [self initNavigationBar];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void) initNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonAction)];
    self.navigationItem.title = [[CinemasProvider sharedProvider] getCinemaNameById:self.cinemaId];
    self.navigationController.navigationBar.barTintColor = tableViewCellColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
}


- (void) closeButtonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
