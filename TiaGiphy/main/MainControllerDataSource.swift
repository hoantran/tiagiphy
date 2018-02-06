//
//  MainControllerDataSource.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

extension MainController: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return numberOfItemsPerSection
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiphyCell.cellID, for: indexPath) as! GiphyCell
    cell.backgroundColor = bkgColors[indexPath.item % bkgColors.count]
    if let giphy = getGiphy(indexPath.item) {
      cell.giphyImageView.loadImage(giphy.data.fixed_height_small_url, gifManager)
      //      cell.imageURL = giphy.data.image_url
    }
    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  internal func getGiphy(_ item: Int) -> GiphyData? {
    if giphyAPIService.isReady() {
      if let giphy = giphyAPIService.get(item) {
        return giphy
      } else {
        print("ERR: can not get Giphy image data")
        return nil
      }
    } else {
      print("INFO: Waiting for initial images to load...")
      return nil
    }
  }
}

