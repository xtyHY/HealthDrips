//
//  RegisterViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright © 2015年 UpTeam. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserNoticeViewController.h"
@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(240,240,240);
    
    [self createUI];
    
}

- (void)createUI{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:SCREEN_RECT];
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [_scrollView addGestureRecognizer:gesture];
    
    NSArray *placeTitleArr = @[@"请输入账户",@"请输入昵称",@"请输入密码",@"请确认密码",@"请输入邮箱(选填)"];
    NSArray *leftViewArr = @[@"账户",@"昵称",@"密码",@"确认密码",@"邮箱"];
    for (int i = 0; i < 5; i++) {
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(35, 30+i*45,self.view.frame.size.width-70 , 45)];
        textField.delegate = self;
        textField.clearsOnBeginEditing = YES;
        textField.tag = 100 + i;
        textField.placeholder = placeTitleArr[i];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [_scrollView addSubview:textField];
        
        UILabel *leftView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 50)];
        leftView.text = leftViewArr[i];
        leftView.font = [UIFont systemFontOfSize:15];
        leftView.textAlignment = NSTextAlignmentCenter;
        [textField setLeftView:leftView];
        
        UILabel *rightView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        rightView.font = [UIFont systemFontOfSize:13];
        [textField setRightView:rightView];
        
        [textField setLeftViewMode:UITextFieldViewModeAlways];
        
        if (textField.tag == 102 || textField.tag == 103) {
            textField.secureTextEntry = YES;
        }
    }
    
    //注册按钮
    UIButton *registerbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    registerbutton.frame = CGRectMake(self.view.frame.size.width-100, 280, 50, 50);
    [registerbutton setTitle:@"注册" forState:UIControlStateNormal];
    registerbutton.titleLabel.font = [UIFont systemFontOfSize:20];
    [registerbutton addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:registerbutton];
    
    
    //用户注册协议
    UIButton *userNoticeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userNoticeBtn.frame = CGRectMake(self.view.frame.size.width-165, 265, 130, 20);
    [userNoticeBtn setTitle:@"《用户注册协议须知》" forState:UIControlStateNormal];
    userNoticeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    userNoticeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [userNoticeBtn addTarget:self action:@selector(userBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [userNoticeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:userNoticeBtn];
}

- (void)userBtnClick{
    
    UserNoticeViewController *noticeVC = [[UserNoticeViewController alloc]init];
    
    noticeVC.title = @"注册须知";

    noticeVC.hidesBottomBarWhenPushed = YES;
  
    [self.navigationController pushViewController:noticeVC animated:YES];
}


//响应事件
- (void)tapClick:(UITapGestureRecognizer *)gesture{
    for (UITextField *textField in _scrollView.subviews) {
        if ([textField isKindOfClass:[UITextField class]]) {
            [textField resignFirstResponder];
        }
    }
}

//控制输入的字符数
- (void)textFieldDidChange:(UITextField *)textField{
    
    //长度限制account(20),password(20),nickname(20)
    UITextField *acountText = (UITextField *)[self.view viewWithTag:100];
    UITextField *nameText = (UITextField *)[self.view viewWithTag:101];
    UITextField *passwordText = (UITextField *)[self.view viewWithTag:102];
    UITextField *surepassText = (UITextField *)[self.view viewWithTag:103];
     UITextField *emailText = (UITextField *)[self.view viewWithTag:104];
    if (textField == acountText || textField == nameText || textField == passwordText || textField == surepassText) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }else if (textField == emailText){
        if (textField.text.length > 40) {
            textField.text = [textField.text substringToIndex:40];
        }
    }
}

- (void)registerClick{
    
    UITextField *acountText = (UITextField *)[self.view viewWithTag:100];
    UITextField *nameText = (UITextField *)[self.view viewWithTag:101];
    UITextField *passwordText = (UITextField *)[self.view viewWithTag:102];
    UITextField *surepassText = (UITextField *)[self.view viewWithTag:103];
    UITextField *emailText = (UITextField *)[self.view viewWithTag:104];
    
    /*正则表达式判断邮箱
     
     /^(([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-]
     
     /^(([a-zA-Z0-9_-])是表示 @ 符号之前的字符串是由 小写字母、大写字母、数字、下划线、中划线多个字符组成字符串
     ([a-zA-Z0-9_-])是表示@ 符号之后的字符串是由 小写字母、大写字母、数字、下划线、中划线多个字符组成字符串
     \.[a-zA-Z0-9_-] 表示由小黑点和小写字母、大写字母、数字、下划线、中划线多个字符组成字符串
     /^表示多个
     
     */

    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    if ([nameText.text isEqualToString:@""]||[passwordText.text isEqualToString:@""]||[surepassText.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请完善信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        return;
    }
    
    if (![emailText.text isEqualToString:@""]) {
        if (![emailTest evaluateWithObject:emailText.text]){
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"邮箱格式错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
            return;
            
        }

    }
   
    NSString * url = API_USER_REGISTER;

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //请求//account、password、nickname(昵称)选填email(邮箱)、icon(头像)
    NSDictionary * dict = @{@"account":acountText.text,
                            @"password":passwordText.text,
                            @"nickname":nameText.text};
    
    [manager GET:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary * rootDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //对code进行判断
        if ([rootDict[@"code"] isEqualToString:@"1002"]) {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:rootDict[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            
            [alert show];

        }else{
            //注册成功 返回登录界面
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
            [self.navigationController popViewControllerAnimated:YES];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }];

}


//视图位置移动
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField.frame.origin.y>180) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        
        self.view.bounds=CGRectMake(0, 60, self.view.bounds.size.width,self.view.bounds.size.height);
        [UIView commitAnimations];
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.bounds=CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height);
    [UIView commitAnimations];

    if (textField.tag == 103) {
        
        UITextField *passwordText = (UITextField *)[self.view viewWithTag:102];
        
        if (![passwordText.text isEqualToString:textField.text]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
        }
    }
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
