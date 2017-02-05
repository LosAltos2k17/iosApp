//
//  SecondViewController.swift
//  glucagon
//
//  Created by Sahas D on 2/4/17.
//  Copyright © 2017 sahasd. All rights reserved.
//

import UIKit
import Alamofire

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
        let parameters = ["pic":dataStr]
        Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            if let JSON = response.result.value {
                print (JSON)
            }
        }
        

    }
}

