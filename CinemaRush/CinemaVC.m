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
#import "FilmsProvider.h"
#import "FilmVC.h"

@interface CinemaVC ()

@property (nonatomic) NSUInteger cinemaId;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UITextView *infoTextView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *films;
@property (nonatomic, strong) UIButton *showInMapButton;

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

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) initUI
{
    [self initNavigationBar];
    [self initLogoView];
    [self initInfo];
    [self initShowInMapButton];
    [self initTableView];
}

- (void) initNavigationBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonAction)];
    self.navigationItem.title = [[CinemasProvider sharedProvider] getCinemaNameById:self.cinemaId];
    self.navigationController.navigationBar.barTintColor = tableViewCellColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
}

- (void) initLogoView
{
    self.logoImageView = [[UIImageView alloc] initWithImage:[[CinemasProvider sharedProvider] getCinemaImageById:self.cinemaId]];
    self.logoImageView.frame = CGRectMake(15, 20, self.logoImageView.width * 1.5f, self.logoImageView.height * 1.5f);
    self.logoImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.logoImageView];
}

- (void) initInfo
{
    self.infoTextView = [[UITextView alloc] initWithFrame:CGRectMake(self.logoImageView.originX + self.logoImageView.width + 10, self.logoImageView.originY - 5, self.view.width - self.logoImageView.width - self.logoImageView.originX - 20, self.logoImageView.height)];
    self.infoTextView.text = [[CinemasProvider sharedProvider] getCinemaInfoById:self.cinemaId];
    self.infoTextView.backgroundColor = [UIColor clearColor];
    self.infoTextView.textColor = [UIColor whiteColorWithAlpha:0.95];
    self.infoTextView.font = [UIFont fontWithName:@"Helvetica" size:13.f];
    [self.view addSubview:self.infoTextView];
}

- (void) initShowInMapButton
{
    self.showInMapButton = [[UIButton alloc] initWithFrame:CGRectMake(self.logoImageView.originX, self.logoImageView.originY + self.logoImageView.height + 20, self.view.width - self.logoImageView.originX * 2, 40)];
    [self.showInMapButton addTarget:self action:@selector(showInMapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.showInMapButton.backgroundColor = [UIColor clearColor];
    self.showInMapButton.layer.borderColor = [UIColor whiteColorWithAlpha:0.9f].CGColor;
    self.showInMapButton.layer.borderWidth = 1.f;
    self.showInMapButton.layer.cornerRadius = 6.f;
    [self.showInMapButton setTitle:@"Show in map" forState:UIControlStateNormal];
    [self.showInMapButton setTitleColor:[UIColor whiteColorWithAlpha:0.8] forState:UIControlStateNormal];
    [self.view addSubview:self.showInMapButton];
}

- (void) initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.showInMapButton.originY + self.showInMapButton.height + 20, self.view.width, self.view.height - (self.showInMapButton.originY + self.showInMapButton.height + 20))];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = tableViewBackColor;

    self.films = [[CinemasProvider sharedProvider] getfilmsIdsForCinemaWithId:self.cinemaId];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - table view 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.films.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.backgroundColor = tableViewCellColor;
    cell.textLabel.text = [[FilmsProvider sharedProvider] getFilmNameById:[self.films[indexPath.row] integerValue]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    cell.imageView.image = [[FilmsProvider sharedProvider] getFilmImageById:[self.films[indexPath.row] integerValue]];
    cell.imageView.clipsToBounds = YES;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 6.f;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.mainController)
    {
        self.mainController.filmId = [self.films[indexPath.row] integerValue];
        [self.mainController reload];
        [self.navigationController popViewControllerAnimated:YES];
    } else
    {
        FilmVC *vc = [[FilmVC alloc] initWithFilmId:[self.films[indexPath.row] integerValue]];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.navigationController pushViewController:nc animated:YES];
    }
}


#pragma mark - actions
- (void) closeButtonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) showInMapButtonAction:(UIButton*)sender
{
    [self.tabBarController setSelectedIndex:1];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
