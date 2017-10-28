//
//  FirstViewController.swift
//  FriendListAppTest
//
//  Created by 滋野靖之 on 2017/09/23.
//  Copyright © 2017年 Alternated. All rights reserved.
//

import UIKit


class FriendRegistViewController:UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var registImage:UIImage?
    @IBOutlet weak var SampleImageView: UIImageView!
    @IBOutlet weak var GenderType: UISegmentedControl!    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Other1: UITextField!
    @IBOutlet weak var Other2: UITextField!
    
    @IBAction func getText(_ sender: UITextField) {
    }
    
    
    // カメラロールから写真を選択する処理
    @IBAction func choosePicture(_ sender: Any) {
        // カメラロールが利用可能か？
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラロールにする
            // 「.camera」にすればカメラを起動できる
            pickerView.sourceType = .photoLibrary
            // デリゲート。処理の委託先を指定。
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
    }
    
    

    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 選択した写真を取得する
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // ビューに表示する
        self.SampleImageView.image = image
        self.registImage=image
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
    func clearForm(){
        self.GenderType.selectedSegmentIndex=0
        self.Name.text=""
        self.Other1.text=""
        self.Other2.text=""
    }
    
    func registRealm(){
        let dao = RealmBaseDao<FriendObject>()
        let newFriend = FriendObject()
        newFriend.gender="M"
        if (self.GenderType.selectedSegmentIndex != 0) {
            newFriend.gender="F"
        }
        newFriend.id=dao.newId()!
        newFriend.name=self.Name.text!
        newFriend.other1=self.Other1.text!
        newFriend.other2=self.Other2.text!
        newFriend.image=ConvertImageToData(image:self.registImage!)!
        dao.add(d: newFriend)
        
    }
    
    
    
    @IBAction func registBtn(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "保存してもいいですか？", preferredStyle:  UIAlertControllerStyle.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
            self.registRealm()
            self.clearForm()
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.registImage=self.SampleImageView.image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // FirstViewがインスタンスとして生成された時に実行される(初回のみ)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // メモリが圧迫された(システムが警告を発した)時に実行される。具体的には、オブジェクトの解放など。
    }


}

