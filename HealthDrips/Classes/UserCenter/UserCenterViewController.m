//
//  UserCenterViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright (c) 2015年 UpTeam. All rights reserved.
//

#import "UserCenterViewController.h"
#import "LoginViewController.h"
#import "ExonerateViewController.h"
#import "XTYClearnManager.h"
#import "FeedbackViewController.h"
#import "AboutUsViewController.h"
#import "CollectionViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

@interface UserCenterViewController ()<UITableViewDataSource,UITableViewDelegate,passNicname,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    
    UITableView * _tableView;
    //判断登录状态
    BOOL _isLogin;
    
    UIImagePickerController *_imagePicker;

    UIAlertView *_loginAlert;
    
    //用户头像
    UIButton * _headBtn;
}
@end

@implementation UserCenterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
    
    if(str != nil){
        _nameLabel.text = str;
        _isLogin = YES;
        
        UIImage * headImg = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/%@.jpg",NSHomeDirectory(),str]];
        
        if (headImg == nil) {
            headImg = [UIImage imageNamed:@"ImgDefaultSqureSmall.png"];
        }
        
        [_headBtn setBackgroundImage:headImg forState:UIControlStateNormal];
    }
    
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //更改导航栏
    [self setNavigationItem];
    [self createUI];
    // Do any additional setup after loading the view.
}

#pragma mark 设置导航栏 为导航栏设置透明的图片
- (void)setNavigationItem{
    //公开方法 通过传入的颜色 返回一张图片 传入透明颜色-》透明图片
    //给导航栏设置背景图片
//    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsCompact];
}

//颜色-》图片
- (UIImage*)createImageWithColor:(UIColor*)color{
    //绘图
    //定义显示区域
    CGRect rect = CGRectMake(0, 0, 1, 1);//返回图片的尺寸
    //创建画笔
    UIGraphicsBeginImageContext(rect.size);
    //根据所传颜色绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将所选区域铺满
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //联系显示区域
    CGContextFillRect(context, rect);
    //得到图片信息
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //把画笔消除
    UIGraphicsEndImageContext();
    return image;
}

- (void)createUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, CONTENT_HEIGHT+20) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    //布局
    _tableView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
    [self.view addSubview:_tableView];
    
    //创建图片
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -250, self.view.frame.size.width, 250)];
    imageView.tag = 2000;
    //更改图片显示模式 根据图片原有尺寸进行显示 将多余部分切除
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"settingBg" ofType:@"jpg"]];
    [_tableView addSubview:imageView];
    
    //按钮
     _headBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, -160, 100,100)];
    
    [_headBtn setBackgroundImage:[UIImage imageNamed:@"ImgDefaultSqureSmall.png"]  forState:UIControlStateNormal];
    _headBtn.layer.masksToBounds = YES;
    _headBtn.layer.cornerRadius = 50;
    _headBtn.layer.borderColor = RGB(240, 240, 240).CGColor;
    _headBtn.layer.borderWidth = 2.0f;
    //改变字体大小
    _headBtn.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    _headBtn.titleLabel.adjustsFontSizeToFitWidth = YES;//自适应
    [_headBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_headBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:_headBtn];
    
    //用户名
    UIView * textCon = [[UIView alloc] initWithFrame:CGRectMake(0, -40, SCREEN_WIDTH,40)];
    textCon.backgroundColor = RGBA(255, 255, 255, 0.7);
    [_tableView addSubview:textCon];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,textCon.frame.size.height)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = @"点击上方登陆";
    
    _nameLabel.textColor = RGBA(100, 100, 100, 100);
    [textCon addSubview:_nameLabel];

}

//执行协议方法
- (void)passNicName:(NSString *)nicname{
    
    _nameLabel.text = nicname;
    _isLogin = YES;
    
}

#pragma mark 头像点击事件
- (void)buttonClick{
    
    if (_isLogin == NO) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.delegate = self;
        loginVC.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }else{
        
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选取头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        [sheet showInView:self.view];
    }
   
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [self initPickCameraPicker];
    }else if (buttonIndex == 1){
        [self initPicImagePicker];
    }
}

#pragma mark 调取系统相册
- (void)initPicImagePicker{
    
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;  //数据来源，摄像头
    _imagePicker.allowsEditing=YES;//允许编辑
    _imagePicker.delegate=self;//设置代理，检测操作
    [self presentViewController:_imagePicker animated:YES completion:^{
        
    }];
}

#pragma mark 调取系统相机
- (void)initPickCameraPicker{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:^{
        
    }];//进入照相界面

}


