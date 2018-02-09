//
//  DetailController.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/9/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit
import SwiftyGif

class DetailController: UIViewController, UIGestureRecognizerDelegate {
  weak var cache: ImageCache?
  weak var swiftyGifManager: SwiftyGifManager?
  
  var giphy: GiphyData? {
    didSet {
      layoutCentralView()
      
    }
  }
  
  private func getFittedSize(_ giphy: GiphyData) -> ( width: CGFloat, height: CGFloat ){
    let safeWidth = view.safeAreaLayoutGuide.layoutFrame.size.width
    let safeHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
    let safeRatio = safeWidth/safeHeight
    
    let imageHeight = CGFloat ((giphy.data.image_height as NSString).floatValue)
    let imageWidth = CGFloat ((giphy.data.image_width as NSString).floatValue)
    let imageRatio = imageWidth/imageHeight
    
    var height = safeHeight
    var width = safeWidth
    
    // portrait mode
    if imageRatio >= safeRatio {
      height = safeWidth / imageRatio
    } else {
      width = safeHeight * imageRatio
    }
    
    return (width: width, height: height)
  }
  
  private func layoutCentralView(){
    if let cache = cache, let swiftyGifManager = swiftyGifManager, let giphy = giphy {
      
      let size = getFittedSize(giphy)
      
      view.addSubview(centralView)
      NSLayoutConstraint.activate([
        centralView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        centralView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        centralView.widthAnchor.constraint(equalToConstant: size.width),
        centralView.heightAnchor.constraint(equalToConstant: size.height),
        ])
      centralView.loadImage(url: giphy.data.image_url, cache: cache, swiftyManager: swiftyGifManager)
    }
  }
  
  lazy var centralView: UIImageView = {
    let v = UIImageView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.contentMode = .scaleAspectFit
    v.backgroundColor = UIColor.clear
    return v
  }()
  
  lazy var activityIndicator: UIActivityIndicatorView = {
    let ai = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    return ai
  }()
  
  @objc func handleTap() {
    navigationController?.popViewController(animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.black
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    gesture.numberOfTapsRequired = 1
    view.isUserInteractionEnabled = true
    view.addGestureRecognizer(gesture)
    
    view.addSubview(activityIndicator)
    activityIndicator.center = view.center
    activityIndicator.startAnimating()
  }
}
