//
//  SwiftyGiphyGridLayoutDelegateImpl.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

extension MainController: SwiftyGiphyGridLayoutDelegate {
  func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
    if let giphy = giphyAPIService.get(indexPath.item) {
      if let imageHeight = Int(giphy.data.image_height), let imageWidth = Int(giphy.data.image_width) {
        let width = getCellWidth()
        let height = width * ( (CGFloat)(imageHeight) / (CGFloat)(imageWidth) )
        return height
      } else {
        print("ERR: can not get image height")
        return 0
      }
    } else {
      print("ERR: can not get image data")
      return 0
    }
  }
  
  func getCellWidth()->CGFloat {
    return (view.frame.width - 10 - 10 - 5)/2
  }
  
}