#pragma mark -UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [[UIImage alloc]init];
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [_headBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {//如果是拍照
        UIImage *orignalImage = nil;
        UIImage *cropImage = nil;
        if (_imagePicker.allowsEditing) {
            
            cropImage=[info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
            UIImageWriteToSavedPhotosAlbum(cropImage, nil, nil, nil);//保存到相簿
            image= [info objectForKey:@"UIImagePickerControllerEditedImage"];
            [_headBtn setBackgroundImage:image forState:UIControlStateNormal];
            
        }else{
            
            orignalImage=[info objectForKey:UIImagePickerControllerOriginalImage];//获取原始照片
            UIImageWriteToSavedPhotosAlbum(orignalImage, nil, nil, nil);//保存到相簿
            image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            [_headBtn setBackgroundImage:image forState:UIControlStateNormal];
        }
    }
    
    //保存成jpg写到沙盒中文件名为 用户名.jpg
    NSString * savePath = [NSString stringWithFormat:@"%@/Documents/%@.jpg",NSHomeDirectory(),_nameLabel.text];
    [UIImageJPEGRepresentation(image, 0.5) writeToFile:savePath atomically:NO];
    
//    NSLog(@"%@",savePath);
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 滚动视图的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float offSet = scrollView.contentOffset.y;
    
    //找到ImageView
    UIImageView * tempImageView = (UIImageView*)[self.view viewWithTag:2000];
    
    if (offSet < -250) {
        CGRect f = tempImageView.frame;
        //保持图片原点仍为屏幕左上方
        f.origin.y = offSet;
        //保证图片根据滑动高度拉伸
        f.size.height = -offSet;
        //给图片重新设置坐标
        tempImageView.frame = f;
    }else{
        
    }
}

//改变表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isLogin == NO) {
        return 2;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 3;
        
    }else if (section == 1){
        return 2;
    }else {
        if (_isLogin == YES) {
            return 1;
        }
    }
    return 0;

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"我的收藏";
            cell.imageView.image = [UIImage imageNamed:@"setting-icon-fav-black"];
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"用户反馈";
            cell.imageView.image = [UIImage imageNamed:@"setting-icon-feedback-black"];
        }else{
            cell.textLabel.text = @"清除缓存";
            cell.imageView.image = [UIImage imageNamed:@"setting-icon-clean-black"];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"免责声明";
            cell.imageView.image = [UIImage imageNamed:@"setting-icon-annonce-black"];
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"关于我们";
            cell.imageView.image = [UIImage imageNamed:@"setting-icon-about-black"];
        }
    }else{
        
        cell.textLabel.text = @"退出登录";
        cell.imageView.image = [UIImage imageNamed:@"setting-icon-logout-black"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark UITableView调节行高 默认行高为44
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return 44;
}
#pragma mark UITableView点击行时触发方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //去除系统默认的点击效果 添加点击动画
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    NSLog(@"点击为:%ld段 %ld行",indexPath.section,indexPath.row);
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //我的收藏
            
            if (_isLogin == YES) {
                
                self.hidesBottomBarWhenPushed = YES;
                CollectionViewController * collectVc = [[CollectionViewController alloc ]init];
                collectVc.title = @"我的收藏";
                collectVc.userName = _nameLabel.text;
                [self.navigationController pushViewController:collectVc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
                self.navigationController.navigationBarHidden = NO;
            }else{
            
                UIAlertView * NoLoginAlertView = [[UIAlertView alloc] initWithTitle:@"您还没有登录" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [NoLoginAlertView show];
            }
            
        }else if (indexPath.row == 1){
            //用户反馈
            self.hidesBottomBarWhenPushed = YES;
            FeedbackViewController * feedbackVc = [[FeedbackViewController alloc] init];
            feedbackVc.title = @"反馈";
            [self.navigationController pushViewController:feedbackVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            self.navigationController.navigationBarHidden = NO;
        }else if(indexPath.row == 2){
           //清除缓存
            [self clearCache];
        }
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 0) {
          //免责声明
            ExonerateViewController * exonerateVc = [[ExonerateViewController alloc] init];
            exonerateVc.title = @"免责声明";
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:exonerateVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            self.navigationController.navigationBarHidden = NO;
        }else if (indexPath.row == 1){
           //关于我们
            AboutUsViewController * aboutVc = [[AboutUsViewController alloc] init];
            aboutVc.title = @"关于我们";
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutVc animated:YES];
            self.navigationController.navigationBarHidden = NO;
            self.hidesBottomBarWhenPushed = NO;
        }
        
    }else{
        
        if(_isLogin == NO){
            UIAlertView *loginAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有登录，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [loginAlert show];
        }else{
            _loginAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定退出么?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [_loginAlert show];
        }
    }
}

#pragma mark 清除缓存
- (void)clearCache{

    float cacheSize = [XTYClearnManager folderSizeAtPath:[NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]];
    
    NSString * msg;
    NSString * btn1;
    NSString * btn2;
    if (cacheSize > 0.1 ) {
        msg = cacheSize>1 ? [NSString stringWithFormat:@"是否清理缓存(%.2lfMB)",cacheSize] : [NSString stringWithFormat:@"是否清理缓存(%.2lfKB)",cacheSize * 1024];
        btn1 = @"取消";
        btn2 = @"确定";
    }else{
    
        msg = @"垃圾已清理干净";
        btn1 = @"确定";
        btn2 = nil;
    }
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"缓存清理" message:msg delegate:self cancelButtonTitle:btn1 otherButtonTitles:btn2, nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex) {
        [XTYClearnManager clearCache:[NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]];
        [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()] withIntermediateDirectories:YES attributes:nil error:nil];
        //NSLog(@"%@/Library/Caches",NSHomeDirectory());
    }
    
    if ([alertView isEqual: _loginAlert]) {
        if (buttonIndex == 1) {
            //退出登录处理
            _isLogin = NO;
            _nameLabel.text = @"点击上方登陆";
            [_headBtn setBackgroundImage:[UIImage imageNamed:@"ImgDefaultSqureSmall.png"] forState:UIControlStateNormal];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickname"];
            [_tableView reloadData];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置分割线从顶端开始 适配ios7和ios8
- (void)viewDidLayoutSubviews{
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
