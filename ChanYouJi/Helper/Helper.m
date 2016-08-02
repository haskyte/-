//
//  Helper.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/20.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "Helper.h"
#import "TripsViewController.h"
@implementation Helper



+ (instancetype)shareWithHelper{
    static Helper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[Helper alloc] init];
    });
    return helper;
}

- (void)getNavigaitonController:(UINavigationController *)navigation{
    self.tripsNavigaitionController = navigation;
}

- (void)getViewController:(UIViewController *)viewController{
    self.viewController = viewController;
}

- (void)getDetailNavigaitonController:(UINavigationController *)navigation{
    self.detailNavigaitonController = navigation;
}

- (void)getSearchNavigationController:(UINavigationController *)navigation{
    self.searchNavigationController = navigation;
}



@end
