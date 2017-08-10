//
//  HHChoiceCuntryController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/10.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

class HHChoiceCuntryController: HHBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        HHNetworkClass().getCountryNumber(parameter: nil) { (respones, error) in
            
        }
    }
}

extension HHChoiceCuntryController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
          
     return cell
     }

}
