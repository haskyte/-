//
//  InlandCollectionViewCell.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/24.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ForeignModel;
@interface InlandCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain)UIImageView *image;
@property (nonatomic,retain)UILabel *name_zh_cn;
@property (nonatomic, retain)UILabel *name_en;
@property (nonatomic, retain)UILabel *poi_count;
@property (nonatomic, retain)ForeignModel *foreignModel;
@end
