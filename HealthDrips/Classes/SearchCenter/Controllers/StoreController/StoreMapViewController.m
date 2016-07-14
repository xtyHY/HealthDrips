//
//  StoreMapViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "StoreMapViewController.h"
#import <MAMapKit/MAMapKit.h>
@interface StoreMapViewController ()<MAMapViewDelegate>

@property(nonatomic,strong) MAMapView *mapView;

@property(nonatomic,strong) MAPointAnnotation *annotation;

@end

@implementation StoreMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor whiteColor];
    
    [self CreatMap];

}

-(void)CreatMap
{
    _mapView=[[MAMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    _mapView.delegate=self;
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(self.location.latitude, self.location.longitude);
    
    //当前地图的缩放比例
    [_mapView setZoomLevel:14 animated:YES];
    
    [self.view addSubview:_mapView];
    
    _annotation=[[MAPointAnnotation alloc]init];
    _annotation.coordinate = CLLocationCoordinate2DMake(self.location.latitude, self.location.longitude);
    
    //大头针的标题
    _annotation.title = self.name;
    _annotation.subtitle = self.where;
    
    [_mapView addAnnotation:_annotation];
    
    
    
}
//大头针的回调函数
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    static NSString *cellID=@"cell";
    
    //系统的大头针
    MAPinAnnotationView *view=(id)[_mapView dequeueReusableAnnotationViewWithIdentifier:cellID];
    
    if (view==nil) {
        view=[[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:cellID];
        
        view.canShowCallout=YES;
        
        view.animatesDrop=YES;
        
        view.draggable=YES;
    }
    
    return view;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
