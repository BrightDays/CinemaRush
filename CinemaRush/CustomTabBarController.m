//
//  CustomTabBarController.m
//  CinemaRush
//
//  Created by darya on 5/26/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import "CustomTabBarController.h"
#import "Categories.h"
#import "HomePageVC.h"
#import "SettingsVC.h"
#import "ProfileVC.h"
#import "SearchVC.h"
#import "MapVC.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (id) init
{
    self = [super init];
    if (self)
    {
        [self initControllers];
    }
    return self;
}

- (void) initControllers
{
    SearchVC *searchVC = [SearchVC new];
    searchVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    
    MapVC *mapVC = [MapVC new];
    mapVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    
    HomePageVC *homeVC = [HomePageVC new];
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];

    SettingsVC *settingsVC = [SettingsVC new];
    settingsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];

    ProfileVC *profileVC = [ProfileVC new];
    profileVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];

    self.tabBar.barTintColor = [UIColor colorFromHexString:@"#232631"];
    self.viewControllers = @[searchVC, mapVC, homeVC, settingsVC, profileVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
