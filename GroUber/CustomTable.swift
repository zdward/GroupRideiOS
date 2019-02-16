//
//  CustomTable.swift
//  GroUber
//
//  Created by alex chuckas on 2/5/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit

class CustomTable: UITableView{

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self {
            return nil
        }
        return hitView
    }
    /*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\n\n\nhi")
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("\n\n\ndumb")
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "settings_cell")
        cell.textLabel?.text = "oh boi"
        return cell
    }*/


}
