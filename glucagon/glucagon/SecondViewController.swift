//
//  SecondViewController.swift
//  glucagon
//
//  Created by Sahas D on 2/4/17.
//  Copyright © 2017 sahasd. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBAction func takePic(_ sender: Any) {
        print("pressed button");
        
        selectPicture()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var newImage: UIImage
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newImage = img
            dismiss(animated: true)
            var indicator = UIActivityIndicatorView()
            
            func activityIndicator() {
                indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                indicator.center = self.view.center
                self.view.addSubview(indicator)
            }
            
            indicator.startAnimating()
            indicator.backgroundColor = UIColor.white
            
            sendImage(image: newImage);
            indicator.stopAnimating()
            indicator.hidesWhenStopped = true
        } else{
            print("Something went wrong")
        }
        // do something interesting here!

    }
    func sendImage(image: UIImage){
        let imageData = UIImagePNGRepresentation(image)
        let dataStr = imageData!.base64EncodedString(options: [.lineLength64Characters])
        print(dataStr)
        let parameters = ["pic": dataStr] as Dictionary<String, String>
        let url = URL(string: "https://los-altos-hacks-2-nihaleg.c9users.io/pic")!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
}

