//
//  TravelModel.h


#import <Foundation/Foundation.h>

@interface TravelModel : NSObject

@property (nonatomic, copy)NSString *photoImage;
@property (nonatomic, copy)NSString *travelID;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *photosCount;
@property (nonatomic, copy)NSString *startDate;
@property (nonatomic, copy)NSString *days;
// 用户信息
@property (nonatomic, copy)NSString *userID;
@property (nonatomic, copy)NSString *userImage;

+ (instancetype)travelModelWithDic:(NSDictionary *)dic;

@end
