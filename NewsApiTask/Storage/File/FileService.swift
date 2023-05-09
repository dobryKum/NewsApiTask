//
//  FileService.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 4.05.23.
//

import UIKit

protocol FileServiceProtocol: AnyObject {
    func saveImage(path: String, image: UIImage)
    func getImage(path: String) -> UIImage?
}

final class FileService: FileServiceProtocol {
    // MARK: - Properties
    private let fileManager = FileManager.default
    
    // MARK: - Methods
    func saveImage(path: String, image: UIImage) {
        let path = path.replacingOccurrences(of: "/", with: "")
        guard let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return }
        
        let fileURL = documentsDirectory.appendingPathComponent(path)
        guard let data = image.pngData() else { return }
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
    }
    
    func getImage(path: String) -> UIImage? {
        let path = path.replacingOccurrences(of: "/", with: "")
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(path)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
}
