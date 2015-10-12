//
//  ViewController.m
//  Matchismo
//
//  Created by Sam Fisher on 9/18/15.
//  Copyright (c) 2015 Sam Fisher Apps. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

//@property (strong, nonatomic) IBOutlet UISwitch *threeCardGame;

@end

@implementation ViewController

#pragma mark - Lifecycle
// -----------------------------------------------------------------------------

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self updateUI];
}

#pragma mark - New Grid stuff
- (NSMutableArray *)cardViews
{
    if (!_cardViews) _cardViews = [NSMutableArray arrayWithCapacity:self.numberOfStartingCards];
    return _cardViews;
}

- (Grid *)grid
{
    if (!_grid)
    {
        _grid = [[Grid alloc] init];
        _grid.cellAspectRatio = self.maxCardSize.width / self.maxCardSize.height;
        _grid.minimumNumberOfCells = self.numberOfStartingCards;
        _grid.maxCellWidth = self.maxCardSize.width;
        _grid.maxCellHeight = self.maxCardSize.height;
        _grid.size = self.gridView.frame.size;
    }
    return _grid;
}

- (UIView *)createViewForCard:(Card *)card
{
    UIView *view = [[UIView alloc] init];
    [self updateView:view forCard:card];
    return view;
}

- (void)updateView:(UIView *)view forCard:(Card *)card
{
    view.backgroundColor = [UIColor blueColor];
}

- (void)touchCard:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        [self.game chooseCardAtIndex:gesture.view.tag];
        [self updateUI];
    }
}


- (Deck *)createDeck //abstract
{
    return nil;
}

- (NSUInteger)numberOfMatches
{
    return 2;
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

- (IBAction)touchResetButton:(UIButton *)sender
{
    self.cardViews = nil;
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
