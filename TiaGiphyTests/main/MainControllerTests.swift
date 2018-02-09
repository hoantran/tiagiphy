//
//  MainControllerTests.swift
//  TiaGiphyTests
//
//  Created by Hoan Tran on 2/8/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import XCTest
@testable import TiaGiphy

class MainControllerTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testMainViewAfterViewLoadNotNil(){
    let sut = MainController()
    sut.loadViewIfNeeded()
    XCTAssertNotNil(sut.mainView)
  }
  
  func testMainViewSectionCountAsOne(){
    let sut = MainController()
    sut.loadViewIfNeeded()
    sleep(2)
    let itemCount = sut.giphyAPIService.count
    XCTAssertEqual(itemCount, Constants.initialGifCount)
  }
}
