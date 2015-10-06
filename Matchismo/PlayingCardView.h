//
//  PlayingCardView.h
//  Matchismo
//  (previously SuperCard)
//
//  Created by Sam Fisher on 10/1/15.
//  Copyright © 2015 Sam Fisher Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong) NSString *suit;
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
