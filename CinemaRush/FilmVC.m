//
//  FilmVC.m
//  CinemaRush
//
//  Created by darya on 6/2/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import "FilmVC.h"
#import "Colors.h"
#import "Categories.h"
#import "FilmsProvider.h"
#import "CinemasProvider.h"
#import "CinemaVC.h"

@interface FilmVC ()



@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *cinemas;

@end

@implementation FilmVC


#pragma mark - init

- (id) initWithFilmId:(NSUInteger)identifier
{
    self = [super init];
    if (self)
    {
        self.filmId = identifier;
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

- (void) reload
{
    for(UIView *view in self.view.subviews)
    {
        [view removeFromSuperview];
    }
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
    [self initSegmentedControl];
    [self initWebView];
    [self initTableView];
}

- (void) initNavigationBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonAction)];
    self.navigationItem.title = [[FilmsProvider sharedProvider] getFilmNameById:self.filmId];
    self.navigationController.navigationBar.barTintColor = tableViewCellColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
}

- (void) initSegmentedControl
{
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Кинотеатры", @"Кинопоиск"]];
    self.segmentedControl.frame = CGRectMake(50, 10, self.view.width - 100, 30);
    [self.segmentedControl addTarget:self action:@selector(segmentIsChosen:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.tintColor = [UIColor whiteColor];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentedControl];
}

- (void) initTableView
{
    CGFloat originY = self.segmentedControl.originY + self.segmentedControl.height + 10;
    
    self.cinemas = [[CinemasProvider sharedProvider] getCinemasForFilmWithId:self.filmId];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, originY, self.view.width, self.view.height - originY) style:UITableViewStylePlain];
    self.tableView.backgroundColor = tableViewBackColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (void) initWebView
{
    CGFloat originY = self.segmentedControl.originY + self.segmentedControl.height + 10;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, originY, self.view.width, self.view.height - originY)];
    [self loadDefaultPageOnWebView];
    [self.view addSubview:self.webView];
}

#pragma mark - web view

- (void) loadDefaultPageOnWebView
{
    NSString *urlString = [[FilmsProvider sharedProvider] getFilmLinkToKpById:self.filmId];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - actions

- (void) closeButtonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) segmentIsChosen:(UISegmentedControl*)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        [self.view bringSubviewToFront:self.tableView];
        [self loadDefaultPageOnWebView];
    }
    if (sender.selectedSegmentIndex == 1)
    {
        [self.view bringSubviewToFront:self.webView];
    }
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cinemas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.backgroundColor = tableViewCellColor;
    cell.textLabel.text = [[CinemasProvider sharedProvider] getCinemaNameById:[[self.cinemas[indexPath.row] objectForKey:@"id"] intValue]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    cell.imageView.image = [[CinemasProvider sharedProvider] getCinemaImageById:[[self.cinemas[indexPath.row] objectForKey:@"id"] intValue]];
    cell.imageView.clipsToBounds = YES;
    cell.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.imageView.layer.borderWidth = 1.f;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 6.f;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    CinemaVC *vc = [[CinemaVC alloc] initWithCinemaId:[[self.cinemas[indexPath.row] objectForKey:@"id"] intValue]];
    vc.mainController = self;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
