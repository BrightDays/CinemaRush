//
//  CinemasProvider.m
//  CinemaRush
//
//  Created by darya on 6/3/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import "CinemasProvider.h"

@interface CinemasProvider()

@property (nonatomic, strong) NSMutableArray *cinemas;

@end


@implementation CinemasProvider


static CinemasProvider *sharedProvider = nil;
static dispatch_once_t predicate;

+ (CinemasProvider *) sharedProvider
{
    dispatch_once( &predicate, ^{
        sharedProvider = [[super alloc] initUnique];
    });
    return sharedProvider;
}


- (id) initUnique
{
    self = [super init];
    if (self)
    {
        [self setUpCinemas];
    }
    return self;
}

- (void) setUpCinemas
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Cinemas" ofType:@"plist"];
    self.cinemas = [[NSMutableArray alloc] initWithArray:[[NSArray alloc] initWithContentsOfFile:path]];
}

- (NSArray*)getCinemasForFilmWithId:(NSInteger)identifier
{
    NSMutableArray *cinemas = [NSMutableArray new];
    for(NSDictionary *cinema in self.cinemas)
    {
        NSArray *films = [cinema objectForKey:@"films"];
        for(int i = 0; i < films.count; i++)
        {
            if ([films[i] integerValue] == identifier)
            {
                [cinemas addObject:cinema];
                break;
            }
        }
    }
    return cinemas;
}

- (NSUInteger) getCountOfCinemas
{
    return self.cinemas.count;
}

- (NSDictionary*) findCinemaById:(NSUInteger)identifier
{
    for(NSDictionary *cinema in self.cinemas)
    {
        if ([[cinema objectForKey:@"id"] integerValue] == identifier)
            return cinema;
    }
    return nil;
}

- (NSString*) getCinemaNameById:(NSInteger)identifier
{
    NSDictionary *cinema = [self findCinemaById:identifier];
    return [cinema objectForKey:@"name"];
}
- (UIImage*) getCinemaImageById:(NSInteger)identifier
{
    NSDictionary *cinema = [self findCinemaById:identifier];
    NSString *cinemaName = [cinema objectForKey:@"fileName"];
    UIImage *image = [UIImage imageNamed:cinemaName];
    return image;
}
- (NSString*) getCinemaInfoById:(NSInteger)identifier
{
    NSDictionary *cinema = [self findCinemaById:identifier];
    return [cinema objectForKey:@"info"];
}

- (NSString*) getNameOfNearestCinemaForLocation:(CLLocation *)location
{
    CGFloat x = 53.89022;
    CGFloat y = 27.55437;
    if (location)
    {
        x = location.coordinate.latitude;
        y = location.coordinate.longitude;
    }
    CGFloat distance = 1000;
    NSDictionary *result;
    for(NSDictionary *cinema in self.cinemas)
    {
        CGFloat x1 = [[cinema objectForKey:@"x"] floatValue];
        CGFloat y1 = [[cinema objectForKey:@"y"] floatValue];
        if ((x-x1)*(x-x1)+(y-y1)*(y-y1) < distance)
        {
            distance = (x-x1)*(x-x1)+(y-y1)*(y-y1);
            result = cinema;
        }
    }
    return [result objectForKey:@"name"];
}

- (CGPoint) getCinemaCoordinatesById:(NSInteger)identifier
{
    NSDictionary *cinema = [self findCinemaById:identifier];
    CGFloat x = [[cinema objectForKey:@"x"] floatValue];
    CGFloat y = [[cinema objectForKey:@"y"] floatValue];
    return CGPointMake(x, y);
}

- (NSArray*) getfilmsIdsForCinemaWithId:(NSInteger)identifier
{
    NSDictionary *cinema = [self findCinemaById:identifier];
    return [cinema objectForKey:@"films"];
}

@end
