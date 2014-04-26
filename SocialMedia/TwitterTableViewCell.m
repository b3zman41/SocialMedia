//
//  TwitterTableViewCell.m
//  SocialMedia
//
//  Created by Terence Bezman on 4/18/14.
//  Copyright (c) 2014 Terence Bezman. All rights reserved.
//

#import "TwitterTableViewCell.h"

@implementation TwitterTableViewCell

@synthesize tweet, tweetLabel, username, usernameLabel, profilePicUrl, profilePicImageView;

-(void) setProfilePicImageViewWithURL:(NSString *)imageUrl{

    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    
    [profilePicImageView setImage:image];
    
    [self setSelected:YES];
    [self setSelected:NO];
}

-(void) initializeObject{
    
    self.socialMediaHeight = 100;
    
    [tweetLabel setText:tweet];
    [usernameLabel setText:username];

    [self performSelectorInBackground:@selector(setProfilePicImageViewWithURL:) withObject:profilePicUrl];
}

- (void)awakeFromNib
{
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, 320, 100)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
