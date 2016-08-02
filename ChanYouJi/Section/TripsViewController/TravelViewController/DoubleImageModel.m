//
//  DoubleImageModel.m


#import "DoubleImageModel.h"

@implementation DoubleImageModel

- (void)dealloc
{
    self.position = nil;
    self.image_url = nil;
    self.content = nil;
    [super dealloc];
}

//- (instancetype)doubleImageWithDictionary:(NSDictionary *)dictionary{
//    DoubleImageModel *doubleImageModel = [[DoubleImageModel alloc] init];
//    return doubleImageModel;
//}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
