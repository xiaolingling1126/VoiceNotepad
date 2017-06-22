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
         let recoder_manager = RecordManager()
        return recoder_manager
    }()
    
    lazy var beginBtn: UIButton = {
        let beginBtn = UIButton.init(type: UIButtonType.custom)
        beginBtn.setImage(UIImage.init(named: "recordbg"), for: .normal)
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressActioin))
        beginBtn.addGestureRecognizer(longPress)

        return beginBtn
    }()

    lazy var playBtn: UIButton = {
        let playBtn = UIButton.init(type: UIButtonType.custom)
        playBtn.setTitle("播放录音", for: .normal)
        playBtn.setImage(UIImage.init(named: "start"), for: .normal)
        playBtn.addTarget(self, action: #selector(playAction), for: UIControlEvents.touchUpInside)

        return playBtn
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
        
        setupViews()
        setupFrames()
    }
    
    func longPressActioin(sender: UILongPressGestureRecognizer)  {

        if sender.state == .began{
            recoder_manager.beginRecord()
            print("长按开始")
        }else if sender.state == .ended{
            recoder_manager.stopRecord()
            print("长按结束")
        }
    }
    
    func setupViews()  {
        self.view.addSubview(beginBtn)
        self.view.addSubview(playBtn)
    }
    
    func setupFrames()  {
        
        beginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }

        playBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(beginBtn.snp.bottom).offset(100)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    func beginction() {
        
         recoder_manager.beginRecord()
    }
    
    func stopAction()  {
        recoder_manager.stopRecord()
    }
    func playAction() {
        if recoder_manager.recorders.count > 0 {
            recoder_manager.play(index: recoder_manager.recorders.count - 1)
        }
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

