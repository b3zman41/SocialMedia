//
//  SidebarViewController.h
//  SocialMedia
//
//  Created by Terence Bezman on 4/9/14.
//  Copyright (c) 2014 Terence Bezman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SidebarViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

@property IBOutlet UITableView *instanceTableView;

@end
