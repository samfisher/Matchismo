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
    
    self.numberOfStartingCards = 12;
    self.maxCardSize = CGSizeMake(120.0, 120.0);
    
    self.deck = [self createDeck];
    [self updateUI];
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
    setCardView.symbol = setCard.shape;
    setCardView.shading = setCard.shading;
    setCardView.number = setCard.number;
    setCardView.chosen = setCard.chosen;
}

- (void)startNewGame
{
    self.cardViews = nil;
    self.game = [self createGame];
    [self updateUI];
}

- (CardMatchingGame *)createGame
{
    return [[SetCardGame alloc] initWithCardCount:self.numberOfStartingCards usingDeck:[self createDeck] numberOfMatches:self.numberOfMatches];
}

//- (IBAction)touchCardButton:(UIButton *)sender
//{
//    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
//    
//    id returnedMessage = [self.game chooseCardAtIndex:cardIndex];
//    
//    
//    if (![returnedMessage isKindOfClass:[NSAttributedString class]])
//    {
//        return;
//    }
//    
//    [self.matchResults setAttributedText:returnedMessage];
//    
//    if( ((NSAttributedString *)returnedMessage).length > 0)
//    {
//        [self.messages addObject:returnedMessage];
//    }
//    
//    [self updateUI];
//}

#define CARDSPACINGINPERCENT 0.08
- (void)updateUI
{
    for (NSUInteger cardIndex = 0;
         cardIndex < self.game.numberOfDealtCards;
         cardIndex++) {
        Card *card = [self.game cardAtIndex:cardIndex];
        NSUInteger viewIndex = [self.cardViews indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIView class]]) {
                if (((UIView *)obj).tag == cardIndex) return YES;
            }
            return NO;
        }];
        UIView *cardView;
        if (viewIndex == NSNotFound) {
            cardView = [self createViewForCard:card];
            cardView.tag = cardIndex;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(touchCard:)];
            [cardView addGestureRecognizer:tap];
            [self.cardViews addObject:cardView];
            viewIndex = [self.cardViews indexOfObject:cardView];
            [self.gridView addSubview:cardView];
        } else {
            cardView = self.cardViews[viewIndex];
            [self updateView:cardView forCard:card];
            cardView.alpha = card.matched ? 0.6 : 1.0;
        }
        CGRect frame = [self.grid frameOfCellAtRow:viewIndex / self.grid.columnCount
                                          inColumn:viewIndex % self.grid.columnCount];
        frame = CGRectInset(frame, frame.size.width * CARDSPACINGINPERCENT, frame.size.height * CARDSPACINGINPERCENT);
        cardView.frame = frame;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}


- (void)touchCard:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self.game chooseCardAtIndex:gesture.view.tag];
        [self updateUI];
    }
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:@"cardfront"];
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
