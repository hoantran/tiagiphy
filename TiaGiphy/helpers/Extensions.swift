//
//  Extensions.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit
import SwiftyGif

extension UIColor {
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
  
  // https://crunchybagel.com/working-with-hex-colors-in-swift-3/
  convenience init(hex: String) {
    let scanner = Scanner(string: hex)
    scanner.scanLocation = 0
    
    var rgbValue: UInt64 = 0
    
    if !scanner.scanHexInt64(&rgbValue) {
      print("Could not convert the value [\(hex)]")
    }
    
    let r = (rgbValue & 0xff0000) >> 16
    let g = (rgbValue & 0xff00) >> 8
    let b = rgbValue & 0xff
    
    self.init(
      red: CGFloat(r) / 0xff,
      green: CGFloat(g) / 0xff,
      blue: CGFloat(b) / 0xff, alpha: 1
    )
  }
}

// BRAIN-DAMAGE: need to construct a manager that limits the amount of memory for this app.
// maybe a circular buffer would suffice
let imageCache = NSCache<NSString,UIImage>()

// idea from Brian Voong's game of chats
extension UIImageView {
  
  func loadImage(_ urlStr: String?) {
    if let profileURL = urlStr, let urlComponents = URLComponents(string: profileURL) {
      if let cachedImage = imageCache.object(forKey: profileURL as NSString) {
        DispatchQueue.main.async { [unowned self] in
          self.image = cachedImage
        }
        return
      }
      
      let session = URLSession(configuration: .default)
      guard let url = urlComponents.url else { return }
      
      let datatask = session.dataTask(with: url) { (data, response, error) in
        if error == nil {
          if let downloadedImage = UIImage(data: data!) {
            imageCache.setObject(downloadedImage, forKey: profileURL as NSString)
            DispatchQueue.main.async { [unowned self] in
              self.image = downloadedImage
            }
          }
        } else {
          print(error!.localizedDescription)
        }
      }
      datatask.resume()
    }
  }
  
  func loadImage(_ urlStr: String?, _ mgr: SwiftyGifManager) {
    if let profileURL = urlStr, let urlComponents = URLComponents(string: profileURL) {
      if let cachedImage = imageCache.object(forKey: profileURL as NSString) {
        DispatchQueue.main.async { [unowned self] in
          self.setGifImage(cachedImage)
        }
        return
      }
      
      let session = URLSession(configuration: .default)
      guard let url = urlComponents.url else { return }
      
      let datatask = session.dataTask(with: url) { (data, response, error) in
        if error == nil {
          let downloadedImage = UIImage(gifData: data!)
          imageCache.setObject(downloadedImage, forKey: profileURL as NSString)
          DispatchQueue.main.async { [unowned self] in
            self.setGifImage(downloadedImage)
          }
        } else {
          print(error!.localizedDescription)
        }
      }
      datatask.resume()
    }
  }
  
}

