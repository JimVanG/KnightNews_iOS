//
//  KKNewsFeaturedTableViewCell.h
//  KnightNews
//
//  Created by Kyle Kirkland on 9/30/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKNewsFeaturedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *articleAuthorLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *articlePreviewTextView;
@end
