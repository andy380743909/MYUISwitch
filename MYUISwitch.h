//
//  MYUISwitch.h
//  
//
//  Created by cui panjun on 12-3-31.
//  Copyright (c) 2012年 . All rights reserved.
//

#define KEY_FOR_TITLE_STATEON   @"titleForStateOn"
#define KEY_FOR_TITLE_STATEOFF  @"titleForStateOff"

#define KEY_FOR_TITLECOLOR_STATEON   @"titleColorForStateOn"
#define KEY_FOR_TITLECOLOR_STATEOFF  @"titleColorForStateOff"

#define KEY_FOR_IMAGE_STATEON   @"imageForStateOn"
#define KEY_FOR_IMAGE_STATEOFF  @"imageForStateOff"

#define KEY_FOR_ANIMATIONIMAGES_STATEON   @"animationImagesForStateOn"
#define KEY_FOR_ANIMATIONIMAGES_STATEOFF  @"animationImagesForStateOff"

//////////////////////////////////////////////////////////////////////////////////

#define ICON_SIZE 30.0f //width and height of icon imageView

#define MYUISWITCH_ANIMATION_DURATION 0.7f

#define DEFAULT_TITLECOLOR_STATEON  [UIColor redColor]
#define DEFAULT_TITLECOLOR_STATEOFF [UIColor blackColor]

#define DEFAULT_BACKGROUNDCOLOR_STATEON [UIColor darkGrayColor]
#define DEFAULT_BACKGROUNDCOLOR_STATEOFF [UIColor darkGrayColor]

#import <UIKit/UIKit.h>

@interface MYUISwitch : UIControl
{
    BOOL switchOn;
    
    CGPoint titleLabelOffset;                //offset of title label
    CGPoint iconImageViewOffset;             //offset of imageview for both state
    CGPoint backgroundImageViewOffset;       //offset of backgroundview
    
    UIImageView *imageView;                 //icon imageview for on state,can be filled with a sequence of images to perform switch on animation
    UIImageView *backgroundImageView;       //background imageview for on state,can be filled with a sequence of images to perform switch on animation
    
    UIImageView *imageViewOff;
    UIImageView *backgroundImageViewOff;
    
    UILabel *titleLabel;
    
    NSMutableDictionary *contentlookup;
    
}

@property (nonatomic,assign) BOOL switchOn;
@property (nonatomic,assign) CGPoint titleLabelOffset;
@property (nonatomic,assign) CGPoint iconImageViewOffset;
@property (nonatomic,assign) CGPoint backgroundImageViewOffset;

@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UIImageView *backgroundImageView;
@property (nonatomic,retain) UIImageView *imageViewOff;
@property (nonatomic,retain) UIImageView *backgroundImageViewOff;

-(void)setTitle:(NSString *)title forStateOn:(BOOL)stateOn; //stateOn ,YES for switch on,NO for switch off

-(void)setTitleColor:(UIColor *)titleColor forStateOn:(BOOL)stateOn;

-(void)setImage:(UIImage *)image forStateOn:(BOOL)stateOn;  //

// this method will automatically set uiimageview's image to last frame of animation images
-(void)setAnimationImages:(NSArray *)images forStateOn:(BOOL)stateOn;

/////////////////////////////////////////////////////////////////////////////

-(void)setSwitchOn:(BOOL)switchOn animated:(BOOL)animated;

@end
