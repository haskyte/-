//
//  DetailTableViewController.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/23.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopicModel;
@interface DetailTableViewController : UITableViewController

@property (nonatomic , retain) TopicModel *topicModel;
@property (nonatomic, retain) NSString *topicID;

@end
