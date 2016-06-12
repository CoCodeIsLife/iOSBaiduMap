//
//  ViewController.m
//  BaiduMapIOS
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 LYQ. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerMapType.h"
#import "ViewControllerPosition.h"
//#import "GlobleHeaders.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
//{
//    BMKMapView*_mapView;
//    NSArray *_arrayBtnName;
//}
{
    NSArray *_arrayFonction;
    NSArray *_arrayViewControllers;
    
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _arrayFonction = @[@"地图类型-MapType",@"定位功能",@"地理编码",@"公交线路规划",@"云检索功能",@"周边雷达"];

    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayFonction.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [_arrayFonction objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            ViewControllerMapType *ctr = [[ViewControllerMapType alloc]init];
            [self.navigationController pushViewController:ctr animated:YES];
            break;
        }
        case 1:{
            ViewControllerPosition *ctr = [[ViewControllerPosition alloc]init];
            [self.navigationController pushViewController:ctr animated:YES];
            break;
        }
        case 2:{
            ViewControllerMapType *ctr = [[ViewControllerMapType alloc]init];
            [self.navigationController pushViewController:ctr animated:YES];
            break;
        }
        case 3:{
            ViewControllerMapType *ctr = [[ViewControllerMapType alloc]init];
            [self.navigationController pushViewController:ctr animated:YES];
            break;
        }
        case 4:{
            ViewControllerMapType *ctr = [[ViewControllerMapType alloc]init];
            [self.navigationController pushViewController:ctr animated:YES];
            break;
        }

        default:
            break;
    }
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatArrays];
    [self creatMapView];
//    [self daTouZhenBiaoZhu];
    
    
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
    _mapView.zoomLevel = 10;
    
    
    
    self.view = _mapView;

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
    
    //定位按钮
    UIButton *buttonL = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonL.frame = CGRectMake(10,self.view.frame.size.height-40, 15,15);
    buttonL.backgroundColor = [UIColor lightGrayColor];
    [buttonL addTarget:self action:@selector(myPlace) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonL];
    
    
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
    
    [self zhouBianLeiDa];
    
    
}
//折线协议方法
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
//周边雷达
-(void)zhouBianLeiDa
{
    BMKRadarManager *_radarManager = [BMKRadarManager getRadarManagerInstance];
//    在不需要时，通过下边的方法使引用计数减1
    [BMKRadarManager releaseRadarManagerInstance];
    _radarManager.userId = @"baidu_mapsdk_radarid";
    [_radarManager addRadarManagerDelegate:self];
    
    //构造我的位置信息
    BMKRadarUploadInfo *myinfo = [[BMKRadarUploadInfo alloc] init];
    myinfo.extInfo = @"hello,world";//扩展信息
    myinfo.pt = CLLocationCoordinate2DMake(39.916, 116.404);//我的地理坐标
    //上传我的位置信息
    BOOL res = [_radarManager uploadInfoRequest:myinfo];
    if (res) {
        NSLog(@"upload 成功");
    } else {
        NSLog(@"upload 失败");
    }
    
    [_radarManager startAutoUpload:5];
    
    
    BMKRadarNearbySearchOption *option = [[BMKRadarNearbySearchOption alloc] init]
    ;
    option.radius = 8000;//检索半径
    option.sortType = BMK_RADAR_SORT_TYPE_DISTANCE_FROM_NEAR_TO_FAR;//排序方式
    option.centerPt = CLLocationCoordinate2DMake(39.916, 116.404);//检索中心点
    //发起检索
    BOOL result = [_radarManager getRadarNearbySearchRequest:option];
    if (result) {
        NSLog(@"get 成功");
    } else {
        NSLog(@"get 失败");
    }
    

}


- (void)onGetRadarNearbySearchResult:(BMKRadarNearbyResult *)result error:(BMKRadarErrorCode)error {
    NSLog(@"Result  %@", result);
    if (error == BMK_RADAR_NO_ERROR) {
        
        
    }
}


-(void)daTouZhenBiaoZhu
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
}
//大头针
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if([annotation isKindOfClass:[BMKAnnotationView class]])
    {
        BMKPinAnnotationView *annotationView =(BMKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"BMKPinAnnotationView *annotationView"];
        if (annotationView ==nil) {
            annotationView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
            annotationView.pinColor = BMKPinAnnotationColorRed;
            annotationView.animatesDrop = YES;
        }

        return annotationView;
    }
    return nil;
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
*/
@end
