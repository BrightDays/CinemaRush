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
    searchVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"search" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
                           
    
    
    
    self.tabBar.barTintColor = [UIColor colorFromHexString:@"#232631"];
    self.viewControllers = @[vc1, vc2];

}

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
