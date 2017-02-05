//
//  SecondViewController.swift
//  glucagon
//
//  Created by Sahas D on 2/4/17.
//  Copyright © 2017 sahasd. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

var ref = FIRDatabase.database().reference()


class SecondViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var mainJSON : JSON = JSON.null;
    
    @IBAction func addImage(_ sender: Any) {
        print("added image");
    }

    
    @IBOutlet weak var yes: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var sugar: UILabel!
    @IBOutlet weak var protein: UILabel!
    
    @IBAction func takePic(_ sender: Any) {
        print("pressed button");
        
        selectPicture()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        name.isHidden = true;
        yes.isHidden = true;
        calories.isHidden = true;
        sugar.isHidden = true;
        protein.isHidden = true;
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
        Alamofire.request("https://los-altos-hacks-2-nihaleg.c9users.io/pic", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
                var str = response.result.value!
                if let dataFromString = str.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    print(json)
                    self.name.text = "Name: \(json["item"].string!)"
                    for(index, subJson) in json["nutrients"]
                    {
                        if(subJson["nutrient"] == "Protein" || subJson["nutrient"] == "protein")
                        {
                            self.protein.text = "Protein: \(subJson["amount"].string!) grams"
                        }
                        if(subJson["nutrient"] == "Calories" || subJson["nutrient"] == "calories")
                        {
                            self.calories.text = "Calories: \(subJson["amount"].string!) grams"
                        }
                        if(subJson["nutrient"] == "Sugars" || subJson["nutrient"] == "sugars")
                        {
                            self.sugar.text = "Sugars: \(subJson["amount"].string!) grams"
                        }
                    }
                    
                }
        }
        name.isHidden = false;
        yes.isHidden = false;
        calories.isHidden = false;
        sugar.isHidden = false;
        protein.isHidden = false;
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

