//
//  TravelModel.m


#import "TravelModel.h"

@implementation TravelModel



+ (instancetype)travelModelWithDic:(NSDictionary *)dic{
    TravelModel *travelModel = [[[TravelModel alloc] init]autorelease];
    travelModel.travelID = dic[@"id"];
    travelModel.photoImage = dic[@"front_cover_photo_url"];
    travelModel.name = dic[@"name"];
    travelModel.photosCount = dic[@"photos_count"];
    travelModel.startDate = dic[@"start_date"];
    travelModel.days = dic[@"days"];
    travelModel.userID = dic[@"user"][@"id"];
    travelModel.userImage = dic[@"user"][@"image"];
    return travelModel;
}






- (void)dealloc
{
    self.photoImage = nil;
    self.travelID = nil;
    self.name = nil;
    self.photosCount = nil;
    self.startDate = nil;
    self.days = nil;
    self.userID = nil;
    self.userImage = nil;
    [super dealloc];
}
@end
