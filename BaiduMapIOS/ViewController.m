//
//  ViewController.m
//  BaiduMapIOS
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 LYQ. All rights reserved.
//

#import "ViewController.h"
#import "GlobleHeaders.h"
@interface ViewController ()<BMKMapViewDelegate>
{
    BMKMapView*_mapView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.frame];
    self.view = _mapView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
