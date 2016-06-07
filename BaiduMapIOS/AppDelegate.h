//
//  AppDelegate.h
//  BaiduMapIOS
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 LYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobleHeaders.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;


@end

