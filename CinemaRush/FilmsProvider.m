//
//  FilmsProvider.m
//  CinemaRush
//
//  Created by darya on 6/2/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import "FilmsProvider.h"

@interface FilmsProvider()

@property (nonatomic, strong) NSArray *films;
@property (nonatomic, strong) NSMutableArray *searchFilms;
@property (nonatomic, strong) NSString *lastSearchText;

@end

@implementation FilmsProvider

static FilmsProvider *sharedProvider = nil;
static dispatch_once_t predicate;

+ (FilmsProvider *) sharedProvider
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
        [self setUpFilms];
    }
    return self;
}

- (void) setUpFilms
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Films" ofType:@"plist"];
    self.films = [[NSArray alloc] initWithContentsOfFile:path];
}

- (NSDictionary*) findFilmById:(NSInteger)identifier
{
    for(NSDictionary *film in self.films)
    {
        if ([[film objectForKey:@"id"] integerValue] == identifier)
            return film;
    }
    return nil;
}

- (NSUInteger) getCountOfFilms
{
    return self.films.count;
}

- (NSString*) getFilmNameById:(NSInteger)identifier
{
    NSDictionary *film = [self findFilmById:identifier];
    return [film objectForKey:@"name"];
}

- (UIImage*) getFilmImageById:(NSInteger)identifier
{
    NSDictionary *film = [self findFilmById:identifier];
    NSString *filmName = [film objectForKey:@"fileName"];
    UIImage *image = [UIImage imageNamed:filmName];
    return image;
}

- (NSString*) getFilmLinkToKpById:(NSInteger)identifier
{
    NSDictionary *film = [self findFilmById:identifier];
    return [film objectForKey:@"kpLink"];
}

- (void) refreshSearchFilms
{
    self.searchFilms = [NSMutableArray new];
    for(NSDictionary *film in self.films)
    {
        NSString *filmName = [film objectForKey:@"name"];
        if ([filmName rangeOfString:self.lastSearchText options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [self.searchFilms addObject:film];
        }
    }
}


- (NSDictionary*) findSearchFilmById:(NSInteger)identifier
{
    return self.searchFilms[identifier];
}

- (NSUInteger) getCountOfFilmsWithSearchText:(NSString*)text
{
    if ([text isEqualToString:@""])
        return [self getCountOfFilms];
    if (![text isEqualToString:self.lastSearchText])
    {
        self.lastSearchText = text;
        [self refreshSearchFilms];
    }
    return self.searchFilms.count;
}
- (NSString*) getFilmNameById:(NSInteger)identifier searchText:(NSString*)text
{
    if ([text isEqualToString:@""])
        return [self getFilmNameById:identifier];
    if (![text isEqualToString:self.lastSearchText])
    {
        self.lastSearchText = text;
        [self refreshSearchFilms];
    }
    
    NSDictionary *film = [self findSearchFilmById:identifier];
    return [film objectForKey:@"name"];
}
- (UIImage*) getFilmImageById:(NSInteger)identifier searchText:(NSString*)text
{
    if ([text isEqualToString:@""])
        return [self getFilmImageById:identifier];
    if (![text isEqualToString:self.lastSearchText])
    {
        self.lastSearchText = text;
        [self refreshSearchFilms];
    }

    NSDictionary *film = [self findSearchFilmById:identifier];
    NSString *filmName = [film objectForKey:@"fileName"];
    UIImage *image = [UIImage imageNamed:filmName];
    return image;
}
- (NSString*) getFilmLinkToKpById:(NSInteger)identifier searchText:(NSString*)text
{
    if ([text isEqualToString:@""])
        return [self getFilmLinkToKpById:identifier];
    if (![text isEqualToString:self.lastSearchText])
    {
        self.lastSearchText = text;
        [self refreshSearchFilms];
    }
    
    NSDictionary *film = [self findSearchFilmById:identifier];
    return [film objectForKey:@"kpLink"];
}

- (NSArray*) getRandomFilmsIdsWithCount:(NSInteger)count
{
    NSMutableArray *films = [NSMutableArray new];
    int i = 0;
    while(i < count)
    {
        int identifier = rand() % self.films.count;
        BOOL equal = NO;
        for(NSNumber *number in films)
        {
            if ([number intValue] == identifier)
            {
                equal = YES;
                break;
            }
        }
        if (!equal)
        {
            [films addObject:[NSNumber numberWithInt:identifier]];
            i++;
        }
    }
    return films;
}

@end
