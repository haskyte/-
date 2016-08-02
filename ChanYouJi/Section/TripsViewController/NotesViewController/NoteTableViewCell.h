//
//  NoteTableViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/22.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteModel.h"
@interface NoteTableViewCell : UITableViewCell

@property (nonatomic, retain)UILabel *descriptionLabel;
@property (nonatomic, retain)UIImageView *photoImage;
@property (nonatomic, retain)NoteModel *noteModel;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;



@end
