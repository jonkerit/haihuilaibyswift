//
//  HHHomeController.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/24.
//  Copyright © 2017年 haihuilai. All rights reserved.
//

import UIKit

private let reuseIdentifier = "HHHomeCell"

class HHHomeController: UICollectionViewController {
    
    fileprivate var dataArray:[HHHomeNoticeModel]?
    
    init() {
        let space = (SCREEN_WIDTH - 70*3)/4
        let layOut = UICollectionViewFlowLayout.init()
        layOut.itemSize = CGSize(width: 70,height: 100)
        layOut.minimumLineSpacing = space
        layOut.minimumInteritemSpacing = space
        layOut.sectionInset = UIEdgeInsetsMake(space, space, 0, space)
        layOut.scrollDirection = .vertical
        super.init(collectionViewLayout: layOut)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = HHGRAYCOLOR()
        collectionView?.register(HHHomeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        setRedPoint()
    }
    
    private func setRedPoint(){
        HHProgressHUD().showHUDAddedTo(title: nil, isImage: true, boardView: HHKeyWindow, animated: true)
        HHNetworkClass().getHomeList(parameter: nil) { (response, error) in
            HHProgressHUD().hideHUDForView(boardView: HHKeyWindow, animated: true)
            if response != nil{
                self.dataArray = response as! [HHHomeNoticeModel]?
                self.collectionView?.reloadData()
            }else{
                HHProgressHUD().showHUDAddedTo(title: "加载失败", isImage: false, isDisappear: true, boardView: HHKeyWindow, animated: true)
            }
        }
    }
}

extension HHHomeController {

    // MARK: UICollectionViewDataSource、 UICollectionViewDelegate
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HHHomeCell
        cell.imageView.image = UIImage(named: (self.dataArray?[indexPath.row].name!)!)
        
        return cell
    }

}
