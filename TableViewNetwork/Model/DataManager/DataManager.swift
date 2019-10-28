//
//  DataManager.swift
//  TableViewNetwork
//
//  Created by Harut Mikichyan on 10/25/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import Foundation

final class DataManager {
    
    private var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getImageData(completion: @escaping ([ImageData]?) -> Void) {
        DispatchQueue.global().async { [weak self] in
            if let self = self, let url = Bundle.main.url(forResource: "mask", withExtension: "json"), let data = try? Data(contentsOf: url) {
                self.networkManager.getImageData(data: data) { (imageData) in
                    if !imageData.isEmpty {
                        DispatchQueue.main.async {
                            completion(imageData)
                        }
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }
}
