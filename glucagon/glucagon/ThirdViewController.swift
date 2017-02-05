//
//  ThirdViewController.swift
//  glucagon
//
//  Created by Sahas D on 2/4/17.
//  Copyright © 2017 sahasd. All rights reserved.
//

import UIKit
import Firebase


var user: String!

struct dayItem
{
    var item: String!
    var cals: String!
    var date: String!
    //let ref: Firebase?
    
    
    // Initialize from arbitrary data
    init(item: String, cals: String, date: String) {
        self.item = item
        self.cals = cals
        self.date = date
        //self.ref = nil
    }
    
    
}

var list = [dayItem]()


class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //let ref: Firebase?
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var userLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
               // Do any additional setup after loading the view.
        
        rootRef.observe(.value, with: {
            snapshot in
            let objects = JSON(snapshot.value)
            //print(objects)
            user = "\(objects["username"].string!)"
            self.userLabel.text = "Hello \(user!)"
            self.userLabel.sizeToFit()

            var mDate = "";
            var item1 = "";
            var item2 = "";
            var cals1 = "";
            for (index,subJson) in objects["meals"] {
                mDate = "\(subJson["date"].string!)"
                item1 = "\(subJson["item"].string!)"
                //let index1 = item1.index(item1.startIndex, offsetBy: item1.length-2)
                //print(subJson["nutrients"])
               // let start = item2.index(item2.startIndex, offsetBy: 10)
                //let end = item2.index(item2.startIndex, offsetBy: -3)
                //let range = start..<end
                //item1 = item2.substring(with: range)
                print(item1)
            
                for(index1, superJson) in subJson["nutrients"] {
                    if superJson["nutrient"].string!=="calories" {
                        cals1 = superJson["amount"].string!
                        //print(cals)
                    }
                }
                
                print("----------------------");
                /*for(key2,superSubJson):(String, JSON) in subJson{
                    qim = (superSubJson["picture"].string)!
                    //sender = superSubJson["senderId"].string?
                    text = superSubJson["text"].string!
                    let myItem = StoryItem(questionImage: qim, user: user, question: text, ref: nil)
                    print("----------------------");
                    //print(myItem)
                    print("----------------------");
                    items.append(myItem)
                    self.tableView.reloadData()
                    
                }*/
                
                let myItem = dayItem(item: item1, cals: cals1, date: mDate)
                list.append(myItem);
                self.tableView.reloadData()
            }
        })
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell") as! dayTableViewCell!
        if(list.count > 0)
        {
            let data = list[indexPath.row] as dayItem!
            //let image: UIImage = UIImage(data: NSData(contentsOfURL: NSURL(string: data.questionImage)!)!)!
            //cell.problemImageView.image = image
            //print(data?.date)
            cell?.date.text = "Date: \(data!.date!)"
            cell?.meal.text = "Meal: \(data!.item!)"
            cell?.calories.text = "Calories: \(data!.cals!)"
            cell?.date.sizeToFit()
             cell?.meal.sizeToFit()
            cell?.calories.sizeToFit()
            //cell.delegate = self
            
            //cell.confirmButton.addTarget(self, action: Selector("confirmed:"), forControlEvents: .TouchUpInside)
            //cell.confirmButton.tag = indexPath.row
            //let story = items[indexPath.row] as StoryItem
            //neededObject = story
            //print(neededObject)
            //count = items.count

        }
        //cell.textLabel?.text = animals[indexPath.row]
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
