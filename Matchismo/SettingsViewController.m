//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Sam Fisher on 9/30/15.
//  Copyright © 2015 Sam Fisher Apps. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (strong, nonatomic) IBOutlet UISwitch *matchBonusSwitch;
@property (strong, nonatomic) IBOutlet UIStepper *matchBonusStepper;
@property (strong, nonatomic) IBOutlet UILabel *matchBonusLabel;

@property (strong, nonatomic) IBOutlet UISwitch *tripleBonusSwitch;
@property (strong, nonatomic) IBOutlet UIStepper *tripleBonusStepper;
@property (strong, nonatomic) IBOutlet UILabel *tripleBonusLabel;

@property (strong, nonatomic) IBOutlet UISwitch *mismatchSwitch;
@property (strong, nonatomic) IBOutlet UIStepper *mismatchStepper;
@property (strong, nonatomic) IBOutlet UILabel *mismatchLabel;

@property (strong, nonatomic) IBOutlet UISwitch *costToChooseSwitch;
@property (strong, nonatomic) IBOutlet UIStepper *costToChooseStepper;
@property (strong, nonatomic) IBOutlet UILabel *costToChooseLabel;

@end

@implementation SettingsViewController

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    self.tripleBonusStepper.value = [prefs integerForKey:@"tripleBonus"];
    self.matchBonusStepper.value = [prefs integerForKey:@"matchBonus"];
    self.mismatchStepper.value = [prefs integerForKey:@"mismatch"];
    self.costToChooseStepper.value = [prefs integerForKey:@"costToChoose"];
    
    self.matchBonusLabel.text = [NSString stringWithFormat:@"%g", roundf(self.matchBonusStepper.value)];
    self.tripleBonusLabel.text = [NSString stringWithFormat:@"%g", roundf(self.tripleBonusStepper.value)];
    self.mismatchLabel.text = [NSString stringWithFormat:@"%g", roundf(self.mismatchStepper.value)];
    self.costToChooseLabel.text = [NSString stringWithFormat:@"%g", roundf(self.costToChooseStepper.value)];
    
}

#pragma mark - Switches
- (IBAction)matchBonusSwitchChanged:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if (roundf(self.matchBonusStepper.value) == 0)
    {
        [prefs setInteger:1 forKey:@"matchBonus"];
    }
    
    if (self.matchBonusSwitch.isOn)
    {
        self.matchBonusStepper.enabled = YES;
        self.matchBonusLabel.enabled = YES;
        [prefs setInteger:roundf(self.matchBonusStepper.value) forKey:@"matchBonus"];
    }
    else
    {
        self.matchBonusStepper.enabled = NO;
        self.matchBonusLabel.enabled = NO;
        [prefs setInteger:1 forKey:@"matchBonus"];
    }
}

- (IBAction)tripleBonusSwitchChanged:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if (self.tripleBonusSwitch.isOn)
    {
        self.tripleBonusStepper.enabled = YES;
        self.tripleBonusLabel.enabled = YES;
        [prefs setInteger:roundf(self.tripleBonusStepper.value) forKey:@"tripleBonus"];
    }
    else
    {
        self.tripleBonusStepper.enabled = NO;
        self.tripleBonusLabel.enabled = NO;
        [prefs setInteger:0 forKey:@"tripleBonus"];
    }
}

- (IBAction)mismatchSwitchChanged:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if (self.mismatchSwitch.isOn)
    {
        self.mismatchStepper.enabled = YES;
        self.mismatchLabel.enabled = YES;
        [prefs setInteger:roundf(self.mismatchStepper.value) forKey:@"mismatch"];
    }
    else
    {
        self.mismatchStepper.enabled = NO;
        self.mismatchLabel.enabled = NO;
        [prefs setInteger:0 forKey:@"mismatch"];
    }
}

- (IBAction)costToChooseSwitchChanged:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if (self.costToChooseSwitch.isOn)
    {
        self.costToChooseStepper.enabled = YES;
        self.costToChooseLabel.enabled = YES;
        [prefs setInteger:roundf(self.costToChooseStepper.value) forKey:@"costToChoose"];
    }
    else
    {
        self.costToChooseStepper.enabled = NO;
        self.costToChooseLabel.enabled = NO;
        [prefs setInteger:0 forKey:@"costToChoose"];
    }
}

#pragma mark - Steppers
- (IBAction)MatchBonusStepperChanged:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if (roundf(self.matchBonusStepper.value) == 0)
    {
        [prefs setInteger:1 forKey:@"matchBonus"];
    }
    
    self.matchBonusLabel.text = [NSString stringWithFormat:@"%g", roundf(self.matchBonusStepper.value)];
    [prefs setInteger:roundf(self.matchBonusStepper.value) forKey:@"matchBonus"];
}

- (IBAction)tripleBonusStepper:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    self.tripleBonusLabel.text = [NSString stringWithFormat:@"%g", roundf(self.tripleBonusStepper.value)];
    [prefs setInteger:roundf(self.tripleBonusStepper.value) forKey:@"tripleBonus"];
    
}

- (IBAction)mismatchStepperChanged:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    self.mismatchLabel.text = [NSString stringWithFormat:@"%g", roundf(self.mismatchStepper.value)];
    [prefs setInteger:roundf(self.mismatchStepper.value) forKey:@"mismatch"];
}


- (IBAction)costToChooseStepperChanged:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    self.costToChooseLabel.text = [NSString stringWithFormat:@"%g", roundf(self.costToChooseStepper.value)];
    [prefs setInteger:roundf(self.costToChooseStepper.value) forKey:@"costToChoose"];
}



@end
