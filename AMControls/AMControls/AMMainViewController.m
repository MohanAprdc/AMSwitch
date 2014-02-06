//
//  AMMainViewController.m
//  AMControls
//
//  Created by Mohan on 06/02/14.
//  Copyright (c) 2014 Mohan Rao. All rights reserved.
//

#import "AMMainViewController.h"
#import "AMSwitch.h"

@interface AMMainViewController ()<AMSwitchDelegate>

@end

@implementation AMMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    AMSwitch *amSwitch = [[AMSwitch alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds)-50.0,
                                                                    100.0,
                                                                    100.0, 50.0)];
    [self.view addSubview:amSwitch];
    
    AMSwitch *amSwitchWithBgColor = [[AMSwitch alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds)-50.0,
                                                                               180.0,
                                                                               50.0, 20.0)];
    [amSwitchWithBgColor setSwitchBackgroundColor:[UIColor redColor]];
    [amSwitchWithBgColor setThumbButtonColor:[UIColor grayColor]];
    [self.view addSubview:amSwitchWithBgColor];
    
    AMSwitch *onAndOffSwitch = [[AMSwitch alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds)-50.0,
                                                                    240.0,
                                                                    100.0, 50.0)];
    [onAndOffSwitch showOnOFFText:YES];
    [onAndOffSwitch setOnText:@"AM" offText:@"PM"];
    [onAndOffSwitch setOnOffTextFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]
                       withTextColor:[UIColor redColor]];
    [self.view addSubview:onAndOffSwitch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
