//
//  NoteTableViewCell.m
//  ChanYouJi
//
//  Created by lanouhn on 15/6/22.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "NoteTableViewCell.h"
#import "UIImageView+WebCache.h"

#define SCREENWIDE [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@implementation NoteTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UILabel *)descriptionLabel{
    if (_descriptionLabel == nil) {
        self.descriptionLabel = [[[UILabel alloc]initWithFrame:CGRectMake(10, 250, SCREENWIDE - 20, 30)]autorelease];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descriptionLabel.font = [UIFont systemFontOfSize:12];
    }
    return _descriptionLabel;
}

- (UIImageView *)photoImage{
    if (_photoImage == nil) {
        self.photoImage = [[[UIImageView alloc]init]autorelease];
        _photoImage.backgroundColor = [UIColor yellowColor];
    }
    return _photoImage;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [self.contentView addSubview:self.photoImage];
        [self.contentView addSubview:self.descriptionLabel];
    }
    return self;
}




-(void)setNoteModel:(NoteModel *)noteModel{
    if (_noteModel != noteModel) {
        [_noteModel release];
        _noteModel = [noteModel retain];
    }
    
    self.descriptionLabel.text = [NSString stringWithFormat:@"%@", noteModel.notesDescription];

    NSURL *url = [NSURL URLWithString:noteModel.photoImage];
    [self.photoImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];

    CGFloat photoHeight = [noteModel.photoImageHeight floatValue];
    CGFloat photoWidth = [noteModel.photoImageWide floatValue];
    if (photoWidth == 0 && photoHeight == 0 ) {
        self.photoImage.frame = CGRectMake(0, 0, 0, 0);
        if ([self.descriptionLabel.text isEqualToString:@"<null>"]) {
            self.descriptionLabel.frame = CGRectMake(0, 0, 0, 0);
        }else{
            CGRect rect = [self.descriptionLabel.text boundingRectWithSize:CGSizeMake(375, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
            self.descriptionLabel.frame = CGRectMake(10, 10, SCREENWIDE - 20, rect.size.height);
        }
        
    }else{
        self.photoImage.frame = CGRectMake(10, 10, SCREENWIDE - 20, photoHeight * (SCREENWIDE - 20) / photoWidth) ;
        if ([self.descriptionLabel.text isEqualToString:@"<null>"]) {
            self.descriptionLabel.frame = CGRectMake(0, 0, 0, 0);
        }else{
            CGRect rect = [self.descriptionLabel.text boundingRectWithSize:CGSizeMake(375, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
            self.descriptionLabel.frame = CGRectMake(10, 10 + photoHeight * (SCREENWIDE - 20) / photoWidth, SCREENWIDE - 20, rect.size.height);
        }
    }


}
- (void)dealloc
{
    self.photoImage = nil;
    self.descriptionLabel = nil;
    self.noteModel = nil;
    [super dealloc];
}

@end
