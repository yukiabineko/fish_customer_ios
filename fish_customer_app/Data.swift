//
//  Data.swift
//  fish_customer_app
//
//  Created by abi on 2021/02/08.
//

import Foundation

class MyData{
    /*文字列日時変換*/
    
    func dateParse(string: String, format: String) -> Date{
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = format
        return formatter.date(from: string)!
    }
    /*日時文字列変換*/
    func stringFromDate(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    /*ユーザーのオーダー一覧*/
    func orderUser() -> Array<Any>{
        var userOrder: Array<Any> = []
        let objects = ((user_data["orders"] as! [Any])[0] as! [Any])
        for i in 0 ... objects.count-1{
            let dictionary = objects[i] as! Dictionary<String, Any>                      /*辞書型変換*/
            userOrder.append(dictionary)
        
        }/*for文*/
        return userOrder
    }
    /*本日、明日の注文確保*/
    func todayOrders()-> (today: Array<Any>, tomorrow: Array<Any>){
        var todayArray:Array<Any> = []                                                       /*今日のデータ*/
        var tomorrowArray:Array<Any> = []                                                        /*明日のデータ*/
        
        let todayDate = Date()
        let today = stringFromDate(date: todayDate, format: "yyyy/MM/dd")
        let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: todayDate)
        let tomorrow = stringFromDate(date: tomorrowDate!, format: "yyyy/MM/dd")
        
        if(!(user_data["orders"] == nil)){                                                   /*ログインされてデータあるとき*/
            
            let objects = ((user_data["orders"] as! [Any])[0] as! [Any])
            for i in 0 ... objects.count-1{
                let dictionary = objects[i] as! Dictionary<String, Any>                      /*辞書型変換*/
                if(today == dictionary["shopping_date"] as! String){
                    todayArray.append(dictionary)
                }
                if(tomorrow == dictionary["shopping_date"] as! String){
                    tomorrowArray.append(dictionary)
                }
            
            }/*for文*/
            
        }/*=>if文*/
        return (todayArray, tomorrowArray)
    }
/********************************オーダー数********************************************************************************************/
    func orderCount() -> Int{
        if(!(user_data["orders"] == nil)){
            let objects = ((user_data["orders"] as! [Any])[0] as! [Any])
            return objects.count
        }
        else{
            return 0
        }
    }
}
