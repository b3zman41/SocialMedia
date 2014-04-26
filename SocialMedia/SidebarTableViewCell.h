//
//  SidebarTableViewCell.h
//  SocialMedia
//
//  Created by Terence Bezman on 4/9/14.
//  Copyright (c) 2014 Terence Bezman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SidebarTableViewCell : UITableViewCell <UIWebViewDelegate>

@property IBOutlet UILabel* mediaName;
@property IBOutlet UIButton* isSelected;
@property BOOL isDesired;

-(id) initWithName : (NSString *) name;
-(void) updateMediaName : (NSString *) name;

@end
