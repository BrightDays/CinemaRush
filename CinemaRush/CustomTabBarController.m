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
    searchVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@"1.png"] selectedImage:[UIImage imageNamed:@"1.png"]];
    
    MapVC *mapVC = [MapVC new];
    mapVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Map" image:[UIImage imageNamed:@"mapIcon@2x.png"] selectedImage:[UIImage imageNamed:@"mapIconWhite@2x.png"]];
    
    HomePageVC *homeVC = [HomePageVC new];
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"homeIcon@2x.png"] selectedImage:[UIImage imageNamed:@"homeIconWhite@2x.png"]];
    
    SettingsVC *settingsVC = [SettingsVC new];
    settingsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@"settingsIcon@2x.png"] selectedImage:[UIImage imageNamed:@"settingsIconWhite@2x.png"]];
    
    ProfileVC *profileVC = [ProfileVC new];
    profileVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[UIImage imageNamed:@"profileIcon@2x.png"] selectedImage:[UIImage imageNamed:@"profileIconWhite@2x.png"]];
    
    self.tabBar.barTintColor = [UIColor colorFromHexString:@"#232631"];

    self.viewControllers = @[searchVC, mapVC, homeVC, settingsVC, profileVC];
    [[UITabBar appearance] setTintColor:[UIColor yellowColor]];
    
    UIImage *whiteBackground = [UIImage imageNamed:@"homeIconWhite@2x.png"];
    [[UITabBar appearance] setSelectionIndicatorImage:whiteBackground];

}

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
