//
//  VoicesViewController.swift
//  Listen
//
//  Created by sunyanling on 2017/6/17.
//  Copyright © 2017年 sunyanling. All rights reserved.
//

import UIKit

class VoicesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    lazy var tableView: UITableView = {
       let tableView = UITableView.init()
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    var manager = RecordManager()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VoicesCell.self, forCellReuseIdentifier: "VoicesCellIndefier")
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        self.view.addSubview(tableView)
        tableView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoicesCellIndefier", for: indexPath) as! VoicesCell
        cell.configItem()
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.manager.play(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.manager.recorders.count
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


class VoicesCell: UITableViewCell {
    lazy var nameLab: UILabel = {
        let label = UILabel.init()
        return label
    }()
    lazy var palyButton: UIButton = {
       let button = UIButton.init(type: UIButtonType.custom)
        button.setTitle("播放录音", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        return button
    }()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: UITableViewCellStyle,reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    func setupViews()  {
        nameLab.frame = CGRect.init(x: 10, y: 10, width: UIScreen.main.bounds.width - 120, height: 40)
        palyButton.frame = CGRect.init(x: UIScreen.main.bounds.width - 110, y: 10, width: 100, height: 40)
        self.contentView.addSubview(nameLab)
        self.contentView.addSubview(palyButton)
    }
    func configItem() {
        nameLab.text = "录音名字"
    }
}
