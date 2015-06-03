//
//  CustomTabBarController.m
//  CinemaRush
//
//  Created by darya on 5/26/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import "CustomTabBarController.h"
#import "Categories.h"
#import "HomeVC.h"
#import "SettingsVC.h"
#import "SearchVC.h"
#import "MapVC.h"
#import "Colors.h"

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
    searchVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@"searchIconGrey.png"] selectedImage:[UIImage imageNamed:@"searchIconGrey@2x.png"]];
    
    MapVC *mapVC = [MapVC new];
    mapVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Map" image:[UIImage imageNamed:@"mapIconGrey.png"] selectedImage:[UIImage imageNamed:@"mapIconGrey@2x.png"]];
    
    HomeVC *homeVC = [HomeVC new];
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"homeIconGrey.png"] selectedImage:[UIImage imageNamed:@"homeIconGrey@2x.png"]];
    
    SettingsVC *settingsVC = [SettingsVC new];
    settingsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Settings" image:[UIImage imageNamed:@"settingsIconGrey.png"] selectedImage:[UIImage imageNamed:@"settingsIconGrey@2x.png"]];
    
    self.tabBar.barTintColor = defaultColor;

    self.viewControllers = @[searchVC, mapVC, homeVC, settingsVC];
    self.selectedViewController = homeVC;
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];

}

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
