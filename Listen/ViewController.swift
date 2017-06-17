//
//  ViewController.swift
//  Listen
//
//  Created by sunyanling on 2017/6/17.
//  Copyright © 2017年 sunyanling. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    lazy var recoder_manager: RecordManager = {
         let recoder_manager = RecordManager()//初始化
        return recoder_manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "录音"
        self.view.backgroundColor = UIColor.white
        
        let rightBtn = UIButton.init(type: UIButtonType.custom)
        rightBtn.setTitle("录音列表", for: .normal)
        rightBtn.setTitleColor(UIColor.red, for: .normal)
        rightBtn.frame = CGRect.init(x: 0, y: 0, width: 100, height: 50)
        rightBtn.addTarget(self, action: #selector(rightBtnAction), for: UIControlEvents.touchUpInside)
        let rightBtnItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightBtnItem;

        let beginBtn = UIButton.init(type: UIButtonType.custom)
        beginBtn.setTitle("开始录音", for: .normal)
        beginBtn.backgroundColor = UIColor.red
        beginBtn.addTarget(self, action: #selector(beginction), for: UIControlEvents.touchUpInside)
        beginBtn.frame = CGRect.init(x: 100, y: 100, width: 100, height: 50)
        self.view.addSubview(beginBtn)
        
        let stopBtn = UIButton.init(type: UIButtonType.custom)
        stopBtn.setTitle("结束录音", for: .normal)
        stopBtn.backgroundColor = UIColor.red
        stopBtn.addTarget(self, action: #selector(stopAction), for: UIControlEvents.touchUpInside)
        stopBtn.frame = CGRect.init(x: 100, y: 200, width: 100, height: 50)
        self.view.addSubview(stopBtn)
        
        let playBtn = UIButton.init(type: UIButtonType.custom)
        playBtn.setTitle("播放录音", for: .normal)
        playBtn.backgroundColor = UIColor.red
        playBtn.addTarget(self, action: #selector(playAction), for: UIControlEvents.touchUpInside)
        playBtn.frame = CGRect.init(x: 100, y: 300, width: 100, height: 50)
        self.view.addSubview(playBtn)
        
    }
    
    func beginction() {
        
         recoder_manager.beginRecord()
    }
    
    func stopAction()  {
        recoder_manager.stopRecord()
    }
    func playAction() {
//        recoder_manager.play()
        recoder_manager.play(index: recoder_manager.recorders.count - 1)
    }
    func rightBtnAction()  {
        let ctrl = VoicesViewController()
        ctrl.manager = self.recoder_manager
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

