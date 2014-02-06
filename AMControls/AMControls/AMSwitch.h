//
//  AMSwitch.h
//  AMControls
//
//  Created by Mohan on 06/02/14.
//  Copyright (c) 2014 Mohan Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AMSwitchDelegate;

@interface AMSwitch : UIView

#pragma mark - Properties

/*!
 returns the switch state
 */
@property (nonatomic, assign, readonly) BOOL isON;

@property (nonatomic,weak) id <AMSwitchDelegate> delegate;

#pragma mark - Methods

/*!
 Change the Thumb button color
 */
-(void) setThumbButtonColor:(UIColor *)color;

/*!
 Chage the Switch background color - it will reflect on ON state
 */
-(void) setSwitchBackgroundColor:(UIColor *)color;

/*!
 set the switch state
 */
-(void) setSwitchON:(BOOL)isON;

/*!
 should change the color of swithc on change of switch state
 */
-(void) enableColorChangeOnToggle:(BOOL)change;

/*!
 show or hode ON and OFF text on Switch
 */
-(void) showOnOFFText:(BOOL)show;

/*!
 Set on and off text Font and Color
 */
-(void) setOnOffTextFont:(UIFont *)font withTextColor:(UIColor *)color;

/*!
 Change the ON and OFF text to required text
 */
-(void) setOnText:(NSString *)onText offText:(NSString *)offText;

@end

#pragma mark - AWSwitchDeleage

@protocol AMSwitchDelegate <NSObject>

@optional

/*!
 Delegate when the switch state is changed
 */
-(void) onSwitch:(AMSwitch *)sender didONOrOFF:(BOOL)isON;

@end
