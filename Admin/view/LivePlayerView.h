//
//  LivePlayerView.h
//  zhizhumofang
//
//  Created by 1 on 2019/6/20.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FullBtnTap)(void);

@interface LivePlayerView : UIView

///设备序列号
@property (nonatomic, copy) NSString *cameraNum;

///重新播放新的直播设备
- (void)replay:(NSString *)cameraNum;

///取消直播销毁当前播放器
- (void)destoryPlayer;

@property (nonatomic, copy) FullBtnTap fullScreenTap;

@end

NS_ASSUME_NONNULL_END
