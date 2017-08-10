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
//        HHNetworkTools.shareTools.request(isLogin: <#T##Bool#>, method: <#T##RequestMethod#>, URLString: <#T##String#>, parameters: <#T##[String : AnyObject]?#>, networkDataBack: <#T##HHNetworkDataBack##HHNetworkDataBack##([String : AnyObject]?, Error?) -> ()#>)

//        HHNetworkClass.get
        HHNetworkTools.shareTools.request(isLogin: false, method: .GET, URLString: "app/countries", parameters: nil, networkDataBack: { (response, error) -> Void in
            // 处理返回结果
            if response != nil {
//                if response?["status"] as! String == SUCCESSFUL{
//                    self.accountModel = HHAccountModel(dict: response?["data"] as! [String : AnyObject])
//                    self.saveUseAccount(response?["data"] as! [String : AnyObject])
//                    networkDataBacks(true,nil)
//                }else{
//                    networkDataBacks(response?["msg"],nil)
//                }
//            }else{
//                networkDataBacks(nil,error)
            }
        })
            
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
