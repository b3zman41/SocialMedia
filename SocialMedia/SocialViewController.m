//
//  SocialViewController.m
//  SocialMedia
//
//  Created by Terence Bezman on 4/9/14.
//  Copyright (c) 2014 Terence Bezman. All rights reserved.
//

#import "SocialViewController.h"
#import "InstagramTableViewCell.h"
#import "TwitterTableViewCell.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

#define INSTAGRAM @"Instagram"
#define TUMBLR @"Tumblr"
#define REDDIT @"Reddit"
#define TWITTER @"Twitter"
#define FACEBOOK @"Facebook"

@interface SocialViewController ()

@end

@implementation SocialViewController

@synthesize currentMediaType, isTableViewHidden, instanceTableView;

NSMutableArray *mediaDesired;
SidebarViewController *superController;

NSMutableArray* instagramArray;
NSMutableArray* twitterArray;
NSMutableArray* redditArray;
NSMutableArray* tumblrArray;
NSMutableArray* facebookArray;
NSMutableArray* mainArray;

NSString *tempString;

NSMutableDictionary *cellHeights;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithMediaTypes:(NSArray *)mediaTypes from:(SidebarViewController *)controller{
    self = [super init];
    
    mediaDesired = [[NSMutableArray alloc] initWithArray:mediaTypes];
    superController = controller;
    
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
    [swipeLeftRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeftRecognizer];
    
    UISwipeGestureRecognizer *swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight:)];
    [swipeRightGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRightGestureRecognizer];
    
    instagramArray =[[NSMutableArray alloc] init];
    twitterArray = [[NSMutableArray alloc] init];
    mainArray = [[NSMutableArray alloc] init];
    
    [self fillTwitterArray];
    [self fillInstagramArray];
    
    [self fillMainArray];
    
    [instanceTableView reloadData];
    
    isTableViewHidden = NO;
    
    self.view.frame = CGRectMake(310, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView animateWithDuration:.5 animations:^{
        self.view.frame = CGRectMake(150, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) removeMediaTypes : (NSArray *) typesToRemove{
    for (NSString *typeToRemove in typesToRemove) {
        if ([mediaDesired containsObject:typeToRemove]) {
            [mediaDesired removeObject:typeToRemove];
        }
    }
}

-(void) addMediaTypes : (NSArray *) typesToAdd{
    for (NSString * typeToAdd in typesToAdd) {
        if (![mediaDesired containsObject:typeToAdd]) {
            [mediaDesired addObject:typeToAdd];
        }
    }
}

-(void)printMediaTypes{
    for (NSString *type in mediaDesired) {
        NSLog(@"%@", type);
    }
}

- (void)swipedRight:(id)sender {
    
    if (isTableViewHidden) {
        
        isTableViewHidden = NO;
        
        [UIView animateWithDuration:.5 animations:^{
            self.view.frame = CGRectMake(self.view.frame.origin.x + 150, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

- (void)swipedLeft:(id)sender {
    
    if (!isTableViewHidden) {
        
        isTableViewHidden = YES;
        
        [UIView animateWithDuration:.5 animations:^{
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

- (void)tappedView:(id)sender {
    NSLog(@"Tapped View");
}

#pragma mark TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [mainArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[cellHeights valueForKey:[NSString stringWithFormat:@"%lu", indexPath.row]] floatValue];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [mainArray objectAtIndex:indexPath.row];
}

//Inits the Instagram Array
-(void)fillInstagramArray{
    
    NSString *lastId;
    
    if ([instagramArray lastObject] != nil) {
        InstagramTableViewCell *cell = (InstagramTableViewCell *) [instagramArray objectAtIndex:99];
        lastId = cell.instagramId;
    }else lastId = @"";
    
    [instagramArray removeAllObjects];
    
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    
    NSURLRequest *request= [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/feed?count=100&access_token=%@&&MIN_ID=%@", [defualts valueForKey:@"InstagramToken"], lastId]]];
    
    NSURLResponse *urlResponse;
    NSError *error;
    NSData *dataBack;
    
    dataBack = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSArray *jsonArray = [[NSJSONSerialization JSONObjectWithData:dataBack options:NSJSONReadingMutableContainers error:&error] objectForKey:@"data"];
    
    if (error == nil) {
        for (NSDictionary *dict in jsonArray) {
            
            InstagramTableViewCell *cell = [instanceTableView dequeueReusableCellWithIdentifier:@"InstaCell"];
            
            cell.imageUrl = [[[dict objectForKey:@"images"] objectForKey:@"low_resolution"] objectForKey:@"url"];
            
            cell.profileImageUrl = [[dict objectForKey:@"user"] objectForKey:@"profile_picture"];
            
            cell.username.text = [[dict objectForKey:@"user"] objectForKey:@"username"];
            
            
            [cell initializeObject];
            
            [instagramArray addObject:cell];
        }
    }
}

-(void)fillTwitterArray{
    
    [twitterArray removeAllObjects];
    
    NSError *jsonError;
    
    id jsonArray = [NSJSONSerialization JSONObjectWithData:[[self getTwitterFeed] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];
    
    if (jsonError == nil) {
        for (NSDictionary *dict in jsonArray) {
            NSString *username, *userProfilePicUrl, *tweet;
            
            username = [[dict objectForKey:@"user"] objectForKey:@"name"];
            userProfilePicUrl = [[dict objectForKey:@"user"] objectForKey:@"profile_image_url"];
            tweet = [dict objectForKey:@"text"];
            
            TwitterTableViewCell *cell = [instanceTableView dequeueReusableCellWithIdentifier:@"TwitterCell"];
            
            if (cell == nil) {
                cell = [[TwitterTableViewCell alloc] init];
            }
            
            cell.username = username;
            cell.tweet = tweet;
            cell.profilePicUrl = userProfilePicUrl;
            
            [cell initializeObject];
            
            [twitterArray addObject:cell];
        }
        
        [instanceTableView reloadData];
    }else NSLog(@"Twitter Array : %@", [jsonError description]);
}

-(void)fillMainArray{
    
    cellHeights = [[NSMutableDictionary alloc] init];
    
    NSUInteger largestCount = 0;
    
    if ([instagramArray count] > [twitterArray count]) {
        largestCount = [instagramArray count];
    }else largestCount = [twitterArray count];
    
    NSLog(@"%lu", largestCount);
    
    for (int i = 0; i < largestCount; i++) {
        if (i < [instagramArray count]) {
            NSLog(@"Adding Instagram object at index %i", i);
            [mainArray addObject:[instagramArray objectAtIndex:i]];
            
            [cellHeights setValue:@"346" forKey:[NSString stringWithFormat:@"%lu", (unsigned long)[mainArray indexOfObject:[instagramArray objectAtIndex:i]]]];
        }
        
        if (i < [twitterArray count]) {
            NSLog(@"Adding Twitter object at index %i", i);
            [mainArray addObject:[twitterArray objectAtIndex:i]];
            
            [cellHeights setValue:@"100" forKey:[NSString stringWithFormat:@"%lu", [mainArray indexOfObject:[twitterArray objectAtIndex:i]]]];
        }
    }
    
    NSLog(@"Main array count : %lu", [mainArray count]);
    [instanceTableView reloadData];
}

-(NSString *)getTwitterFeed{
    
    NSString *returnString;
    
    [twitterArray removeAllObjects];
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted && error == nil) {
            ACAccount *twitterAccount;
            
            if ([[accountStore accountsWithAccountType:accountType] count] > 0) {
                twitterAccount = [[accountStore accountsWithAccountType:accountType] lastObject];
            }else tempString = @"Error";
            
            NSMutableDictionary *parameters =[[NSMutableDictionary alloc] init];
            
            [parameters setValue:@"100" forKey:@"count"];
            
            SLRequest *twitterRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"] parameters:parameters];
            
            [twitterRequest setAccount:twitterAccount];
            
            [twitterRequest performRequestWithHandler:^(NSData *data, NSHTTPURLResponse *response, NSError *error){
                tempString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }];
            
            
        } else tempString= @"Error";
    }];
    
    int maxTimer = 0;
    
    while (tempString == nil && maxTimer < 3) {
        sleep(3);
    }
    
    if (tempString == nil) {
        tempString = @"Error";
    }
    
    returnString = tempString;
    
    tempString = nil;
    
    return returnString;
}

@end
