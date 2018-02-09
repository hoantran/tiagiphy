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
    return giphyAPIService.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiphyCell.cellID, for: indexPath) as! GiphyCell
    cell.backgroundColor = Constants.bkgColors[indexPath.item % Constants.bkgColors.count]
    if let giphy = giphyAPIService.get(indexPath.item) {
      cell.giphyImageView.loadImage(url: giphy.data.fixed_height_small_url, cache: imageCache, swiftyManager: gifManager)
    }
    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
}

