//
//  SidebarTableViewCell.m
//  SocialMedia
//
//  Created by Terence Bezman on 4/9/14.
//  Copyright (c) 2014 Terence Bezman. All rights reserved.
//

#import "SidebarTableViewCell.h"

#define INSTAGRAM @"Instagram"
#define TUMBLR @"Tumblr"
#define REDDIT @"Reddit"
#define TWITTER @"Twitter"
#define FACEBOOK @"Facebook"

@implementation SidebarTableViewCell

@synthesize isDesired, mediaName, isSelected;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

-(void) updateMediaName : (NSString *) name{
    mediaName.text = name;
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:mediaName.text]) {
        [self setEnabled];
    }else [self setDisabled];
}

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkClicked:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults boolForKey:mediaName.text]) {
        
        if ([defaults valueForKey:[NSString stringWithFormat:@"%@Token", mediaName.text]] == nil) {
            
        }
        
        [self setEnabled];
        
    }else{
        
        [self setDisabled];
        
    }
    
}

-(void) setEnabled{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:YES forKey:mediaName.text];
    
    [isSelected setImage:[UIImage imageNamed:@"Check.png"] forState:nil];
    [isSelected setBackgroundImage:nil forState:nil];
    
    [defaults synchronize];
}

-(void) setDisabled{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:NO forKey:mediaName.text];
    
    [isSelected setBackgroundImage:[UIImage imageNamed:@"Check.png"] forState:nil];
    [isSelected setImage:nil forState:nil];
    
    [defaults synchronize];
}

@end
