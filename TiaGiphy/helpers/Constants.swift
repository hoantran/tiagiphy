//
//  Constants.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

struct Constants {
  static let initialGifCount = 12
  static let gifIncrementCount = 4 // raise this number for faster scrolling down
  
  // ImageCache
  static let imageCacheCountLimit = 50
  static let imageCacheMemoryLimit = 20*1024*1024 // maximum memory: 20 MB
  
  // SwiftyGifManager
  static let gifManagerMemoryLimitInMB = 50
  
  // Giphy Service
  static let giphyRandonEndpointURL = "https://api.giphy.com/v1/gifs/random?api_key=OsXGwLIpI3MamyPgIh9GmOiUvsLGsRq0&tag=&rating=G"
  
  // Background color placeholders
  static let bkgColors = [UIColor(hex: "0x595FFF"), UIColor(hex: "0x69FFFA"), UIColor(hex: "0xDCFF96"), UIColor(hex: "0xFFB0AD"), UIColor(hex: "0xFF87FF")]

}
  
