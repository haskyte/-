//
//  TempViewController.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQMultistageTableView.h"
@interface TempViewController : UIViewController<TQTableViewDataSource, TQTableViewDelegate>

@property (nonatomic, strong) TQMultistageTableView *mTableView;


@end
