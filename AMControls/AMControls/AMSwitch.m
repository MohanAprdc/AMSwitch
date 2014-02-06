//
//  AMSwitch.m
//  AMControls
//
//  Created by Mohan on 06/02/14.
//  Copyright (c) 2014 Mohan Rao. All rights reserved.
//

#import "AMSwitch.h"

#define SWITCH_ON 100001
#define SWITCH_OFF 100000

@interface AMSwitch()

@property (nonatomic, strong) UIButton *switchBtn;
@property (nonatomic, assign) BOOL isON;
@property (nonatomic, assign) BOOL isColorChangeOnToggle;

@property (nonatomic, strong) UILabel *onLable;
@property (nonatomic, strong) UILabel *offLable;

@end

@implementation AMSwitch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initUI];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initUI];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) initUI
{
    // set rounded corners
    self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2.0;
    
    // set backgroud view
    [self setBackgroudView];
    
    // set on/off text
    [self setONOFFIndication];
    
    // set Thumb view
    [self setThumbView];
    
    _isColorChangeOnToggle = NO;
}

#pragma mark - UI methods
// background View
-(void) setBackgroudView
{
    self.backgroundColor = [UIColor colorWithWhite:0.757 alpha:1.000];
}

-(void) setThumbView
{
    UIButton *thumbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thumbButton.frame = CGRectMake(CGRectGetMinX(self.bounds)+1.0, CGRectGetMinY(self.bounds)+1.0,
                                   CGRectGetHeight(self.bounds)-2.0, CGRectGetHeight(self.bounds)-2.0);
    thumbButton.layer.cornerRadius = CGRectGetHeight(thumbButton.bounds)/2.0;
    [thumbButton setBackgroundColor:[UIColor whiteColor]];
    thumbButton.tag = SWITCH_OFF;
    _isON = NO;
    [thumbButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:thumbButton];
    
    // add swipe gesture
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(switchSwipe:)];
    [thumbButton addGestureRecognizer:swipeGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(switchSwipe:)];
    [thumbButton addGestureRecognizer:panGesture];
    
    _switchBtn = thumbButton;
}

-(void) setONOFFIndication
{
    // show ON/OFF text
    UILabel *onLbl = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, CGRectGetWidth(self.bounds)-20.0, CGRectGetHeight(self.bounds))];
    onLbl.text = @"ON";
    onLbl.hidden = YES;
    [onLbl setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:8.0f]];
    onLbl.backgroundColor = [UIColor clearColor];
    [self addSubview:onLbl];
    
    _onLable = onLbl;
    
    UILabel *offLbl = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, CGRectGetWidth(self.bounds)-20.0, CGRectGetHeight(self.bounds))];
    offLbl.text = @"OFF";
    offLbl.textAlignment = NSTextAlignmentRight;
    offLbl.hidden = YES;
    [offLbl setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:8.0f]];
    offLbl.backgroundColor = [UIColor clearColor];
    [self addSubview:offLbl];
    
    _offLable = offLbl;
}

-(void) setThumbButtonColor:(UIColor *)color
{
    [_switchBtn setBackgroundColor:color];
}

-(void) setSwitchBackgroundColor:(UIColor *)color
{
    self.backgroundColor = color;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self switchAction:nil];
}

#pragma mark - public method
-(void) setSwitchON:(BOOL)isON
{
    typeof(self) __weak weakSelf = self;
    
    if (isON)
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            weakSelf.switchBtn.frame = CGRectMake(CGRectGetMaxX(self.bounds)-CGRectGetWidth(_switchBtn.bounds)-1.0, CGRectGetMinY(self.bounds)+1.0,
                                                  _switchBtn.frame.size.width, _switchBtn.frame.size.height);
            
        } completion:^(BOOL finished) {
            weakSelf.switchBtn.tag = SWITCH_ON;
            weakSelf.isON = YES;
            if (weakSelf.isColorChangeOnToggle)
            {
                weakSelf.backgroundColor = [UIColor colorWithRed:0.000 green:0.573 blue:0.898 alpha:1.000];
            }
        }];
    }
    else
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            _switchBtn.frame = CGRectMake(CGRectGetMinX(self.bounds)+1.0, CGRectGetMinY(self.bounds)+1.0,
                                          _switchBtn.frame.size.width, _switchBtn.frame.size.height);
            
        } completion:^(BOOL finished) {
            _switchBtn.tag = SWITCH_OFF;
            weakSelf.isON = NO;
        }];
    }
}

-(void) showOnOFFText:(BOOL)show
{
    [_onLable setHidden:!show];
    [_offLable setHidden:!show];
}

-(void) setOnOffTextFont:(UIFont *)font withTextColor:(UIColor *)color
{
    [_onLable setFont:font];
    [_offLable setFont:font];
    
    _onLable.textColor = color;
    _offLable.textColor = color;
}

-(void) setOnText:(NSString *)onText offText:(NSString *)offText
{
    _onLable.text = onText;
    _offLable.text = offText;
}

-(void) enableColorChangeOnToggle:(BOOL)change
{
    _isColorChangeOnToggle = change;
}

#pragma mark - switch utility methods
-(void) onSwitch
{
    typeof(self) __weak weakSelf = self;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        _switchBtn.frame = CGRectMake(CGRectGetMaxX(self.bounds)-CGRectGetWidth(_switchBtn.bounds)-1.0, CGRectGetMinY(self.bounds)+1.0,
                                      _switchBtn.frame.size.width, _switchBtn.frame.size.height);
        
    } completion:^(BOOL finished) {
        _switchBtn.tag = SWITCH_ON;
        weakSelf.isON = YES;
        
        if (_isColorChangeOnToggle)
        {
            self.backgroundColor = [UIColor colorWithRed:83.0/255.0 green:189.0/255.0 blue:27.0/255.0 alpha:1.000];
        }
        
        if ([weakSelf.delegate respondsToSelector:@selector(onSwitch:didONOrOFF:)])
        {
            [self.delegate onSwitch:self didONOrOFF:YES];
        }
    }];
}

-(void) offSwitch
{
    typeof(self) __weak weakSelf = self;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        _switchBtn.frame = CGRectMake(CGRectGetMinX(self.bounds)+1.0, CGRectGetMinY(self.bounds)+1.0,
                                      _switchBtn.frame.size.width, _switchBtn.frame.size.height);
        
    } completion:^(BOOL finished) {
        _switchBtn.tag = SWITCH_OFF;
        weakSelf.isON = NO;
        
        if (_isColorChangeOnToggle)
        {
            weakSelf.backgroundColor = [UIColor colorWithWhite:0.757 alpha:1.000];
        }
        
        if ([weakSelf.delegate respondsToSelector:@selector(onSwitch:didONOrOFF:)])
        {
            [self.delegate onSwitch:self didONOrOFF:NO];
        }
    }];
}

#pragma mark - action
-(void) switchAction:(id)sender
{
    if (_switchBtn.tag == SWITCH_ON)
    {
        [self offSwitch];
    }
    else
    {
        [self onSwitch];
    }
}

#pragma mark - gesture delegate
-(void) switchSwipe:(UIGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:self];
    if (location.x < CGRectGetWidth(self.bounds)-CGRectGetWidth(_switchBtn.bounds)/2.0 - 1.0&&
        location.x > CGRectGetWidth(_switchBtn.bounds)/2.0 +1.0)
    {
        _switchBtn.center = CGPointMake(location.x, _switchBtn.center.y);
    };
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        if (location.x < CGRectGetMidX(self.bounds))
        {
            [self offSwitch];
        }
        else
        {
            [self onSwitch];
        }
    }
}


@end
