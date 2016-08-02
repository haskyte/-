//
//  UserFavouriteModel.h
//  ChanYouJi
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserFavouriteModel : NSObject

@property (nonatomic ,copy) NSString *photoID;
@property (nonatomic, copy) NSString *photoDescription;
@property (nonatomic, copy) NSString *photoWidth;
@property (nonatomic, copy) NSString *photoHeight;
@property (nonatomic, copy) NSString *photoUrl;

+ (instancetype)favouriteModelWithDictionary:(NSDictionary *)dictionary;

@end
