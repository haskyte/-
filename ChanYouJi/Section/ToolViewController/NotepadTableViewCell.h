//
//  NotepadTableViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/29.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotepadTableViewCell : UITableViewCell

@property (nonatomic,retain)UILabel * name;
@property (nonatomic,retain)UILabel * nameDetails;
@property (nonatomic,retain)UILabel * money;
@property (nonatomic,retain)UILabel * moneyDetails;
@property (nonatomic,retain)UILabel * xiangqi;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
