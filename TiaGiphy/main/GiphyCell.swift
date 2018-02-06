//
//  GiphyCell.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

class GiphyCell: UICollectionViewCell {
  static let cellID = "UICollectionViewCell"
  
  var imageURL: String? {
    didSet {
      self.giphyImageView.loadImage(imageURL)
    }
  }
  
  let giphyImageView : UIImageView = {
    let v = UIImageView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.contentMode = .scaleAspectFill
    v.clipsToBounds = true
    return v
  }()
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageURL = nil
    giphyImageView.image = nil
  }
  
  override init(frame: CGRect) {
    super.init(frame: CGRect.zero)
    addSubview(giphyImageView)
    NSLayoutConstraint.activate([
      giphyImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      giphyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      giphyImageView.widthAnchor.constraint(equalTo: widthAnchor),
      giphyImageView.heightAnchor.constraint(equalTo: heightAnchor)
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    // needs more graceful exit
    fatalError("init(coder:) has not been implemented")
  }
}

