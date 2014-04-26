//
//  SidebarViewController.m
//  SocialMedia
//
//  Created by Terence Bezman on 4/9/14.
//  Copyright (c) 2014 Terence Bezman. All rights reserved.
//

#import "SidebarViewController.h"
#import "SocialViewController.h"
#import "SidebarTableViewCell.h"
#import "STTwitter.h"
#import "InstagramTableViewCell.h"

#define INSTAGRAM @"Instagram"
#define TUMBLR @"Tumblr"
#define REDDIT @"Reddit"
#define TWITTER @"Twitter"
#define FACEBOOK @"Facebook"

@interface SidebarViewController ()

@end

@implementation SidebarViewController

@synthesize instanceTableView;

NSArray *cells;

SocialViewController *mainSocialViewController;
STTwitterAPI *twitterObj;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    cells = [[NSArray alloc] initWithObjects:INSTAGRAM, FACEBOOK, TWITTER, TUMBLR, REDDIT, nil];
    
    instanceTableView.delegate = self;
    instanceTableView.dataSource = self;
    
    mainSocialViewController  = [[UIStoryboard storyboardWithName:@"SocialViewController" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SocialViewController"];
    
    [self.view addSubview:mainSocialViewController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [cells count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SidebarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[SidebarTableViewCell alloc] init];
    }
    
    [cell updateMediaName:[cells objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SidebarTableViewCell *cell = (SidebarTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    
    NSString *requestURL;
    
    if ([[cells objectAtIndex:indexPath.row] isEqual: INSTAGRAM]) {
        if ([defualts valueForKey:[NSString stringWithFormat:@"%@Token", cell.mediaName.text] ] == nil) {
            NSLog(@"In instagram");
            requestURL = @"https://api.instagram.com/oauth/authorize/?client_id=31b3fcce5bfb465f95da13ed956be9e7&redirect_uri=https://www.google.com&response_type=token";
            
            [self loadWebViewWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]]];
        }else NSLog(@"InstagramToken = %@", [defualts valueForKey:[NSString stringWithFormat:@"%@Token", cell.mediaName.text]]);
    }else if([[cells objectAtIndex:indexPath.row] isEqual:TWITTER]){
        
    }else if([[cells objectAtIndex:indexPath.row] isEqual:TUMBLR]){
        
    }
}

#pragma mark Webview Delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *fullURL = [[request URL] absoluteString];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    if ([fullURL rangeOfString:@"#access_token"].location != NSNotFound) {
        NSLog(@"%@",[[fullURL componentsSeparatedByString:@"="] objectAtIndex:1]);
        [defaults setValue:[[fullURL componentsSeparatedByString:@"="] objectAtIndex:1] forKey:@"InstagramToken"];
        [webView removeFromSuperview];
    }
    
    [defaults synchronize];
    
    return YES;
}

#pragma mark SocialMediaLogins

-(void) loadWebViewWithRequest : (NSURLRequest *) request{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 20)];
    
    webView.delegate = self;
    
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
}

@end
