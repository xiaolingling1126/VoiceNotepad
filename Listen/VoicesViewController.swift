//
//  VoicesViewController.swift
//  Listen
//
//  Created by sunyanling on 2017/6/17.
//  Copyright © 2017年 sunyanling. All rights reserved.
//

import UIKit

class VoicesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //[(index, isSelected)]
    var manager = RecordManager()
    var dataSource: [(Int, Bool)] = []
    
    lazy var tableView: UITableView = {
       let tableView = UITableView.init()
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VoicesCell.self, forCellReuseIdentifier: "VoicesCellIndefier")
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        //初始化datasource
        for (index, _) in manager.recorders.enumerated() {
            dataSource.append((index, false))
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoicesCellIndefier", for: indexPath) as! VoicesCell
        cell.configItem(item: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        dataSource = dataSource.map { element -> (Int, Bool) in
            if element.0 == indexPath.row {
                return (element.0, !element.1)
            }
            return (element.0, element.1)
        }
        
        let item = dataSource[indexPath.row]
        if item.1 {
            self.manager.play(index: indexPath.row)
        } else {
            self.manager.stopPlay()
        }
        let cell  = tableView.cellForRow(at: indexPath) as! VoicesCell
        cell.palyButton.isSelected = item.1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

import SnapKit
class VoicesCell: UITableViewCell {
   
    lazy var nameLab: UILabel = {
        let label = UILabel.init()
        return label
    }()
    lazy var palyButton: UIButton = {
       let button = UIButton.init(type: UIButtonType.custom)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.isUserInteractionEnabled = false
        button.setImage(UIImage.init(named: "start"), for: .normal)
         button.setImage(UIImage.init(named: "pause"), for: .selected)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle,reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupFrame()
    }
    
    func setupViews()  {
        self.contentView.addSubview(nameLab)
        self.contentView.addSubview(palyButton)
    }
    
    func setupFrame()  {
        
        nameLab.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.height.equalTo(40)
        }
        palyButton.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.right.equalTo(-10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    func configItem(item: (Int, Bool)) {
        nameLab.text = "录音名字" + "\(item.0)"
        palyButton.isSelected = item.1
    }
}
