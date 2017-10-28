//
//  SecondViewController.swift
//  FriendListAppTest
//
//  Created by 滋野靖之 on 2017/09/23.
//  Copyright © 2017年 Alternated. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift


class FriendListViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    var selectedFriend:FriendObject?
    @IBOutlet weak var FriendListView: UITableView!
    //変数FriendObjectsを呼び出すと、DBからFriendObjectの一覧がResults型で返される
    var FriendObjects:Results<FriendObject>?{
        do{
            let dao = RealmBaseDao<FriendObject>()
            return dao.findAll()
        }
    }
    
    //表示するセルの数を指定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendObjects!.count
    }

    //セルに値を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FriendTableViewCell=tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
        cell.id=FriendObjects![indexPath.row].id
        cell.textLabel!.text = "  "+FriendObjects![indexPath.row].name
        let FriendImage=ConvertDataToImage(data: FriendObjects![indexPath.row].image)
        cell.imageView?.image = FriendImage?.ResizeÜIImage(width: 80, height: 80)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if(editingStyle == UITableViewCellEditingStyle.delete) {
            do{
                let dao=RealmBaseDao<FriendObject>()
                dao.delete(d: FriendObjects![indexPath.row])
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
            }catch{
            }
            tableView.reloadData()
        }
    }

    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        let cell=tableView.cellForRow(at: indexPath) as! FriendTableViewCell
        self.selectedFriend=getFriend(id: cell.id!)
        performSegue(withIdentifier: "goDetail", sender:nil)
    }
    
    
    //senderはuiパーツの種別が格納される。（それ以外はダメ）
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="goDetail"){
            let NextVC:FriendDetailViewController=(segue.destination as! FriendDetailViewController)
            NextVC.friend=self.selectedFriend
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FriendListView.delegate=self
        FriendListView.dataSource=self
    }
    override func viewWillAppear(_ animated: Bool) {
        FriendListView.reloadData()
        FriendListView.rowHeight=80
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

