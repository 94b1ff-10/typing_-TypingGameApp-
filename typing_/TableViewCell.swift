//
//  TableViewCell.swift
//  typing_
//
//  Created by TEN MATSUMOTO on 13/3/2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var handLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    //Storyboardまたはnibファイルからロードされた直後に呼ばれる(初期化などUserTableViewCellがロードされた直後に１度だけ実行したい処理をここに実装します。)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //選択状態と通常状態の状態アニメーション処理
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(date: String, hand: String, accuracy: Int, speed: Int) {
        dateLabel.text = date
        handLabel.text = hand
        accuracyLabel.text = "\(accuracy)%"
        speedLabel.text = "\(speed)c/min"
    }

}
