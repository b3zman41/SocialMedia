//
//  InstagramTableViewCell.h
//  SocialMedia
//
//  Created by Terence Bezman on 4/10/14.
//  Copyright (c) 2014 Terence Bezman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialMediaTableViewCell.h"

@interface InstagramTableViewCell : SocialMediaTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userPictureView;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;


@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *timeAgo;

@property NSString *instagramId;
@property NSString *json;
@property NSString *imageUrl;
@property NSString *profileImageUrl;

-(void)initializeObject;

@end
