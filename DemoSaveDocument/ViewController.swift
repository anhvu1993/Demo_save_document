//
//  ViewController.swift
//  DemoSaveDocument
//
//  Created by Anh vu on 22/06/2021.
//

import UIKit
import UniformTypeIdentifiers

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createFordeliCloudDrive()
    }


    @IBAction func saveAction(_ sender: Any) {
        showpikerDocument()
    }
    
    func showpikerDocument() {
        let documentsPicker =
            UIDocumentPickerViewController(forOpeningContentTypes: [.folder])
//        let documentsPicker = UIDocumentPickerViewController(documentTypes: ["public.folder"], in: .open)
        documentsPicker.delegate = self
//        documentPicker.directoryURL =  /đương dẩn thư mục app/
        documentsPicker.allowsMultipleSelection = false
        documentsPicker.modalPresentationStyle = .fullScreen
        self.present(documentsPicker, animated: true, completion: nil)
    }
    
    func openiCloudDocuments() {
        let importMenu = UIDocumentPickerViewController(documentTypes: [String("public.data")], in: .open)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }
    
    private func showFilePicker() {
            let picker = UIDocumentPickerViewController(
                forOpeningContentTypes: [
                    UTType.data
                ],
                asCopy: true)
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    
    func createFordeliCloudDrive() {
        if let containerUrl = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents") {
            if !FileManager.default.fileExists(atPath: containerUrl.path, isDirectory: nil) {
                do {
                    try FileManager.default.createDirectory(at: containerUrl, withIntermediateDirectories: true, attributes: nil)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}


extension ViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        _ = urls.compactMap { (url: URL) -> URL? in
            var url = url
            url.appendPathComponent("file-image.doc")
            do {
                guard let fileUrl = Bundle.main.url(forResource: "file-sample_100kB", withExtension: "doc") else { return nil}
                let fileData = NSData(contentsOf: fileUrl)
//                let data = UIImage(named: "ic_02")
//                let data = try Data(contentsOf: url)
                try fileData?.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
            
            return url
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
    
    //            let fileUrl = containerUrl.appendingPathComponent("hello.txt")
    //            do {
    //                try "Hello iCloud!".write(to: fileUrl, atomically: true, encoding: .utf8)
    //            }
    //            catch {
    //                print(error.localizedDescription)
    //            }
}
