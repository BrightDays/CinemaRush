//
//  HomeVC.m
//  CinemaRush
//
//  Created by darya on 6/3/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import "HomeVC.h"
#import "Categories.h"
#import "FilmsProvider.h"
#import "Colors.h"
#import "ScrollViewContainer.h"
#import "FilmVC.h"

@interface HomeVC ()

//@property (nonatomic) CGSize bannerSize;
@property (nonatomic) CGFloat marginLeft;
@property (nonatomic) CGFloat distanceBetweenBanners;
@property (nonatomic) NSInteger bannersCount;
@property (nonatomic) CGSize viewSize;
@property (nonatomic) CGSize bannerSize;
@property (nonatomic) CGFloat marginTop;
@property (nonatomic) ScrollViewContainer *scrollViewContainer;

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UILabel *topBarLabel;

@property (nonatomic) BOOL shouldReload;

@property (nonatomic, strong) NSArray *filmsIds;

@end


#define kPageIndicatorColor [UIColor lightGrayColor]
#define kCurrentPageIndicatorColor [UIColor whiteColor]

#define kActivePageNumber 2
#define kControllersCount 5


@implementation HomeVC

#pragma mark - view

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.shouldReload = YES;
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.scrollViewContainer.scrollView scrollRectToVisible:CGRectMake((kActivePageNumber + 1) * self.scrollViewContainer.scrollView.frame.size.width, 0, 1, 1) animated:NO];
    if (self.shouldReload)
    {
        self.filmsIds = [[FilmsProvider sharedProvider] getRandomFilmsIdsWithCount:kControllersCount];
        [self loadAllPages];
    } else
        self.shouldReload = YES;
}

#pragma mark - ui

- (void) initUI
{
    self.view.backgroundColor = defaultColor;
    self.view.frame = CGRectMake(0, 0, self.view.width, self.view.height - self.tabBarController.tabBar.height);
    [self setNeedsStatusBarAppearanceUpdate];
    [self setUpTopBar];
    [self setUpParameters];
    [self setUpPages];
    [self setUpScrollViewContainer];
    [self setUpPageControl];
    [self setUpView];

}

#pragma mark - setting up

- (void) setUpParameters
{
    self.marginTop = self.topBarView.height + 30;
    self.marginLeft = 40;
    self.distanceBetweenBanners = 20;
    
    self.viewSize = CGSizeMake(self.view.width, self.view.height);
    self.bannerSize = CGSizeMake((self.view.width - self.marginLeft * 2),(self.view.width - self.marginLeft * 2) * 10/7) ;
    self.bannersCount = kControllersCount;
}

- (void) setUpTopBar
{
    self.topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 90)];
    self.topBarView.backgroundColor = tableViewBackColor;
    self.topBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, self.view.width, 40)];
    self.topBarLabel.backgroundColor = [UIColor clearColor];
    self.topBarLabel.textAlignment = NSTextAlignmentCenter;
    self.topBarLabel.textColor = [UIColor whiteColor];
    self.topBarLabel.font = [UIFont fontWithName:@"Helvetica" size:20.f];
    [self.topBarView addSubview:self.topBarLabel];
    [self.view addSubview:self.topBarView];
}


- (void) setUpPages
{
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.bannersCount; i++)
    {
        [self.pageViews addObject:[NSNull null]];
    }
}

- (void) setUpView
{
    [self.view setFrame:CGRectMake(0, 0, self.viewSize.width, self.viewSize.height)];
    self.view.clipsToBounds = YES;
    [self.view addSubview:self.scrollViewContainer];
    [self.view addSubview:self.pageControl];
}

- (void) setUpScrollViewContainer
{
    
    self.scrollViewContainer = [[ScrollViewContainer alloc] initWithFrame:CGRectMake(0, self.marginTop, self.viewSize.width, self.bannerSize.height)];
    self.scrollViewContainer.clipsToBounds = YES;
    
    self.scrollViewContainer.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.marginLeft - self.distanceBetweenBanners / 2, 0, self.bannerSize.width + self.distanceBetweenBanners, self.bannerSize.height)];
    self.scrollViewContainer.scrollView.pagingEnabled = YES;
    self.scrollViewContainer.scrollView.delegate = self;
    self.scrollViewContainer.scrollView.clipsToBounds = NO;
    self.scrollViewContainer.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollViewContainer.scrollView.contentSize = CGSizeMake(self.scrollViewContainer.scrollView.frame.size.width * self.bannersCount, self.scrollViewContainer.scrollView.frame.size.height);
    
    [self.scrollViewContainer addSubview:self.scrollViewContainer.scrollView];
}

- (void) setUpPageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    self.pageControl.center = CGPointMake(self.viewSize.width / 2, (self.viewSize.height + self.scrollViewContainer.frame.origin.y + self.scrollViewContainer.frame.size.height) / 2);
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = kPageIndicatorColor;
    self.pageControl.currentPageIndicatorTintColor = kCurrentPageIndicatorColor;
    self.pageControl.numberOfPages = self.bannersCount;
}

- (void) loadVisiblePages
{
    CGFloat pageWidth = self.scrollViewContainer.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollViewContainer.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    self.pageControl.currentPage = page;
    self.topBarLabel.text = [[FilmsProvider sharedProvider] getFilmNameById:[self.filmsIds[page] intValue]];
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    for (NSInteger i = 0; i < firstPage; i++)
    {
        [self purgePage:i];
    }
    for (NSInteger i = firstPage; i <= lastPage; i++)
    {
        [self loadPage:i];
    }
    for (NSInteger i = lastPage+1; i < self.bannersCount; i++)
    {
        [self purgePage:i];
    }
}

- (void) loadAllPages
{
    CGFloat pageWidth = self.scrollViewContainer.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollViewContainer.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    self.pageControl.currentPage = page;
    self.topBarLabel.text = [[FilmsProvider sharedProvider] getFilmNameById:[self.filmsIds[page] intValue]];

    for (NSInteger i = 0; i < self.bannersCount; i++)
    {
        [self purgePage:i];
    }
    for (NSInteger i = 0; i <= self.bannersCount; i++)
    {
        [self loadPage:i];
    }
}



- (void) loadPage:(NSInteger)page
{
    if (page < 0 || page >= self.bannersCount)
    {
        return;
    }
    
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull *)pageView == [NSNull null])
    {
        CGRect frame = [self getPageViewFrameForPage:page];
        
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[[FilmsProvider sharedProvider] getFilmImageById:[self.filmsIds[page] intValue]]];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        newPageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnBanner:)];
        recognizer.numberOfTapsRequired = 1;
        [newPageView addGestureRecognizer:recognizer];
        
        [self.scrollViewContainer.scrollView addSubview:newPageView];
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}

- (CGRect) getPageViewFrameForPage:(NSInteger) page
{
    CGRect frame = self.scrollViewContainer.scrollView.bounds;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0.0f;
    frame = CGRectInset(frame, self.distanceBetweenBanners / 2, 0.0f);
    return frame;
}


- (void) purgePage:(NSInteger)page
{
    if (page < 0 || page >= self.bannersCount)
    {
        return;
    }
    
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull *)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self loadVisiblePages];
}

-(void) tapOnBanner:(UIGestureRecognizer *)sender
{
    FilmVC *vc = [[FilmVC alloc] initWithFilmId:[self.filmsIds[self.pageControl.currentPage] intValue]];
    vc.mainController = self.tabBarController;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    __weak HomeVC *weakSelf = self;
    [self presentViewController:nc animated:YES completion:^{
        weakSelf.shouldReload = NO;
    }];
}




@end
