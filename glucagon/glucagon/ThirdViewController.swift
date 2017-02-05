//
//  ThirdViewController.swift
//  glucagon
//
//  Created by Sahas D on 2/4/17.
//  Copyright © 2017 sahasd. All rights reserved.
//

import UIKit
import Firebase


class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //let ref: Firebase?
    @IBOutlet weak var tableView: UITableView!
    
    let animals = ["Cat", "Dog", "Cow", "Mulval"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        //cell.textLabel?.text = animals[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
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
