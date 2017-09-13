//
//  HHAddressBookModel.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/9/13.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
/// 定义一个闭包
typealias HHAddressBookDataBack = (_ response: [HHInviteModel]?,_ error: Error?) -> ()
import UIKit
import Contacts
class HHAddressBook: NSObject {
    
    private var resultError:Error?
    
    // 1. 获取权限
    func readAllPeoples(_ addressBookDataBack: @escaping HHAddressBookDataBack){
        
        let status = CNContactStore.authorizationStatus(for: .contacts)
        if status == .notDetermined {
            //创建通讯录对象
            let store = CNContactStore()
            //请求授权
            store.requestAccess(for: .contacts, completionHandler: {[weak self] (isRight : Bool,error : Error?) in
                if isRight == true {
                    self?.getTelephoneNumber()
                    if (self?.contactArray.count)! > 0 {
                        addressBookDataBack(self?.contactArray,self?.resultError)
                    }
                } else {
                    HHProgressHUD().showHUDAddedTo(title: "未开启访问通讯录的权利", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)

                }
            })
        }else{
            getTelephoneNumber()
            if (self.contactArray.count) > 0 {
                addressBookDataBack(self.contactArray,self.resultError)
            }
        }
    }
    // 2. 获取联系人信息
    private func getTelephoneNumber(){
        // 创建通讯录对象
        let store = CNContactStore()
        // 从通讯录中获取所有联系人
        // 获取Fetch,并且指定之后要获取联系人中的什么属性
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey]
        // 创建请求对象   需要传入一个(keysToFetch: [CNKeyDescriptor]) 包含'CNKeyDescriptor'类型的数组
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        
        // 遍历所有联系人
        // 需要传入一个CNContactFetchRequest
        do {
            try store.enumerateContacts(with: request, usingBlock: {[weak self](contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
                
                //1.获取姓名
                let lastName = contact.familyName
                let firstName = contact.givenName
//                print("姓名 : \(lastName)\(firstName)")
                var name:String? = lastName + firstName
                if is_empty_string(name) {
                    name = "未知号码"
                }
                //2.获取电话号码
                let phoneNumbers = contact.phoneNumbers
                for phoneNumber in phoneNumbers
                {
                    let model = HHInviteModel()
                    model.inviteName = name
                    let numString = phoneNumber.value.stringValue
                    if !is_empty_string(numString){
                        model.inviteNumber = numString
                        self?.contactArray.append(model)
                    }
                }
            })
        } catch {
            HHPrint(error)
            resultError = error
        }

    }
    
    // 懒加载
    /// contactArray是由字典构成的，字典是由姓名为keys,电话为vaule
    private lazy var contactArray: Array = [HHInviteModel]()
}
