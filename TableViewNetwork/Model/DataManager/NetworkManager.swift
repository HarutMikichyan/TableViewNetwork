//
//  NetworkManager.swift
//  TableViewNetwork
//
//  Created by Harut Mikichyan on 10/25/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    func getImageData(data: Data, completion: @escaping ([ImageData]) -> Void) {
        var users = [ImageData]()
        //Parse Json Data
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            for jsonFragment in jsonObject as! [[String: Any]] {
                let id = jsonFragment["resource_id"] as! String
                let imageStringURL = jsonFragment["icon_url"] as! String
                
                let userData = ImageData(imageID: id, stringURL: imageStringURL)
                users.append(userData)
            }
            completion(users)
        } catch {
            completion(users)
        }
    }
}
