//
//  SocialViewController.h
//  SocialMedia
//
//  Created by Terence Bezman on 4/9/14.
//  Copyright (c) 2014 Terence Bezman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidebarViewController.h"

@interface SocialViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSString * currentMediaType;

@property BOOL isTableViewHidden;

@property IBOutlet UITableView *instanceTableView;

-(id) initWithMediaTypes : (NSArray *) mediaTypes from : (SidebarViewController *) controller;

@end
