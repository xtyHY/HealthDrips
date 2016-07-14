//
//  LoginViewController.m
//  HealthDrips
//
//  Created by HY.
//  Copyright © 2015年 UpTeam. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()
{

    NSString * _nickName;
}
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    
    self.view.backgroundColor = RGB(240,240,240);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBarBgColor.png"] forBarMetrics:UIBarMetricsDefault];

    [self createUITextField];
    [self createUIButton];
}


- (void)createUITextField{

    for (int i = 0; i < 2; i++) {
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(35, 50+i*45,self.view.frame.size.width-70 , 45)];
        textField.tag = 100 + i;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:textField];
    }
    
    //用户名
    UITextField *nameTextField = (UITextField *)[self.view viewWithTag:100];
    nameTextField.placeholder = @"请输入账户";
    
    UILabel *leftView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    leftView.font = [UIFont systemFontOfSize:15];
    leftView.text = @"账户";
    leftView.textAlignment = NSTextAlignmentCenter;
    [nameTextField setLeftView:leftView];

    UILabel *rightView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    rightView.font = [UIFont systemFontOfSize:13];

    [nameTextField setRightView:rightView];

    [nameTextField setLeftViewMode:UITextFieldViewModeAlways];
    
    
    //用户密码
    UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:101];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.secureTextEntry = YES;
    UILabel *passleftView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    passleftView.font = [UIFont systemFontOfSize:15];
    passleftView.text = @"密码";
    passleftView.textAlignment = NSTextAlignmentCenter;
    [passwordTextField setLeftView:passleftView];
    
    UILabel *passrightView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    passrightView.font = [UIFont systemFontOfSize:13];
    passrightView.backgroundColor = [UIColor yellowColor];
    [passwordTextField setRightView:passrightView];
    
    [passwordTextField setLeftViewMode:UITextFieldViewModeAlways];
}

- (void)createUIButton{
    
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(50+(self.view.frame.size.width-150)*i , 160 , 50, 50);
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        button.tag = 500 + i;
        [self.view addSubview:button];
    }
    UIButton *registerButton = (UIButton *)[self.view viewWithTag:500];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *loginButton = (UIButton *)[self.view viewWithTag:501];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)registerClick{
    
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)loginClick{
    
    UITextField *nameTextField = (UITextField *)[self.view viewWithTag:100];
    UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:101];
    //点击登录按钮 进行网络请求
    NSString * url = API_USER_LOGIN;
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //附加信息
//    NSDictionary * dict = @{@"account":nameTextField.text,@"password":passwordTextField.text};


    [manager POST:[NSString stringWithFormat:@"%@&account=%@&password=%@",url,nameTextField.text,passwordTextField.text] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary * rootDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

//        NSLog(@"%@",task.response.URL);
        if ([rootDict[@"code"] isEqualToString:@"2000"]) {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:rootDict[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
            [alert show];

            _nickName = nameTextField.text;
            
            [self.delegate passNicName:rootDict[@"nickname"]];
            
            [[NSUserDefaults standardUserDefaults]setObject:rootDict[@"nickname"] forKey:@"nickname"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //跳转页面
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的账号或密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (NSString *)getNickName{

    return _nickName;
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
