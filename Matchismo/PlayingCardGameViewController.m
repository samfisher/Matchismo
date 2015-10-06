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

@interface PlayingCardGameViewController ()

@property (strong, nonatomic) IBOutlet UISwitch *threeCardGame;
@property (strong, nonatomic) IBOutletCollection(PlayingCardView) NSArray *playingCardViews;

@end

@implementation PlayingCardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //test
}

- (void)startNewGame
{
    self.messages = [NSMutableArray new];
    if (self.threeCardGame.on)
    {
        self.game = [[CardMatchingGame alloc] initWithCardCount:[self.playingCardViews count] usingDeck:[self createDeck] numberOfMatches:3];
    }
    else
        self.game = [[CardMatchingGame alloc] initWithCardCount:[self.playingCardViews count] usingDeck:[self createDeck] numberOfMatches:2];
    
    self.matchResults.text = @"Good Luck!";
    self.threeCardGame.enabled = YES;
    
    [self updateUI];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}

- (NSUInteger)numberOfMatches
{
    return self.threeCardGame.on ? 3 : 2;
}

- (CardMatchingGame *)createGame
{
    return [[PlayingCardGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] numberOfMatches:self.numberOfMatches];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.threeCardGame.enabled = NO;
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    
    if (! self.messages)
    {
        self.messages = [NSMutableArray new];
    }
    
    NSString *returnedMessage = [self.game chooseCardAtIndex:cardIndex];
    
    if (returnedMessage)
    {
        [self.messages addObject:returnedMessage];
    }
    if ([self.messages count] > 0)
    {
        self.matchResults.text = [self.messages lastObject];
    }
    else
    {
        self.matchResults.text = returnedMessage;
    }
    [self updateUI];
    
}

- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle: [self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    
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
