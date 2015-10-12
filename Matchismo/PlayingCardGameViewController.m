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

@interface PlayingCardGameViewController () <PlayingCardViewDelegate>

@property (strong, nonatomic) IBOutletCollection(PlayingCardView) NSArray *playingCardViews;


@end

@implementation PlayingCardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.numberOfStartingCards = 35;
    self.maxCardSize = CGSizeMake(80.0, 120.0);
    
    [self startNewGame];
    [self setUpDeck];
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

- (void)setUpDeck //used fopr views TODO: get rid of these placed views
{
    int i =0;
    for (PlayingCardView *playingCardView in self.playingCardViews)
    {
        playingCardView.delegate = self;
        
        Card *card = [self.game cardAtIndex:i]; //[self.deck drawRandomCard];
        if ([card isKindOfClass:[PlayingCard class]])
        {
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            playingCardView.screenLocationIndex = i;
        }
        i++;
        
    }
}


- (void)startNewGame
{
    self.cardViews = nil;
    self.game = [self createGame];
    [self updateUI];
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

- (void)playingCardViewWasTapped:(PlayingCardView *)playingCardView // for placed views (delegate)
{
    NSUInteger cardIndex = playingCardView.screenLocationIndex;
    
//    if (! self.messages)
//    {
//        self.messages = [NSMutableArray new];
//    }
//    
    NSString *returnedMessage = [self.game chooseCardAtIndex:cardIndex];
//    
//    if (returnedMessage)
//    {
//        [self.messages addObject:returnedMessage];
//    }
//    if ([self.messages count] > 0)
//    {
//        self.matchResults.text = [self.messages lastObject];
//    }
//    else
//    {
//        self.matchResults.text = returnedMessage;
//    }
    [self updateUI];
    
    //[playingCardView setBackgroundColor:[UIColor greenColor]];
    
    NSLog(@"%lu", (unsigned long)playingCardView.rank);
    NSLog(@"%@", playingCardView.suit);
}


//- (IBAction)touchCardButton:(UIButton *)sender
//{
//    self.threeCardGame.enabled = NO;
//    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
//    
//    if (! self.messages)
//    {
//        self.messages = [NSMutableArray new];
//    }
//    
//    NSString *returnedMessage = [self.game chooseCardAtIndex:cardIndex];
//    
//    if (returnedMessage)
//    {
//        [self.messages addObject:returnedMessage];
//    }
//    if ([self.messages count] > 0)
//    {
//        self.matchResults.text = [self.messages lastObject];
//    }
//    else
//    {
//        self.matchResults.text = returnedMessage;
//    }
//    [self updateUI];
//    
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


- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"appleCard"];
}



@end
