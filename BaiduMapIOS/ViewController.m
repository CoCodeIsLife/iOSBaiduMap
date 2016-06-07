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
    NSArray *_arrayBtnName;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatArrays];
    [self creatMapView];
    
    
    
    
    
    
    
}
-(void)creatArrays
{
    _arrayBtnName = @[@"普通",@"卫星",@"热力",@"交通"];
}
-(void)creatMapView
{
    //地图
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 80)];
//    self.view = _mapView;
    [self.view addSubview:_mapView];
    for (int i = 0;i<4 ;i++)
    {
        UIButton *buttonType = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonType.frame = CGRectMake(10+(10+(self.view.frame.size.width-50)/4.0)*i, 30, (self.view.frame.size.width-50)/4.0, 30);
        buttonType.tag = i;
        [buttonType setTitle:[_arrayBtnName objectAtIndex:i] forState:UIControlStateNormal];
        buttonType.backgroundColor = [UIColor lightGrayColor];
        [buttonType addTarget:self action:@selector(mapTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:buttonType];
    }

    
}
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
