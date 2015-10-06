//
//  ViewController.m
//  Matchismo
//
//  Created by Sam Fisher on 9/18/15.
//  Copyright (c) 2015 Sam Fisher Apps. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@property (strong, nonatomic) IBOutlet UISwitch *threeCardGame;

@end

@implementation ViewController

#pragma mark - Lifecycle
// -----------------------------------------------------------------------------

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self updateUI];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[HistoryViewController class]])
    {
        HistoryViewController *hsvc =
        (HistoryViewController*)segue.destinationViewController;
        hsvc.messages = self.messages;
    }
}

- (Deck *)createDeck //abstract
{
    return nil;
}

- (NSUInteger)numberOfMatches
{
    return 3;
}

- (CardMatchingGame *)game
{
    if (! _game)
    {
        _game = [self createGame];
    }
    return _game;
}

- (CardMatchingGame *)createGame
{
    return nil; //abstract
}

- (IBAction)switchMoved:(UISwitch *)sender
{
    [self startNewGame];
}



- (IBAction)touchResetButton:(UIButton *)sender
{
    
    [self startNewGame];
}

- (void)updateUI
{
    //abstract
}


- (void)startNewGame
{
    //abstract
}

- (NSString *)titleForCard:(Card *)card
{
    return nil; //abstract
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return nil; //abstract
}




@end
