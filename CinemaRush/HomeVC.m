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

@interface HomeVC ()

@property (nonatomic) CGSize viewSize;
@property (nonatomic) CGSize bannerSize;
@property (nonatomic) CGFloat marginTop;
@property (nonatomic) CGFloat marginLeft;
@property (nonatomic) CGFloat distanceBetweenBanners;
@property (nonatomic) NSInteger bannersCount;
@property (nonatomic) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *pageViews;
@end


#define kPageIndicatorColor [UIColor lightGrayColor]
#define kCurrentPageIndicatorColor [UIColor whiteColor]

#define kActivePageNumber 2
#define kControllersCount 5


@implementation HomeVC

#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, self.view.width, self.view.height - self.tabBarController.tabBar.height);
    self.view.backgroundColor = defaultColor;
    [self setUpParameters];
    [self setUpPages];
    [self setUpScrollView];
    [self setUpPageControl];
    [self setUpView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.scrollView scrollRectToVisible:CGRectMake((kActivePageNumber + 1) * self.scrollView.frame.size.width, 0, 1, 1) animated:NO];
    [self loadVisiblePages];
}

- (void) setUpParameters
{
    self.viewSize = self.view.size;
    self.bannerSize = CGSizeMake(self.view.width - 40, (self.view.width - 40) * 10.f / 7.f);
    self.marginTop = 100;
    self.marginLeft = 20;
    self.distanceBetweenBanners = self.marginLeft;
    self.bannersCount = kControllersCount;
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
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
}

- (void) setUpScrollView
{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.marginLeft - self.distanceBetweenBanners / 2, (self.view.height - 30 - self.bannerSize.height) / 2, self.bannerSize.width + self.distanceBetweenBanners, self.bannerSize.height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.clipsToBounds = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.bannersCount, self.scrollView.frame.size.height);

}

- (void) setUpPageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    self.pageControl.center = CGPointMake(self.viewSize.width / 2, (self.viewSize.height + self.scrollView.frame.origin.y + self.scrollView.frame.size.height) / 2);
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = kPageIndicatorColor;
    self.pageControl.currentPageIndicatorTintColor = kCurrentPageIndicatorColor;
    self.pageControl.numberOfPages = self.bannersCount;
}

- (void) loadVisiblePages
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    self.pageControl.currentPage = page;
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
        
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[[FilmsProvider sharedProvider] getFilmImageById:page]];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        newPageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnBanner:)];
        recognizer.numberOfTapsRequired = 1;
        [newPageView addGestureRecognizer:recognizer];
        
        [self.scrollView addSubview:newPageView];
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}

- (CGRect) getPageViewFrameForPage:(NSInteger) page
{
    CGRect frame = self.scrollView.bounds;
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
    
}


@end
