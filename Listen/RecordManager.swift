//
//  RecordManager.swift
//  Listen
//
//  Created by sunyanling on 2017/6/17.
//  Copyright © 2017年 sunyanling. All rights reserved.
//

import Foundation
import AVFoundation

class RecordManager {
   
        
        
        var recorder: AVAudioRecorder?
        var player: AVAudioPlayer?
        let file_path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/record.wav")
        var recorders = [String]()
    
    
        //开始录音
        func beginRecord() {
            let session = AVAudioSession.sharedInstance()
            //设置session类型
            do {
                try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            } catch let err{
                print("设置类型失败:\(err.localizedDescription)")
            }
            //设置session动作
            do {
                try session.setActive(true)
            } catch let err {
                print("初始化动作失败:\(err.localizedDescription)")
            }
            
            let recordSetting: [String: Any] = [AVSampleRateKey: NSNumber(value: 16000),
                AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),
                AVLinearPCMBitDepthKey: NSNumber(value: 16),
                AVNumberOfChannelsKey: NSNumber(value: 1),
                AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.min.rawValue)
            ];
            //开始录音
            do {
                let url = URL(fileURLWithPath: file_path!)
                 recorders.append(file_path!)
                recorder = try AVAudioRecorder(url: url, settings: recordSetting)
                recorder!.prepareToRecord()
                recorder!.record()
                print("开始录音")
            } catch let err {
                print("录音失败:\(err.localizedDescription)")
            }
        }
    
        //结束录音
        func stopRecord() {
            if let recorder = self.recorder {
                if recorder.isRecording {
//                    recorders.append(file_path!)
//                    print(recorders)
                    print("正在录音，马上结束它，文件保存到了：\(file_path!)")
                   
                }else {
                    print("没有录音，但是依然结束它")
                }
                recorder.stop()
                self.recorder = nil
            }else {
                print("没有初始化")
            }
        }
        
        
        //播放
    func play(index: Int) {
            do {
//                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: file_path!))
                  player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: recorders[index]))
                print("歌曲长度：\(player!.duration)")
                player!.play()
            } catch let err {
                print("播放失败:\(err.localizedDescription)")
            }
        }
}
