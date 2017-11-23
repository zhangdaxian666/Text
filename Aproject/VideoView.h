//
//  VideoView.h
//  Aproject
//
//  Created by slcf888 on 2017/11/20.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol VideoViewDelegate<NSObject>
@required
- (void)flushCurrentTime:(NSString *)timeString sliderValue:(float)sliderValue;
@end
@interface VideoView : UIView
@property(nonatomic, strong) NSString *playerUrl;
@property (nonatomic ,readonly) AVPlayerItem *item;

@property (nonatomic ,readonly) AVPlayerLayer *playerLayer;

@property (nonatomic ,readonly) AVPlayer *player;

@property (nonatomic ,weak) id <VideoViewDelegate> someDelegate;
- (id)initWithUrl:(NSString *)path delegate:(id<VideoViewDelegate>)delegate;
@end

@interface VideoView  (Guester)
- (void)addSwipeView;
@end
