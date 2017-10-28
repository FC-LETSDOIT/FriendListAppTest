//
//  DetailViewController.swift
//  FriendListAppTest
//
//  Created by 滋野靖之 on 2017/09/27.
//  Copyright © 2017年 Alternated. All rights reserved.
//

import UIKit

class FriendEditViewController: UIViewController {
    var friend:FriendObject?
    var str=""
    @IBOutlet weak var FriendImageView: UIImageView!
    @IBOutlet weak var GenderType: UISegmentedControl!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Other1: UITextField!
    @IBOutlet weak var Other2: UITextField!
    @IBAction func getText(_ sender: UITextField) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func editRealm(){
        //        self.friend!.image=ConvertImageToData(image: self.FriendImageView.image!)!
        print(self.friend!.id)
        let updateFriend=FriendObject()
        updateFriend.id=self.friend!.id
        updateFriend.name=self.Name.text!
        updateFriend.other1=self.Other1.text!
        updateFriend.other2=self.Other2.text!
        updateFriend.gender="M"
        updateFriend.image=self.friend!.image
        if (self.GenderType.selectedSegmentIndex==1){
            updateFriend.gender="F"
        }
        let dao=RealmBaseDao<FriendObject>()
        let _ = dao.update(d: updateFriend)
    }
    
    @IBAction func editBtn(_ sender: Any) {
        self.editRealm()
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.FriendImageView.image=ConvertDataToImage(data: self.friend!.image)
        self.GenderType.selectedSegmentIndex=0
        if(self.friend!.gender=="F"){
            self.GenderType.selectedSegmentIndex=1
        }
        self.Name.text=self.friend!.name
        self.Other1.text=self.friend!.other1
        self.Other2.text=self.friend!.other2
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

