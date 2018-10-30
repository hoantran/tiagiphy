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

// https://gist.github.com/steipete/1144242
extension UIImage {
  
  func forceLoad() -> UIImage {
    guard let imageRef = self.cgImage else {
      return self //failed
    }
    let width = imageRef.width
    let height = imageRef.height
    let colourSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo: UInt32 = CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
    guard let imageContext = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colourSpace, bitmapInfo: bitmapInfo) else {
      return self //failed
    }
    let rect = CGRect(x: 0, y: 0, width: width, height: height)
    imageContext.draw(imageRef, in: rect)
    if let outputImage = imageContext.makeImage() {
//      let cachedImage = UIImage(cgImage: outputImage)
      let cachedImage = UIImage(cgImage: outputImage, scale: scale, orientation: imageOrientation)
      return cachedImage
    }
    return self //failed
  }
  
  
}


// idea from Brian Voong's game of chats
extension UIImageView {
  
  func loadImage(url: String?, cache: ImageCache, swiftyManager: SwiftyGifManager) {
    if let gifURL = url, let urlComponents = URLComponents(string: gifURL) {
      if let cachedImage = cache.dict.object(forKey: gifURL as NSString) {
        DispatchQueue.main.async { [unowned self] in
          self.setGifImage(cachedImage, manager: swiftyManager)
        }
        return
      }
      
      let session = URLSession(configuration: .default)
      guard let urlSession = urlComponents.url else { return }
      
      let datatask = session.dataTask(with: urlSession) { (data, response, error) in
        if error == nil {
          let downloadedImage = UIImage(gifData: data!)
          let decodedImage = downloadedImage.forceLoad()
          cache.dict.setObject(decodedImage, forKey: gifURL as NSString)
//          cache.dict.setObject(downloadedImage, forKey: gifURL as NSString)
          DispatchQueue.main.async { [unowned self] in
            self.setGifImage(decodedImage, manager: swiftyManager)
//            self.setGifImage(downloadedImage, manager: swiftyManager)
          }
        } else {
          print(error!.localizedDescription)
        }
      }
      datatask.resume()
    }
  }
  
}

