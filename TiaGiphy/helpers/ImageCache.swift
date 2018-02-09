//
//  ImageCache.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/7/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

// Since NSCache has buffer limit built-in,
// there's no need for a more complicated structure such as circular buffer
// to limit the amount of memory taken by the cache

import UIKit

class ImageCache {
  
  let dict: NSCache<NSString, UIImage> = {
    let cache = NSCache<NSString, UIImage>()
    cache.name = "GiphyImageCache"
    cache.countLimit = Constants.imageCacheCountLimit
    cache.totalCostLimit = Constants.imageCacheMemoryLimit
    return cache
  }()
  
}
