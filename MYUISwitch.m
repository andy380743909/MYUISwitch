//
//  MYUISwitch.h
//  
//
//  Created by cui panjun on 12-3-31.
//  Copyright (c) 2012年 . All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "MYUISwitch.h"


@implementation MYUISwitch

@synthesize titleLabel;
@synthesize imageView;
@synthesize backgroundImageView;
@synthesize imageViewOff;
@synthesize backgroundImageViewOff;


-(id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        contentlookup = [[NSMutableDictionary alloc] init];
        self.backgroundColor = DEFAULT_BACKGROUNDCOLOR_STATEON;
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.animationRepeatCount = 1;
        imageView.animationDuration = MYUISWITCH_ANIMATION_DURATION;
        //imageView.backgroundColor = [UIColor grayColor];
        backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        backgroundImageView.animationRepeatCount = 1;
        
        imageViewOff = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageViewOff.animationRepeatCount = 1;
        imageViewOff.animationDuration = MYUISWITCH_ANIMATION_DURATION;
        //imageView.backgroundColor = [UIColor grayColor];
        backgroundImageViewOff = [[UIImageView alloc] initWithFrame:CGRectZero];
        backgroundImageViewOff.animationRepeatCount = 1;
        
        [self addSubview:titleLabel];
        [self bringSubviewToFront:titleLabel];
        [self addSubview:imageView];
        [self addSubview:imageViewOff];
        [self addSubview:backgroundImageView];
        [self addSubview:backgroundImageViewOff];
        [self sendSubviewToBack:backgroundImageView];
        [self sendSubviewToBack:backgroundImageViewOff];
        
    }
    CALayer *layer = self.layer;
    
    layer.borderWidth = 1.0f;
    layer.borderColor = [[UIColor orangeColor] CGColor];
    
    return self;
}

-(UIColor *)getColorForStateOn:(BOOL)stateOn{
    
    if (stateOn) {
        UIColor *color = [contentlookup objectForKey:KEY_FOR_TITLECOLOR_STATEON];
        if (color) {
            return color;
        }
        return DEFAULT_TITLECOLOR_STATEON; // default theme color,should  be defined as a macro
    }else{
        UIColor *color = [contentlookup objectForKey:KEY_FOR_TITLECOLOR_STATEOFF];
        if (color) {
            return color;
        }
        return DEFAULT_TITLECOLOR_STATEOFF;// default theme color,should  be defined as a macro
    }
    
}


-(void)layoutSubviews{
    CGRect frame = self.frame;
    CGRect rect = CGRectMake((CGRectGetWidth(frame)-60.0f - 30.0f - 10.0f)/2 + 30.0f + 10.0f, (CGRectGetHeight(frame)-22.0f)/2, 60.0f, 22.0f);
    
    rect = CGRectMake(titleLabelOffset.x, titleLabelOffset.y, CGRectGetWidth(frame)-titleLabelOffset.x-10.0f, CGRectGetHeight(frame)-titleLabelOffset.y-10.0f);
    
    titleLabel.frame = rect;
    //titleLabel.center = self.center;  //why this code cause titlelabel display in the error positon?
    //NSLog(@"%f,%f",self.center.x,self.center.y);
    
    rect = CGRectMake(iconImageViewOffset.x, iconImageViewOffset.y, ICON_SIZE, ICON_SIZE);
    
    imageView.frame = rect;
    imageViewOff.frame = rect;
    
    titleLabel.textColor = [self getColorForStateOn:self.switchOn];
    if (self.switchOn) {
        [titleLabel setText:[contentlookup objectForKey:KEY_FOR_TITLE_STATEON]];
        if ([imageViewOff isAnimating]) {
           [imageViewOff stopAnimating];
        }
        imageViewOff.hidden = YES;
        imageView.hidden = NO;
        
        [imageView setImage:[contentlookup objectForKey:KEY_FOR_IMAGE_STATEON]];
        NSArray *animationImagesOn = [contentlookup objectForKey:KEY_FOR_ANIMATIONIMAGES_STATEON];
        if (animationImagesOn) {
            [imageView setAnimationImages:animationImagesOn];
            [imageView startAnimating];
        }
        
        // don't hard code the geometry of it, set it through the iconImageViewOffset
        //imageView.frame = CGRectMake(10.0f, (CGRectGetHeight(frame)-30.0f)/2, 30.0f, 30.0f);
        
    }else{
        [titleLabel setText:[contentlookup objectForKey:KEY_FOR_TITLE_STATEOFF]];
        
        // don't hard code the geometry of it
        //imageViewOff.frame = CGRectMake(10.0f, (CGRectGetHeight(frame)-30.0f)/2, 30.0f, 30.0f);
        
        if ([imageView isAnimating]) {
            [imageView stopAnimating];
        }
        imageView.hidden = YES;
        imageViewOff.hidden = NO;

        [imageViewOff setImage:[contentlookup objectForKey:KEY_FOR_IMAGE_STATEOFF]];
        NSArray *animationImagesOff = [contentlookup objectForKey:KEY_FOR_ANIMATIONIMAGES_STATEOFF];
        
        if (animationImagesOff) {
            [imageViewOff setAnimationImages:animationImagesOff];
            [imageViewOff startAnimating];
        }
            
        
        
    }
    
    
    
    backgroundImageView.frame = self.frame;
    
    [super layoutSubviews];
    
}



