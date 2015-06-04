//
//  MapVC.m
//  CinemaRush
//
//  Created by darya on 5/26/15.
//  Copyright (c) 2015 BrightDays. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MapVC.h"
#import "Colors.h"
#import "Categories.h"
#import "CinemasProvider.h"

@interface MapVC ()

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = defaultColor;
    [self setup];
    [self initUI];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    MKCoordinateRegion region;
    region.center.latitude = 53.890224;
    region.center.longitude = 27.554375;
    
    region.span.latitudeDelta = 0.15;
    region.span.longitudeDelta = 0.15;
    
    MKCoordinateRegion scaledRegion = [self.mapView regionThatFits:region];
    [self.mapView setRegion:scaledRegion animated:YES];
    
}

- (void) initUI
{
    [self initMapView];
    [self initAnnotations];
}

- (void) setup
{
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
}


- (void) initMapView
{
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - self.tabBarController.tabBar.height)];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    [self.view addSubview:self.mapView];
}

- (void) initAnnotations
{
    for(int i = 0; i < [[CinemasProvider sharedProvider] getCountOfCinemas];i ++)
    {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        CGPoint location = [[CinemasProvider sharedProvider] getCinemaCoordinatesById:i];
        CLLocationCoordinate2D myCoordinate = CLLocationCoordinate2DMake(location.x, location.y);
        annotation.coordinate = myCoordinate;
        annotation.title = [[CinemasProvider sharedProvider] getCinemaNameById:i];
        [self.mapView addAnnotation:annotation];
    }
}



- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
   [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
    
    }
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {

        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = YES;
            if ([annotation.title isEqualToString:[[CinemasProvider sharedProvider] getNameOfNearestCinemaForLocation:self.mapView.userLocation.location]])
            {
                pinView.pinColor = MKPinAnnotationColorGreen;
            } else
            {
                pinView.pinColor = MKPinAnnotationColorRed;
            }
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}

 // А я великий прогер
 // Богиня Халявы
 // и Вообще очень  очень очень скромная 
 // и самая афиигенная девушка на планете ЗЕмля
 // чё уж там скромничать... Во всей ВСЕленной!!!!)))
 
 // итак... продолжим
 // Евгений, обращаюсь теперь к Вам!)
 // Вы просто божественный прогер на обдж СИ
 // Ваш тонкий ум способен создать сие великолепие без особых погтугов
 // ЗАвтра наша ВЕЛИКОЛЕПНЕЙШАЯ М.И. 
 // кончит от одного лишь лицезрения данного приложения
 // а уж от шаринга на твиттер там стонать будет вся группа!)
 
 
 // Да вообще все завтра там а*еют от нашего апплика!!!
 
 // Прекраснейшая Дарья создала ведь такую невообразимое 
 // простому смертному приземленному уму спецификацию нашего приложения
 // Скромность, ТВОРЧЕСТВО на протяжении всей документации...
 // Прям вот читаешь и вдохновляешься проделанной работой команды
 // Столь невероятным кажется данное приложение
 
 
 // А вообще поздравляю всех с окончанием это ГРЕБАННОГО СЕМЕСТРА
 // и ДА... РЕбятки, у нас МЕДИУМ
 // разве что сессию осталось сдать
 // ну эт же для нашей супертащЯщей группы вообще понты...
 // ИЗИ БРИЗИ
 // так что апосля всем суперЖаркого ЛЕТА, горячих телочек парнишам и секси парней девчонкам!)
 // и супер крутого отдыха без запар!)
 
 // Лаффки, Чмаффки и что-то там еще, не помню... 
 
 // ааа... ЧМОКИ ЧМОКИ ВСЕМ!)
 
 // =)
 
 
 
 // BY DARYA BUSEL
 
 // у меня теперь новая личность
 // Ну хотя бы имя осталось прежним
 // Дарья Бусел
 // Дарья Бусел
 // Занимаюсь какой-то  фигней
 // пишу какю-то фигню
 // лишь бы блин рейтинг адекватный вевыла 
 // нами всеми многоуважаемая и любимая М.И.
 // совсем чуть-чуть надоело уже страдать такой фигней в течении сема


@end
