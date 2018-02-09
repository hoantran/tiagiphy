//
//  MainControllerViewDelegate.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/9/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

extension MainController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let controller = DetailController()
    controller.swiftyGifManager = gifManager
    controller.cache = imageCache
    controller.giphy = giphyAPIService.get(indexPath.item)
    
    
    let cancelBtn = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    self.navigationItem.backBarButtonItem = cancelBtn
    
    self.navigationController?.navigationBar.barTintColor = UIColor.black
    self.navigationController?.navigationBar.tintColor = UIColor.white
    
    self.navigationController?.pushViewController(controller, animated: true)
  }
  
}
