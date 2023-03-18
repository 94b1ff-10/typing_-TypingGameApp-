//
//  RecordViewController.swift
//  typing_
//
//  Created by TEN MATSUMOTO on 12/3/2023.
//

import Foundation
import UIKit
import RealmSwift

class RecordViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        setData()
    }
    
    // Changes date format
    var dateFormat: DateFormatter {
     let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dateFormatter
    }
    
    var dataList: [DataModel] = []
    
    func setData() {
        let realm = try! Realm()
        let typingResultData = realm.objects(DataModel.self)
        dataList = Array(typingResultData)
    }
    
}

//UITableViewに表示する内容を定義する↓
extension RecordViewController: UITableViewDataSource {
    //下の"numberOfRowsInSection"はUITableViewに表示するリストの数を定義するmethod
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataList.reverse()
        return dataList.count
    }
    //下の"cellForRowAt"はUItableViewに表示されるリストの中身(cellという)を定義するmethod
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        //indexPath.row→ UITableViewに表示されるCellの(0から始まる)通し番号が順番に渡される
        let dataModel: DataModel = dataList[indexPath.row]
        cell.setup(date: dateFormat.string(from: dataModel.recordDate), hand: dataModel.sides, accuracy: dataModel.accuracy, speed: dataModel.speed)
        return cell
    }
}

//UITableViewを操作した際の挙動を定義する
extension RecordViewController: UITableViewDelegate {
    //UITableViewをスワイプした際にメモを削除するための処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let targetCell = dataList[indexPath.row]
        let realm = try! Realm()
        try! realm.write {
            realm.delete(targetCell)
        }
        dataList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

}
