//
//  TwitterTableViewCell.h
//  SocialMedia
//
//  Created by Terence Bezman on 4/18/14.
//  Copyright (c) 2014 Terence Bezman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialMediaTableViewCell.h"

@interface TwitterTableViewCell : SocialMediaTableViewCell

@property NSString *profilePicUrl, *username, *tweet;

@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;

@property (weak, nonatomic) IBOutlet UITextView *tweetLabel;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

-(void) initializeObject;

@end
