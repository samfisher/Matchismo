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



@interface SetGameViewController ()

@end

@implementation SetGameViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.deck = [self createDeck];
    self.messages = [[NSMutableArray alloc] init];
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    
    id returnedMessage = [self.game chooseCardAtIndex:cardIndex];
    
    
    if (![returnedMessage isKindOfClass:[NSAttributedString class]])
    {
        return;
    }
    
    [self.matchResults setAttributedText:returnedMessage];
    
    if( ((NSAttributedString *)returnedMessage).length > 0)
    {
        [self.messages addObject:returnedMessage];
    }
    
    [self updateUI];
}


- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        SetCard *card = (SetCard *) [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:card.newContents forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        
        cardButton.enabled = ![card isMatched];
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:@"cardfront"];
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (CardMatchingGame *)createGame
{
    return [[SetCardGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] numberOfMatches:self.numberOfMatches];
}

- (NSUInteger)numberOfMatches
{
    return 3;
}

@end
