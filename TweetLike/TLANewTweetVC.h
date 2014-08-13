//
//  TLANewTweetVC.h
//  Tweet Like
//
//  Created by Katlyn Schwaebe on 8/11/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLANewTweetVC : UIViewController

@property (nonatomic) NSMutableArray * tweets;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@property (weak, nonatomic) IBOutlet UIView *greenButton;
@property (weak, nonatomic) IBOutlet UIView *redButton;

@property (weak, nonatomic) IBOutlet UIImageView *saveButton;


@end
