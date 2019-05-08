//
//  VideoCellTableViewCell.swift
//  UizaPlayerTab
//
//  Created by le anh duc on 5/6/19.
//  Copyright © 2019 ducla. All rights reserved.
//

import UIKit

class VideoCellTableViewCell: UITableViewCell {
    
    var name: String = "" {
        didSet {
            if(name != oldValue){
                nameLabel.text = name
            }
        }
    }
    var nameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let nameRect = CGRect(x: 0, y: 5, width:  70, height:  15)
        nameLabel = UILabel(frame: nameRect)
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
