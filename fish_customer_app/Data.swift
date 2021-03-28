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
        if((user_data["orders"]?.count)! > 0){
            let objects = ((user_data["orders"] as! [Any])[0] as! [Any])
            for i in 0 ... objects.count-1{
                let dictionary = objects[i] as! Dictionary<String, Any>                      /*辞書型変換*/
                userOrder.append(dictionary)
            
            }/*for文*/
        }
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
        
       
        
        if(!(user_data["orders"] == nil) && (user_data["orders"] as! [Any]).count > 0){                                                   /*ログインされてデータあるとき*/
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
        if(!(user_data["orders"] == nil) && (user_data["orders"] as! [Any]).count > 0){
            let objects = ((user_data["orders"] as! [Any])[0] as! [Any])
            return objects.count
        }
        else{
            return 0
        }
    }
/********************************ユーザーごとのデータ取り出し(ユーザーデータの更新)********************************************************************************************/
    func showUserData(id: Int){
        if(!(user_data["name"] == nil)){
           
            user_data.removeAll()
            let url = URL(string: "https://uematsu-backend.herokuapp.com/users/show")
            var request = URLRequest(url:  url!)
            request.httpMethod = "POST"
            request.httpBody = (
                "id=" + id.description +
                "&email=" + user_email +
                "&password=" + user_password
            ).data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
               
                if((data) != nil){
                    let jsons = try! JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
                    user_data["id"] = jsons["id"] as AnyObject?
                    user_data["name"] = jsons["name"] as AnyObject?
                    user_data["email"] = jsons["email"] as AnyObject?
                    user_data["orders"] = jsons["orders"] as AnyObject?
                    
                }
            })
            task.resume()
            
        }
    }
}
