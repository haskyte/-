//
//  NoteModel.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/22.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NoteModel.h"

@implementation NoteModel

- (void)dealloc
{
    self.dayCount = nil;
    self.tripDate = nil;
    self.photoImage = nil;
    self.photoImageHeight = nil;
    self.photoImageWide = nil;
    self.notesDescription = nil;
    [super dealloc];
}

+ (instancetype)noteModelWithDic:(NSDictionary *)dicitonary{
    NoteModel *noteModel = [[[NoteModel alloc] init]autorelease];
    noteModel.dayCount = dicitonary[@"day"];
    noteModel.tripDate = dicitonary[@"trip_date"];
    noteModel.photoImage = dicitonary[@"photo"][@"url"];
    noteModel.photoImageWide = dicitonary[@"photo"][@"image_width"];
    noteModel.photoImageHeight = dicitonary[@"photo"][@"image_height"];
    noteModel.photoID = dicitonary[@"photo"][@"id"];
    noteModel.notesDescription = dicitonary[@"description"];
    return noteModel;
}


@end
