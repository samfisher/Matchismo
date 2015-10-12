//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Sam Fisher on 9/25/15.
//  Copyright © 2015 Sam Fisher Apps. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCardGame.h"
#import "SetCard.h"
#import "SetCardView.h"



@interface SetGameViewController ()

@end

@implementation SetGameViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.numberOfStartingCards = 16;
    self.maxCardSize = CGSizeMake(120.0, 120.0);
    
    self.deck = [self createDeck];
    [self startNewGame];
}

- (UIView *)createViewForCard:(Card *)card
{
    SetCardView *view = [[SetCardView alloc] init];
    [self updateView:view forCard:card];
    return view;
}

- (void)updateView:(UIView *)view forCard:(Card *)card
{
    if (![card isKindOfClass:[SetCard class]]) return;
    if (![view isKindOfClass:[SetCardView class]]) return;
    
    SetCard *setCard = (SetCard *)card;
    SetCardView *setCardView = (SetCardView *)view;
    setCardView.color = setCard.color;
    setCardView.shape = setCard.shape;
    setCardView.shading = setCard.shading;
    setCardView.number = setCard.number;
    setCardView.chosen = setCard.chosen;
}

- (CardMatchingGame *)createGame
{
    return [[SetCardGame alloc] initWithCardCount:self.numberOfStartingCards usingDeck:[self createDeck] numberOfMatches:self.numberOfMatches];
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (NSUInteger)numberOfMatches
{
    return 3;
}



@end
