//
//  InstagramTableViewCell.m
//  SocialMedia
//
//  Created by Terence Bezman on 4/10/14.
//  Copyright (c) 2014 Terence Bezman. All rights reserved.
//

#import "InstagramTableViewCell.h"

@implementation InstagramTableViewCell

@synthesize instagramId, json, imageUrl, mainImageView, profileImageUrl, userPictureView, username;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"INIT");
    }
    return self;
}

-(void)initializeObject{
    [self performSelectorInBackground:@selector(setupObject) withObject:nil];
}

-(void) setupObject{
    
    self.socialMediaHeight = 346;
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    UIImage *profImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profileImageUrl]]];

    [mainImageView setImage:image];
    [userPictureView setImage:profImage];
    
    //Just to reload cell so the image actually shows when it finishes downloading.
    [self setSelected:YES];
    [self setSelected:NO];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
