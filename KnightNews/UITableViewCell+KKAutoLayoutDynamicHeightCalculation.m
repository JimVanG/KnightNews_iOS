//
//  UITableViewCell+KKAutoLayoutDynamicHeightCalculation.m
//  KnightNews
//
//  Created by Kyle Kirkland on 10/7/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import "UITableViewCell+KKAutoLayoutDynamicHeightCalculation.h"

@implementation UITableViewCell (KKAutoLayoutDynamicHeightCalculation)

#pragma mark Dummy Cell Generator

+ (instancetype)heightCalculationCellFromNibWithName:(NSString *)name
{
    UITableViewCell *heightCalculationCell = [[[NSBundle mainBundle] loadNibNamed:@"KKNewsFeaturedTableViewCell" owner:self options:nil] lastObject];
    [heightCalculationCell moveInterfaceBuilderLayoutConstraintsToContentView];
    return heightCalculationCell;
}

#pragma mark Moving Constraints

- (void)moveInterfaceBuilderLayoutConstraintsToContentView
{
    [self.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        [self removeConstraint:constraint];
        id firstItem = constraint.firstItem == self ? self.contentView : constraint.firstItem;
        id secondItem = constraint.secondItem == self ? self.contentView : constraint.secondItem;
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:firstItem
                                                                     attribute:constraint.firstAttribute
                                                                     relatedBy:constraint.relation
                                                                        toItem:secondItem
                                                                     attribute:constraint.secondAttribute
                                                                    multiplier:constraint.multiplier
                                                                      constant:constraint.constant]];
    }];
}

#pragma mark Height

- (CGFloat)heightAfterAutoLayoutPassAndRenderingWithBlock:(UICollectionViewCellAutoLayoutRenderBlock)block
{
    return [self heightAfterAutoLayoutPassAndRenderingWithBlock:block
                                            collectionViewWidth:CGRectGetWidth([[UIScreen mainScreen] bounds])];
}

- (CGFloat)heightAfterAutoLayoutPassAndRenderingWithBlock:(UICollectionViewCellAutoLayoutRenderBlock)block collectionViewWidth:(CGFloat)width
{
    NSParameterAssert(block);
    
    block();
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    self.bounds = CGRectMake(0.0f, 0.0f, width, CGRectGetHeight(self.bounds));
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGSize calculatedSize = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return calculatedSize.height;
    
}

@end
