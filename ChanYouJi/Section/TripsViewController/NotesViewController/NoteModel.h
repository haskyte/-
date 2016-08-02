//
//  NoteModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/22.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteModel : NSObject
// 分区区头
@property (nonatomic, copy) NSString *dayCount; //第几天
@property (nonatomic, copy) NSString *tripDate; //日期


// 图片加文字cell
@property (nonatomic, copy) NSString *photoImage;    // 图片的url
@property (nonatomic, copy) NSString *photoImageWide;  // 图片的宽
@property (nonatomic, copy) NSString *photoImageHeight;  //图片的高
@property (nonatomic, copy) NSString *notesDescription;  // 文字
@property (nonatomic, copy) NSString *photoID;
//
+ (instancetype)noteModelWithDic:(NSDictionary *)dicitonary;


@end
