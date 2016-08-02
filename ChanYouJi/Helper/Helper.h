//
//  Helper.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/20.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Helper : NSObject

@property (nonatomic, retain) UINavigationController *tripsNavigaitionController;
@property (nonatomic, retain) UIViewController *viewController;
@property (nonatomic, retain) UINavigationController *detailNavigaitonController;
@property (nonatomic, retain) UINavigationController *searchNavigationController;




+ (instancetype)shareWithHelper;

- (void)getNavigaitonController:(UINavigationController *)navigation;

- (void)getViewController:(UIViewController *)viewController;

- (void)getDetailNavigaitonController:(UINavigationController *)navigation;

- (void)getSearchNavigationController:(UINavigationController *)navigation;

@end
