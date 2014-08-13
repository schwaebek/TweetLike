//
//  TLATweetCell.h
//  Tweet Like
//
//  Created by Katlyn Schwaebe on 8/11/14.
//  Copyright (c) 2014 Katlyn Schwaebe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFObject;
@protocol TLATweetCellDelegate;
@interface TLATweetCell: UITableViewCell
@property (nonatomic) PFObject* tweet;
@property (weak, nonatomic) IBOutlet UILabel *heartCountLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
- (IBAction)heartClicked:(id)sender;
@property (nonatomic, assign) id <TLATweetCellDelegate> delegate;

@end

@protocol TLATweetCellDelegate <NSObject>
-(void)heartsUpdated;

@end
