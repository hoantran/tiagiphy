//
//  ImageCacheTests.swift
//  TiaGiphyTests
//
//  Created by Hoan Tran on 2/7/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import XCTest
@testable import TiaGiphy

class ImageCacheTests: XCTestCase {
  var evictedObj: Any?
  
  override func setUp() {
    super.setUp()
    evictedObj = nil
  }
  
  override func tearDown() {
    evictedObj = nil
    super.tearDown()
  }

  // This test should be necessary since Apple should have tested it already
  func testImageCacheCount(){
    XCTAssertEqual(ImageCache.shared.countLimit, Constants.imageCacheCountLimit)
  }
  
  // This test should be necessary since Apple should have tested it already
  func testImageCacheCostLimit(){
    XCTAssertEqual(ImageCache.shared.totalCostLimit, Constants.imageCacheMemoryLimit)
  }

}
