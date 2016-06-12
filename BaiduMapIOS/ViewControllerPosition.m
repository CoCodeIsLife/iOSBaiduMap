//
//  ViewControllerPosition.m
//  BaiduMapIOS
//
//  Created by mac on 16/6/12.
//  Copyright © 2016年 LYQ. All rights reserved.
//

#import "ViewControllerPosition.h"
#import "GlobleHeaders.h"
@interface ViewControllerPosition ()<BMKMapViewDelegate>
{
    BMKMapView *_mapView;
}
@end

@implementation ViewControllerPosition

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_mapView];
    //定位按钮
    UIButton *buttonL = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonL.frame = CGRectMake(10,self.view.frame.size.height-40, 15,15);
    buttonL.backgroundColor = [UIColor lightGrayColor];
    [buttonL addTarget:self action:@selector(myPlace) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonL];


}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

-(void)myPlace
{
    //大头针标注
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    annotation.coordinate = coor;
    annotation.title = @"这里是北京";
    annotation.subtitle = @"北京天安门";
    [_mapView addAnnotation:annotation];
    
    
    //折线
    // 添加折线覆盖物
    CLLocationCoordinate2D coors[3] = {0};
    coors[0].latitude = 39.315;
    coors[0].longitude = 116.304;
    
    coors[1].latitude = 39.515;
    coors[1].longitude = 116.504;
    
    coors[2].latitude = 39.915;
    coors[2].longitude = 116.404;
    BMKPolyline* polyline = [BMKPolyline polylineWithCoordinates:coors count:3];
    [_mapView addOverlay:polyline];
    

}

//折线协议方法(如果不加_mapView.delegate = self) 不会执行;
-(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView =[[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 5.0;
        
        return polylineView;
    }
    return nil;
}


//大头针
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if([annotation isKindOfClass:[BMKAnnotationView class]])
    {
        BMKPinAnnotationView *annotationView =(BMKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"BMKannotationView"];
        if (annotationView ==nil) {
            annotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"BMKannotationView"];
            annotationView.pinColor = BMKPinAnnotationColorPurple;
            annotationView.animatesDrop = YES;
        }
        
        return annotationView;
    }
    return nil;
}

@end
