//
//  ViewControllerMapType.m
//  BaiduMapIOS
//
//  Created by mac on 16/6/8.
//  Copyright © 2016年 LYQ. All rights reserved.
//

#import "ViewControllerMapType.h"
#import "GlobleHeaders.h"
@interface ViewControllerMapType ()<BMKMapViewDelegate>
{
    BMKMapView*_mapView;
    NSArray *_arrayBtnName;
}
@end

@implementation ViewControllerMapType

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地图类型";
    [self creatArrays];
    [self creatMapView];
    
}

//创建数组
-(void)creatArrays
{
    _arrayBtnName = @[@"普通",@"卫星",@"热力",@"交通"];
}
-(void)creatMapView
{
    //地图
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.frame];
    //缩放级别
    _mapView.zoomLevel = 15;
    self.view = _mapView;
    
    for (int i = 0;i<4 ;i++)
    {
        UIButton *buttonType = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonType.frame = CGRectMake(10+(10+(self.view.frame.size.width-50)/4.0)*i, 74, (self.view.frame.size.width-50)/4.0, 30);
        buttonType.tag = i;
        [buttonType setTitle:[_arrayBtnName objectAtIndex:i] forState:UIControlStateNormal];
        buttonType.backgroundColor = [UIColor lightGrayColor];
        [buttonType addTarget:self action:@selector(mapTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonType];
    }
}
//点击选择不同的地图类型
-(void)mapTypeClick:(UIButton *)sender
{
    //关闭百度城市热力图图层（百度自有数据）
    [_mapView setBaiduHeatMapEnabled:NO];
    //关闭实时路况图层
    [_mapView setTrafficEnabled:NO];
    switch (sender.tag) {
        case 0:
        {
            [_mapView setMapType:BMKMapTypeStandard];
            break;
        }
        case 1:
        {
            [_mapView setMapType:BMKMapTypeSatellite];
            break;
        }
            
        case 2:
        {
            [_mapView setBaiduHeatMapEnabled:YES];
            break;
        }
            
        case 3:
        {
            [_mapView setTrafficEnabled:YES];
            break;
        }
            
        default:
            break;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}


@end
