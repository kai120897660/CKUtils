//
//  LivePlayerView.m
//  zhizhumofang
//
//  Created by 1 on 2019/6/20.
//  Copyright © 2019 hzzhizhu. All rights reserved.
//

#import "LivePlayerView.h"
#import <EZOpenSDKFramework/EZOpenSDKFramework.h>
#import "BigDataAdmin-Swift.h"

#define EZOpenAppKey @"f42f220758e94296b06462453d9d7a3f"

@interface LivePlayerView ()<EZPlayerDelegate>

/**
 播放视图
 */
@property (nonatomic, weak) UIView *playerView;
/**
 播放器
 */
@property (nonatomic, strong) EZPlayer *player;

///错误信息展示
@property (nonatomic, weak) UILabel *errorLabel;
/**
 视频监控所需token
 */
@property (nonatomic, strong) NSString *accessToken;

@property (nonatomic,assign) BOOL playSuccess;

@property (nonatomic, strong) LivePlayViewModel *viewModel;

@property (nonatomic, weak) UIButton *fullBtn;

@property (nonatomic, weak) UIButton *backBtn;

@end

@implementation LivePlayerView


- (void)requestInfo {
    NSDictionary *params = @{@"deviceSerial": self.cameraNum};
    [self.viewModel requestDatas: params prepare:^{
        [self loadingShow];
    } callBack:^(id _Nullable obj) {
        NSDictionary *dic = (NSDictionary*)obj;
        self.accessToken = dic[@"accessToken"];
        [EZOpenSDK initLibWithAppKey:EZOpenAppKey];
        [EZOpenSDK setAccessToken:self.accessToken];
        [self startPlay];
//        [self loadingDimiss];
    }];

}

- (void)startPlay {
    
    
    //创建播放器，也可以直接使用EZPlayer类中的方法创建
    self.player = [EZOpenSDK createPlayerWithDeviceSerial: self.cameraNum cameraNo: 1];
    
    //可选，建议设置，设置后才可以处理代理方法
    self.player.delegate = self;
    
    //可选，设备开启了视频/图片加密功能后需设置，可根据EZDeviceInfo的isEncrypt属性判断
    //    [player setPlayVerifyCode:verifyCode];
    
    //设置用以展示直播画面的视图
    [self.player setPlayerView:self.playerView];
    
    //开始直播
    [self.player startRealPlay];
    
}
    
- (void)replay:(NSString *)cameraNum {
    self.cameraNum = cameraNum;
    if (self.player.destoryPlayer) {
        [self requestInfo];
    }
}

///取消直播销毁当前播放器
- (void)destoryPlayer {
    [self.player destoryPlayer];
}

- (void)fullScreenBtnTap {
    self.fullBtn.selected = !self.fullBtn.selected;
    self.fullBtn.hidden = self.fullBtn.selected;
    self.backBtn.hidden = !self.fullBtn.selected;
    if (self.fullBtn.selected) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.playerView];
        [UIView animateWithDuration:0.25 animations:^{
            CGSize size = UIScreen.mainScreen.bounds.size;
            self.playerView.frame = CGRectMake(0, 0, size.height, size.width);
            self.playerView.layer.position = [UIApplication sharedApplication].keyWindow.center;
            self.playerView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);//CGAffineTransformMakeRotation(M_PI_2);
        }];
        [UIApplication sharedApplication].statusBarHidden = YES;
    }else {
        [self addSubview:self.playerView];
        [UIView animateWithDuration:0.25 animations:^{
            self.playerView.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.width);
            self.playerView.layer.position = self.center;
            self.playerView.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);//CGAffineTransformMakeRotation(M_PI_2);
        }];
        [UIApplication sharedApplication].statusBarHidden = NO;
    }
}

#pragma mark   ---   EZPlayerDelegate
-  (void)player:(EZPlayer *)player didPlayFailed:(NSError *)error {
    self.playSuccess = NO;
    self.errorLabel.text = error.userInfo[@"ezvizErrorSolution"];
    [self loadingDimiss];
}

- (void)player:(EZPlayer *)player didReceivedMessage:(NSInteger)messageCode {
    self.playSuccess = YES;
    [self loadingDimiss];
    [self.playerView bringSubviewToFront:self.fullBtn];
    [self.playerView bringSubviewToFront:self.backBtn];
}

#pragma mark   ---    getter  setter
- (UIView *)playerView {
    if (!_playerView) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
//        view.userInteractionEnabled = NO;
        view.backgroundColor = [UIColor blackColor];
        [self addSubview:view];
        _playerView = view;
    }
    return _playerView;
}

- (UILabel *)errorLabel {
    if (!_errorLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.center = self.center;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [self.playerView addSubview:label];
        _errorLabel = label;
        
    }
    return _errorLabel;
}

- (UIButton *)fullBtn {
    if (!_fullBtn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 44, self.frame.size.height - 44, 44, 44)];
        [btn setImage:[UIImage imageNamed:@"fullscreen"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(fullScreenBtnTap) forControlEvents:UIControlEventTouchUpInside];
        [self.playerView addSubview:btn];
        _fullBtn = btn;
    }
    return _fullBtn;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(44, 0, 44, 44)];
        btn.hidden = YES;
        [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(fullScreenBtnTap) forControlEvents:UIControlEventTouchUpInside];
        [self.playerView addSubview:btn];
        _backBtn = btn;
    }
    return _backBtn;
}
    
- (LivePlayViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LivePlayViewModel alloc] init];
    }
    return _viewModel;
}

- (void)setCameraNum:(NSString *)cameraNum {
    _cameraNum = cameraNum;
    [self requestInfo];
}

@end
