//
//  NotesTableViewController.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/22.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelModel.h"
@interface NotesTableViewController : UITableViewController

@property (nonatomic, retain) TravelModel *travelModel;
@property (nonatomic, retain) NSString *tripsID;

@end
