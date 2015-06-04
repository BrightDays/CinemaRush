//
//  SearchVC.m
//  CinemaRush
//
//  Created by darya on 5/26/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import "SearchVC.h"
#import "Colors.h"
#import "Categories.h"
#import "FilmsProvider.h"
#import "FilmVC.h"

@interface SearchVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UILabel *noResultsLabel;
@property (nonatomic, strong) NSString *searchText;
@property (nonatomic) BOOL searchOn;

@end

@implementation SearchVC

#pragma mark - view

- (void)viewDidLoad {
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
    [self initTableView];
    [self initSearchElements];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void) initTableView
{
    CGRect frame = CGRectMake(0, 20 + 44, self.view.width, self.view.height - 20 - 43 - 50);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.backgroundColor = tableViewBackColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

}

- (void) initSearchElements
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 44)];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.placeholder = @"Search";
    self.searchBar.tintColor = [UIColor whiteColor];
    self.searchBar.delegate = self;
    self.searchOn = NO;
    self.searchText = @"";
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.view addSubview:self.searchBar];

    self.noResultsLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, self.tableView.height / 2 - 20, (self.view.width - 100 ) / 2.f, 40)];
    [self.noResultsLabel setText:@"No Results"];
    [self.noResultsLabel setTextColor:[UIColor lightGrayColor]];
    self.noResultsLabel.alpha = 0.7;
    self.noResultsLabel.hidden = YES;
//    [self.tableView addSubview:self.noResultsLabel];
}

#pragma mark - Search bar

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    self.searchText = @"";
    [self.tableView reloadData];
    searchBar.text = @"";
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    self.searchText = @"";
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchText = searchText;
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchText = searchBar.text;
    [self.tableView reloadData];
}


#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[FilmsProvider sharedProvider] getCountOfFilmsWithSearchText:self.searchText];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.backgroundColor = tableViewCellColor;
    cell.textLabel.text = [[FilmsProvider sharedProvider] getFilmNameById:indexPath.row searchText:self.searchText];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    cell.imageView.image = [[FilmsProvider sharedProvider] getFilmImageById:indexPath.row searchText:self.searchText];
    cell.imageView.clipsToBounds = YES;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 6.f;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    FilmVC *vc = [[FilmVC alloc] initWithFilmId:indexPath.row];
    self.searchText = @"";
    self.searchBar.text = @"";
    [self.tableView reloadData];
    vc.mainController = self;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

@end
