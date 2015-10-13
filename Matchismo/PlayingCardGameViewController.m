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

//@interface PlayingCardGameViewController //() <PlayingCardViewDelegate>
//
//@property (strong, nonatomic) IBOutletCollection(PlayingCardView) NSArray *playingCardViews;
//
//
//@end

@implementation PlayingCardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.numberOfStartingCards = 35;
    self.maxCardSize = CGSizeMake(80.0, 120.0);
    
    [self startNewGame];
    
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

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}

- (NSUInteger)numberOfMatches
{
    return 2;
}

- (CardMatchingGame *)createGame
{
    return [[PlayingCardGame alloc] initWithCardCount:self.numberOfStartingCards usingDeck:[self createDeck] numberOfMatches:self.numberOfMatches];
}

- (void)touchCard:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        Card *card = [self.game cardAtIndex:gesture.view.tag];
        if (card.chosen)
        {
            [UIView transitionWithView:gesture.view
                              duration:0.5
                               options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                                   card.chosen = !card.chosen;
                                   [self updateView:gesture.view forCard:card];
                               } completion:^(BOOL finished) {
                                   card.chosen = !card.chosen;
                                   [self.game chooseCardAtIndex:gesture.view.tag];
                                   [self updateUI];
                               }];
        }
        else
        {
            [UIView transitionWithView:gesture.view
                              duration:0.5
                               options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                                   card.chosen = !card.chosen;
                                   [self updateView:gesture.view forCard:card];
                               } completion:^(BOOL finished) {
                                   card.chosen = !card.chosen;
                                   [self.game chooseCardAtIndex:gesture.view.tag];
                                   [self updateUI];
                               }];
        }
    }
}



@end
