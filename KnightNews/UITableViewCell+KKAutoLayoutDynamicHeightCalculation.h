//
//  UITableViewCell+KKAutoLayoutDynamicHeightCalculation.h
//  KnightNews
//
//  Created by Kyle Kirkland on 10/7/14.
//  Copyright (c) 2014 james van gaasbeck. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UICollectionViewCellAutoLayoutRenderBlock)(void);


@interface UITableViewCell (KKAutoLayoutDynamicHeightCalculation)

/**
 *  Grab an instance of the receiving type to use in order to calculate AutoLayout contraint driven dynamic height. The method pulls the cell from a nib file and moves any Interface Builder defined contrainsts to the content view.
 *
 *  @param name Name of the nib file.
 *
 *  @return collection view cell for using to calculate content based height
 */
+ (instancetype)heightCalculationCellFromNibWithName:(NSString *)name;

/**
 *  Returns the height of the receiver after rendering with your model data and applying an AutoLayout pass
 *
 *  @param block Render the model data to your UI elements in this block
 *
 *  @return Calculated constraint derived height
 */
- (CGFloat)heightAfterAutoLayoutPassAndRenderingWithBlock:(UICollectionViewCellAutoLayoutRenderBlock)block collectionViewWidth:(CGFloat)width;

/**
 *  Directly calls `heightAfterAutoLayoutPassAndRenderingWithBlock:collectionViewWidth` assuming a collection view width spanning the [UIScreen mainScreen] bounds
 */
- (CGFloat)heightAfterAutoLayoutPassAndRenderingWithBlock:(UICollectionViewCellAutoLayoutRenderBlock)block;

@end