#pragma mark - event tracking methods
/*
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{

    return YES;
}
*/
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{

    NSLog(@"move:\t%f,%f",[touch locationInView:self].x ,[touch locationInView:self].y);
    return YES;
}
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
    if ([self pointInside:[touch locationInView:self] withEvent:event]) {
        //switchOn = !switchOn;
        //[self setNeedsLayout];
        [self setSwitchOn:!switchOn animated:NO];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
}
/*
- (void)cancelTrackingWithEvent:(UIEvent *)event{

}
*/

#pragma mark - view setup methods
-(void)setTitle:(NSString *)title forStateOn:(BOOL)stateOn{

    if (stateOn) {
        [contentlookup setValue:title forKey:KEY_FOR_TITLE_STATEON];
    }else{
        [contentlookup setValue:title forKey:KEY_FOR_TITLE_STATEOFF];
    }
    [self setNeedsLayout];
}

-(void)setTitleColor:(UIColor *)titleColor forStateOn:(BOOL)stateOn{

    if (stateOn) {
        [contentlookup setValue:titleColor forKey:KEY_FOR_TITLECOLOR_STATEON];
    }else{
        [contentlookup setValue:titleColor forKey:KEY_FOR_TITLECOLOR_STATEOFF];
    }
    [self setNeedsLayout];
}

-(void)setImage:(UIImage *)image forStateOn:(BOOL)stateOn{

    if (stateOn) {
        [contentlookup setValue:image forKey:KEY_FOR_IMAGE_STATEON];
    }else{
        [contentlookup setValue:image forKey:KEY_FOR_IMAGE_STATEOFF];
    }
    [self setNeedsLayout];
}

-(void)setAnimationImages:(NSArray *)images forStateOn:(BOOL)stateOn{

    if (stateOn) {
        [contentlookup setValue:images forKey:KEY_FOR_ANIMATIONIMAGES_STATEON];
        [contentlookup setValue:[images lastObject] forKey:KEY_FOR_IMAGE_STATEON];
    }else{
        [contentlookup setValue:images forKey:KEY_FOR_ANIMATIONIMAGES_STATEOFF];
        [contentlookup setValue:[images lastObject] forKey:KEY_FOR_IMAGE_STATEOFF];
    }
    [self setNeedsLayout];

}

/////////////////////////////////////////////////////////////////////////////////
#pragma mark - property getter setter methods
-(BOOL)switchOn{
    return switchOn;
}

-(void)setSwitchOn:(BOOL)_switchOn{
    if (switchOn == _switchOn) {
        return;
    }
    switchOn = _switchOn;
    [self setNeedsLayout];
    
}

//
-(void)setSwitchOn:(BOOL)_switchOn animated:(BOOL)animated{
    if (switchOn == _switchOn) {
        return;
    }
    if (animated) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        //[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
    }
    switchOn = _switchOn;
    //self.transform = CGAffineTransformMakeRotation(M_PI_4);
    //CALayer *layer = self.layer;
    //CATransform3D transform = CATransform3DIdentity;
    //if (switchOn) {
    //    transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    //}else{
    //    transform = CATransform3DMakeRotation(0, 0, 1, 0);
    //}
    //transform.m34 = 1.0f/-150.0f;
    //layer.transform = transform;
    
    [self setNeedsLayout];
    if (animated) {
        [UIView commitAnimations];
    }
    
}

-(CGPoint)titleLabelOffset{
    return titleLabelOffset;
}
-(void)setTitleLabelOffset:(CGPoint)offset{

    titleLabelOffset = offset;
    [self setNeedsLayout];
}


-(CGPoint)iconImageViewOffset{
    return iconImageViewOffset;
}

-(void)setIconImageViewOffset:(CGPoint)_iconImageViewOffset{
    iconImageViewOffset = _iconImageViewOffset;
    [self setNeedsLayout];
}

-(CGPoint)backgroundImageViewOffset{
    return backgroundImageViewOffset;
}

-(void)setBackgroundImageViewOffset:(CGPoint)_backgroundImageViewOffset{
    backgroundImageViewOffset = _backgroundImageViewOffset;
    [self setNeedsLayout];
}

#pragma mark - dealloc
-(void)dealloc{

    [contentlookup release];contentlookup = nil;
    
    [imageView release];imageView = nil;
    [backgroundImageView release];backgroundImageView = nil;
    [titleLabel release];titleLabel = nil;
    
    [super dealloc];
    
}

@end
