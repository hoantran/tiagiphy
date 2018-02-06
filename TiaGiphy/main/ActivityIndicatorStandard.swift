//
//  ActivityIndicatorStandard.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit

extension MainController {
  
  func setupActivityIndicator() {
    activityIndicator.center = view.center
    activityIndicator.frame = view.frame.offsetBy(dx: 0, dy: 200)
    view.addSubview(activityIndicator)
  }
  
  func stopActivityIndicator() {
    DispatchQueue.main.async { [unowned self] in
      self.activityIndicator.stopAnimating()
      self.activityIndicator.isHidden = true
    }
  }
  
  func startActivityIndicator() {
    DispatchQueue.main.async { [unowned self] in
      self.activityIndicator.startAnimating()
      self.activityIndicator.isHidden = false
    }
  }
}

