//
//  TLATweetsTVC.m
//  Tweet Like
//
//  Created by Katlyn Schwaebe on 8/11/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//
//- add hearts to the list
//- finish list look with blue separator
//- finish new tweet look (red & green circles, swipe button)
//- make swipe work... if button is released on green - save tweet... if button is released over red - dismiss new tweet... if button released any where else snap back to start position
//- add launch images (3.5 screen coming soon)
//- icon images coming soon
//- create new VC subclass for viewTweetVC
//- pass NSDictionary * tweet into viewTweetVC (during prepareForSegue)
#import "TLATweetsTVC.h"
#import "TLATweetCell.h"
#import "TLANewTweetVC.h"
#import "AFNetworking.h"
#import "TLAAppDelegate.h"
#import <Parse/Parse.h>

@interface TLATweetsTVC ()

@end

@implementation TLATweetsTVC
{
    NSMutableArray * tweets;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        tweets = [@[] mutableCopy];
        
        // Custom initialization
        
        //After Twitter JSON is requested, query Parse where key @"id" isEqualTo: tweet [@"id"] (request manager) (refer to PFQuery thing)
        //if query returns no result... save Tweet PFObject based on tweet (refer to comment out thing)
        // if query returns result... do nothing
        // After looping through Twitter JSON objects, query Parse for Tweet objects and fill tableView with the result
        // When clicking on a heart update the cell, also find the Tweet object that matvhes its @"id" and update the @"hearts" value
        
        
        
        //    PFObject * tweet = [PFObject objectWithClassName:@"Tweet"];
        //    [tweet setObject:@4748569254326 forKey:@"id"];
        //    [tweet setObject:@"This is Katlyn's tweet" forKey:@"text"];
        //    [tweet setObject:@13 forKey:@"hearts"];
        //    [tweet saveInBackground];
        [Parse setApplicationId:@"L1IPX1pFO1iLCRbZ3Hu4o7LCwlkpktqFTKI1zzRt"
                      clientKey:@"Jjgc6YFyzuo734oav544IZKAPawTozNtNU12N6Wg"];
        
       
        //    query.limit = 2;
        //[query whereKey:@"hearts" equalTo:@99];
       
        
        AFHTTPRequestOperationManager *requestManager = [[AFHTTPRequestOperationManager alloc] init];
        [requestManager GET:@"http://jo2.co/twitter.json" parameters:nil
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        
                        for (NSDictionary* tweet in responseObject)
                        {
                             PFQuery * query = [PFQuery queryWithClassName:@"Tweet"];
                            
                            [query whereKey:@"id" equalTo:tweet[@"id"]];
                            
                            [query findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError * error) {
                                
                                
                                if (objects.count ==0) {
                                    PFObject * tweet = [PFObject objectWithClassName:@"tweet"];
                                    [tweet setObject:tweet[@"id"] forKey:@"id"];
                                    [tweet setObject:tweet[@"text"] forKey:@"text"];
                                    [tweet setObject:tweet[@"hearts"] forKey:@"hearts"];
                                    
                                    [tweet saveInBackground];
                                }
                                
                            }];
                            
                        }
                            

                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                    }];
        
    PFQuery * queryForAllParseObjects = [PFQuery queryWithClassName:@"tweet"];
    [queryForAllParseObjects findObjectsInBackgroundWithBlock:^(NSArray * objects, NSError *error) {
                            
                for (NSDictionary * tweet in objects)
                    {
                            [tweets addObject:[@{
                                                     
                                     @"id": tweet[@"id"],
                                     @"text": tweet [@"text"],
                                     @"hearts": @0,
                                     
                                     
                                     } mutableCopy]];
            }
            [self.tableView reloadData];
        }];
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView * logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_logo"]];
    logo.frame = CGRectMake(0, 0, 121, 24);
    logo.center = self.navigationController.navigationBar.center;
    [self.navigationController.navigationBar addSubview:logo];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLATweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary * tweet = tweets[indexPath.row];
    
    cell.heartCountLabel.text =
        (tweet[@"hearts"]) ? [NSString stringWithFormat:@"%@",tweet[@"hearts"]] : @"0";
    
    cell.tweetTextView.text = tweet[@"text"];
    cell.tweet = tweet;
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showNewTweetVC"])
    {
        TLANewTweetVC * newTweetVC = segue.destinationViewController;
        
        newTweetVC.tweets = tweets;
    }
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}





@end
