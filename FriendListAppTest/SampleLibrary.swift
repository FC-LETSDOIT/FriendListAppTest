//
//  SampleLibrary.swift
//  FriendListAppTest
//
//  Created by 滋野靖之 on 2017/09/25.
//  Copyright © 2017年 Alternated. All rights reserved.
//

import Foundation
import UIKit

//UIImage<->NSData、エンコード関数の定義。realmではUIImageをそのまま格納することは出来ない。
public func ConvertImageToData(image : UIImage) -> NSData?{
    let data:NSData?=UIImageJPEGRepresentation(image, 0.75) as NSData?
    return data
}
public func ConvertDataToImage(data:NSData)->UIImage?{
    let image:UIImage?=UIImage(data:data as Data)
    return image
}

//UIImageクラスに画像をリサイズする関数を追加
extension UIImage{
    
    func ResizeÜIImage(width : CGFloat, height : CGFloat)-> UIImage!{
        // 指定された画像の大きさのコンテキストを用意.
        UIGraphicsBeginImageContext(CGSize(width:width, height:height))
        // コンテキストに自身に設定された画像を描画する.
        self.draw(in: CGRect(x:0, y:0, width:width, height:height))
        // コンテキストからUIImageを作る.
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // コンテキストを閉じる.
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
func getFriend(id:Int)->FriendObject{
    let dao=RealmBaseDao<FriendObject>()
    let friend=dao.find(key:id as AnyObject)
    return friend!
}



