//
//  NewsRootViewController.h
//  HealthDrips
//
//  Created by Cedric.
//  Copyright © 2015年 UpTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 区分不同页面的枚举类型
 */
typedef enum : NSInteger{
    Enum_InfoPage = 1000,
    Enum_LorePage,
    Enum_BookPage,
    Enum_DetailPage
    
}RequestType;

@interface NewsRootViewController : UIViewController

@property (nonatomic , assign) RequestType requestType;

//知识类别id
@property (nonatomic , assign) NSInteger loreId;

@property (nonatomic , assign) BOOL isDown;

@property (nonatomic , assign)BOOL isBook;

- (void)downLoadData;

@end
