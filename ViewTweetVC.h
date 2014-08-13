//
//  ViewTweetVC.h
//  TweetLike
//
//  Created by Katlyn Schwaebe on 8/13/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewTweetVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)backButton:(id)sender;
@property (nonatomic) NSDictionary * tweet;
@end
