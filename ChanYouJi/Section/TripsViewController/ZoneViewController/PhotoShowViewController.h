//
//  PhotoShowViewController.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserFavouriteModel.h"
@interface PhotoShowViewController : UIViewController


@property (nonatomic) NSInteger pictureCount;

@property (nonatomic, retain) NSMutableArray *photoArray;
@end
