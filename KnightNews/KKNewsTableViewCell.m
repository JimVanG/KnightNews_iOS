//
//  KKNewsTableViewCell.m
//  KnightNews
//
//  Created by Kyle Kirkland on 9/30/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "KKNewsTableViewCell.h"

@implementation KKNewsTableViewCell

- (void)setFrame:(CGRect)frame
{
    /*frame.origin.x += 10;
    frame.size.width = 300;*/
    [super setFrame:frame];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
