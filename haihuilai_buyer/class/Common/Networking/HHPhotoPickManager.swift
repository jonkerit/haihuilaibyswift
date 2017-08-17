//
//  HHPhotoPickManager.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/17.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

enum pickerType:Int {
    case PickerType_Camera = 1
    case PickerType_Photo = 0
}
typealias HHPhotoPickCallBackBlock = (_ infoDict:Dictionary<String, Any>?, _ isCancel: Bool)->()
import UIKit

class HHPhotoPickManager: NSObject {
    
    static let shareTools = HHPhotoPickManager()
    
    func photoPick(pickerTypes:pickerType, targetVC: UIViewController,photoPickCallBack: @escaping HHPhotoPickCallBackBlock){
        if pickerTypes == .PickerType_Camera {
            if UIImagePickerController.isCameraDeviceAvailable(.rear) && UIImagePickerController.isSourceTypeAvailable(.camera) {
                pickerController.sourceType = .camera
                pickerController.showsCameraControls = true
                let view = UIView()
                view.backgroundColor = UIColor.gray
                pickerController.cameraOverlayView = view
                targetVC.present(pickerController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController.init(title: "注意", message: "相机不可用", preferredStyle: .alert)
                alertController.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
            }
        } else if pickerTypes == .PickerType_Photo {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    pickerController.sourceType = .photoLibrary
                    targetVC.present(pickerController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController.init(title: "注意", message: "相册不可用", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
                }

            }
    }
    
   fileprivate lazy var pickerController:UIImagePickerController = {
        let picker = UIImagePickerController.init()
        picker.delegate = self
        return picker
    }()
    
}


extension HHPhotoPickManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  
    // 选择照片后
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 存储照片
        if info.keys.contains("UIImagePickerControllerMediaMetadata") {
            UIImageWriteToSavedPhotosAlbum(info["UIImagePickerControllerOriginalImage"] as! UIImage, self, nil, nil)
        }
        pickerController.dismiss(animated: true) { 
//            HHPhotoPickCallBackBlock(info, false)
        }
    }

    // 没有选择照片
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        HHPhotoPickCallBackBlock(nil, true)

    }
    
}
