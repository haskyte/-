//
//  DetailsViewController.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contect;
@interface DetailsViewController : UIViewController

@property (nonatomic,retain)UITextField * nameField;
@property (nonatomic,retain)UITextField * moneyField;
@property (nonatomic,retain)UITextView * textVIEW;
@property(nonatomic,copy)NSString * nameStr;
@property (nonatomic,copy)NSString * moneyStr;
@property (nonatomic,copy)NSString * textStr;
//创建账单对象
@property (nonatomic, retain)Contect *contect;

@end
