//
//  TLATweetCell.h
//  Tweet Like
//
//  Created by Katlyn Schwaebe on 8/11/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLATweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *heartCountLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (nonatomic) NSDictionary* tweet;
- (IBAction)heartClicked:(id)sender;

@end
