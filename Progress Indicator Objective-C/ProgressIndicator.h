//
//  ProgressIndicator.h
//  Progress Indicator Objective-C
//
//  Created by Dan on 23/08/2014.
//  Copyright (c) 2014 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *   An indicator control used to show progress through a multi-step process, e.g. a sign-up process.
 *   Draws in the control's tintColor.
 *
 *   If any of the edgeInsets are set below lineWidth/2, they are reset to lineWidth/2 to avoid clipping.
 */
IB_DESIGNABLE
@interface ProgressIndicator : UIControl

/**
 *  The number of steps in the sequence of pages, default is 3.
 */
@property (nonatomic) NSUInteger steps;

/**
 *  The index number identifying the current step, default is 0 (the first step).
 *  Set this property to -1 to turn off the current selection.
 */
@property (nonatomic) NSInteger selectedStep;

/**
 *  The size of the circular step indicators, default is 14.0f;
 */
@property (nonatomic) float indicatorSize;

/**
 *  The line width used to draw the control, default is 1.
 */
@property (nonatomic) float lineWidth;

/**
 *  edgeInsets for the control, default is lineWidth/2.
 */
@property (nonatomic) UIEdgeInsets edgeInsets;

@end
