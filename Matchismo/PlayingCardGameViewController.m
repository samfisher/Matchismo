//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Sam Fisher on 9/25/15.
//  Copyright © 2015 Sam Fisher Apps. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardGame.h"
#import "PlayingCardView.h"

@implementation PlayingCardGameViewController

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.numberOfStartingCards = 35;
    self.maxCardSize = CGSizeMake(80.0, 120.0);
    
    [self startNewGame];
    
}

#pragma mark - Start Game
- (CardMatchingGame *)createGame
{
    return [[PlayingCardGame alloc] initWithCardCount:self.numberOfStartingCards usingDeck:[self createDeck] numberOfMatches:self.numberOfMatches];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}

- (UIView *)createViewForCard:(Card *)card
{
    PlayingCardView *view = [[PlayingCardView alloc] init];
    [self updateView:view forCard:card];
    return view;
}


- (void)updateView:(UIView *)view forCard:(Card *)card
{
    if (![card isKindOfClass:[PlayingCard class]]) return;
    if (![view isKindOfClass:[PlayingCardView class]]) return;
    PlayingCard *playingCard = (PlayingCard *)card;
    PlayingCardView *playingCardView = (PlayingCardView *)view;
    playingCardView.rank = playingCard.rank;
    playingCardView.suit = playingCard.suit;
    playingCardView.faceUp = playingCard.chosen;
    
}

#pragma mark - Game Settings
- (NSUInteger)numberOfMatches
{
    return 2;
}




@end
