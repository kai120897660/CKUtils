//
//  AudioPlayerManager.swift
//  qiqi_ios
//
//  Created by design on 2018/6/28.
//  Copyright © 2018年 design. All rights reserved.
//

import UIKit
import AVFoundation


class AudioPlayerManager: NSObject {
    
    static let sharedInstance = AudioPlayerManager()
    
    var playing: Bool = false
    
    ///audio player
    private var audioPlayer: AVAudioPlayer!
    ///finished call back
    private var playFinished: Finished?
    
    var audioRecorder:  AVAudioRecorder!
    
    //MARK:   --   play audio func
    func playAudio(_ url: String, finished: Finished?) {
        self.playFinished = finished
        let session = AVAudioSession.sharedInstance()
        if #available(iOS 10.0, *) {
            try! session.setCategory(AVAudioSession.Category.playback, mode: session.mode, options: [])
        } else {
            // Fallback on earlier versions
        }
//        try! session.setCategory(convertFromAVAudioSessionCategory(AVAudioSession.Category.playback))
        try! session.setActive(true)
//        let path = Bundle.main.(forResource: "蜡笔小新 - 大象，大象", ofType: "mp3")
        do {
//            let path = Bundle.main.path(forResource: "蜡笔小新 - 大象，大象", ofType: "mp3")
//            let data = NSData.init(contentsOfFile: path!)
//            self.audioPlayer = try AVAudioPlayer.init(data: Data.init(referencing: data!))
            self.audioPlayer = try AVAudioPlayer.init(contentsOf: URL.init(fileURLWithPath: url))
//            self.audioPlayer.prepareToPlay()
//            self.audioPlayer.volume = 1.0
            self.audioPlayer.play()
            self.playing = true
            self.perform(#selector(audioPlayFinished), with: nil, afterDelay: self.audioPlayer.duration)
        } catch let error {
            ck_print(error)
            self.playing = false
        }
    }
    
    func playAudio(data: Data, finished: Finished?) {
        self.playFinished = finished
        let session = AVAudioSession.sharedInstance()
        if #available(iOS 10.0, *) {
            try! session.setCategory(AVAudioSession.Category.playback, mode: session.mode, options: [])
        } else {
            // Fallback on earlier versions
        }
//        try! session.setCategory(convertFromAVAudioSessionCategory(AVAudioSession.Category.playback))
        try! session.setActive(true)
        do {
            self.audioPlayer = try AVAudioPlayer.init(data: data)
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
            self.playing = true
            self.perform(#selector(audioPlayFinished), with: nil, afterDelay: ceil(self.audioPlayer.duration))
        } catch let error {
            ck_print(error)
            self.playing = false
            self.playFinished?()
        }
    }
    
    func getAudioTime(data: Data) -> NSNumber {
        do {
            let player = try AVAudioPlayer.init(data: data)
            return NSNumber.init(value: ceil(player.duration))
        } catch let error {
            ck_print(error)
            return 0
        }
    }
    
    func play() {
        self.audioPlayer.play()
    }
    
    func pause() {
        self.audioPlayer.pause()
        self.playing = false
    }
    
    func stop() {
        self.audioPlayer.stop()
        self.playing = false
    }
    
    func beginAudioRecord() {
        let session = AVAudioSession.sharedInstance()
        do {//设置类型
            if #available(iOS 10.0, *) {
                try session.setCategory(AVAudioSession.Category.playAndRecord, mode: session.mode, options: [])
            } else {
                // Fallback on earlier versions
            }
//            try session.setCategory(convertFromAVAudioSessionCategory(AVAudioSession.Category.record))
        } catch let error {
            ck_print("设置类型失败:\(error.localizedDescription)")
        }
        
        do  {//初始化动作
            try session.setActive(true)
        } catch let error {
            ck_print("初始化动作:\(error.localizedDescription)")
        }
        let recordrSettings = [
            AVSampleRateKey: NSNumber.init(value: 44100.0),//采样率
            AVFormatIDKey: NSNumber.init(value: kAudioFormatAppleIMA4),//音频格式
            AVLinearPCMBitDepthKey: NSNumber.init(value: 16),//采样位数
            AVNumberOfChannelsKey: NSNumber.init(value: 1),//通道数
            AVEncoderAudioQualityKey: NSNumber.init(value: AVAudioQuality.min.rawValue)]//录音质量
        let path = PathUtil.audioRecordePath()

        let url = URL.init(fileURLWithPath: path)

        do {
            ///开始录音
            try self.audioRecorder = AVAudioRecorder.init(url: url, settings: recordrSettings)
            self.audioRecorder.prepareToRecord()
            self.audioRecorder.record()
            ck_print("开始录音")
        } catch let error {
            ck_print("开始录音:\(error.localizedDescription)")
        }
    }
    
    func endRecord() {
        if (self.audioRecorder != nil) {
            if self.audioRecorder.isRecording {
                
                ck_print("正在录音，马上结束它，文件保存到了：\(PathUtil.audioRecordePath())")
                
                
            }else {
                
                ck_print("没有录音，但是依然结束它")
            }
            
            self.audioRecorder.stop()
            self.audioRecorder = nil
        }
    }
    
    //MARK:    --   private func
    @objc private func audioPlayFinished()  {
        self.playFinished?()
        self.playing = false
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
