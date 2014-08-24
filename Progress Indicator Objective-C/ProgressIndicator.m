//
//  ProgressIndicator.m
//  Progress Indicator Objective-C
//
//  Created by Dan on 23/08/2014.
//  Copyright (c) 2014 Dan. All rights reserved.
//

#import "ProgressIndicator.h"

IB_DESIGNABLE
@implementation ProgressIndicator

#pragma mark - View lifecycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initDefaults];
    }
    return self;
}

- (void)initDefaults {
    self.steps = 3;
    self.selectedStep = 0;
    self.indicatorSize = 14.0f;
    self.lineWidth = 1.0;
}

#pragma mark - Properties

- (void)setSteps:(NSUInteger)steps {
    _steps = steps;
    [self setNeedsDisplay];
}

- (void)setSelectedStep:(NSInteger)index {
    _selectedStep = index;
    [self setNeedsDisplay];
}

- (void)setIndicatorSize:(float)indicatorSize {
    _indicatorSize = indicatorSize;
    [self setNeedsDisplay];
}

- (void)setLineWidth:(float)lineWidth {
    _lineWidth = lineWidth;
    [self adjustEdgeInsets];
    [self setNeedsDisplay];
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
    [self adjustEdgeInsets];
    [self setNeedsDisplay];
}

- (void)adjustEdgeInsets {
    if (self.edgeInsets.top < self.lineWidth/2)
        _edgeInsets = UIEdgeInsetsMake(self.lineWidth/2, self.edgeInsets.left, self.edgeInsets.bottom, self.edgeInsets.right);
    if (self.edgeInsets.left < self.lineWidth/2)
        _edgeInsets = UIEdgeInsetsMake(self.edgeInsets.top, self.lineWidth/2, self.edgeInsets.bottom, self.edgeInsets.right);
    if (self.edgeInsets.bottom < self.lineWidth/2)
        _edgeInsets = UIEdgeInsetsMake(self.edgeInsets.top, self.edgeInsets.left, self.lineWidth/2, self.edgeInsets.right);
    if (self.edgeInsets.right < self.lineWidth/2)
        _edgeInsets = UIEdgeInsetsMake(self.edgeInsets.top, self.edgeInsets.left, self.edgeInsets.bottom, self.lineWidth/2);
}

#pragma mark - Drawing

- (UIBezierPath *)pathForStepWithIndex:(NSUInteger)step {
    float delta = self.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - self.indicatorSize;
    float offset = (step * (delta/(self.steps - 1)));
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(self.edgeInsets.left + offset, self.edgeInsets.top,
                                                                            self.indicatorSize, self.indicatorSize)];
    return path;
}

- (UIBezierPath *)linePathForStepWithIndex:(NSUInteger)step {
    float delta = (self.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - self.indicatorSize) / (self.steps - 1);
    float offset = step * delta;
    
    UIBezierPath* path = UIBezierPath.bezierPath;
    [path moveToPoint: CGPointMake(self.edgeInsets.left + self.indicatorSize + offset, self.edgeInsets.top + (self.indicatorSize / 2))];
    [path addLineToPoint: CGPointMake(self.edgeInsets.left + offset + delta, self.edgeInsets.top + (self.indicatorSize / 2))];
    
    return path;
}

- (void)drawRect:(CGRect)rect {
    [self.tintColor setStroke];
    
    for (NSUInteger i = 0; i < self.steps - 1; i++) {
        UIBezierPath *linePath = [self linePathForStepWithIndex:i];
        
        linePath.lineWidth = self.lineWidth;
        [linePath stroke];
    }
    
    for (NSUInteger i = 0; i < self.steps; i++) {
        UIBezierPath *path = [self pathForStepWithIndex:i];
        
        (i == self.selectedStep) ?[self.tintColor setFill] :[[UIColor clearColor] setFill];
        [path fill];
        
        path.lineWidth = self.lineWidth;
        [path stroke];
    }
}

@end
