//
//  DataStore.swift
//  TableViewNetwork
//
//  Created by Harut Mikichyan on 10/26/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import UIKit

final class DataStore {
    static let shared = DataStore()

    private let manager = FileManager.default
    let queue = DispatchQueue.init(label: "Image")

    var documentDirectory: URL {
        return manager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    func saveImage(stringURL: String, callBack: @escaping ((UIImage?, Bool) -> Void)) {
        let url = documentDirectory

        let folderPath = url.appendingPathComponent("Images")
        try? manager.createDirectory(atPath: folderPath.path, withIntermediateDirectories: false, attributes: nil)

        let fileName = createFileName(stringURL)
        let filePath = folderPath.appendingPathComponent(fileName)

        let isExist = manager.fileExists(atPath: filePath.path)

        if isExist {
            let image = UIImage(contentsOfFile: filePath.path)
            callBack(image, true)
        } else {
            let imageUrl = URL.init(string: stringURL)!
            queue.async {
                do {
                    let data = try Data.init(contentsOf: imageUrl)
                    self.manager.createFile(atPath: filePath.path, contents: data, attributes: nil)

                    DispatchQueue.main.async {
                        callBack(UIImage(data: data), true)
                    }
                } catch {
                    callBack(nil, false)
                }
            }
        }
    }

    private func createFileName(_ name: String) -> String {
        let name = name.split(separator: "/").last!.split(separator: ".").first!
        return String(name)
    }
}
