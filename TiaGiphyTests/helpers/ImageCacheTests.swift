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
  var sut: ImageCache?
  
  override func setUp() {
    super.setUp()
    sut = ImageCache()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  // This test should be necessary since Apple should have tested it already
  func testImageCacheCount(){
    XCTAssertEqual(sut?.dict.countLimit, Constants.imageCacheCountLimit)
  }

  // This test should be necessary since Apple should have tested it already
  func testImageCacheCostLimit(){
    XCTAssertEqual(sut?.dict.totalCostLimit, Constants.imageCacheMemoryLimit)
  }

}
