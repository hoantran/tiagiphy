//
//  MainController.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit
import SwiftyGif

protocol MainControllerDelegate: class {
  func finalizeSetup()
}

class MainController: UIViewController {
  weak var delegate: MainControllerDelegate?
  
  public var giphyAPIService = GiphyAPIService()
  public var gifManager = SwiftyGifManager(memoryLimit:Constants.gifManagerMemoryLimitInMB)
  public var imageCache = ImageCache()
  
  let semaphore = DispatchSemaphore(value: 1)
  let semaphoreQueue = DispatchQueue.global(qos: .userInitiated)
  private var scrollRequestEnabled = true

  lazy var mainView: UICollectionView = {
    let layout = SwiftyGiphyGridLayout()
    layout.delegate = self
    
    let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    v.translatesAutoresizingMaskIntoConstraints = false
    v.register(GiphyCell.self, forCellWithReuseIdentifier: GiphyCell.cellID)
    v.backgroundColor = UIColor.black
    v.dataSource = self
    v.delegate = self
    v.isHidden = true
    return v
  }()
  
  let activityIndicator: UIActivityIndicatorView = {
    let ai = UIActivityIndicatorView(style: .whiteLarge)
    ai.hidesWhenStopped = true
    return ai
  }()
  
  fileprivate func layoutCollectionView(){
    view.addSubview(mainView)
    NSLayoutConstraint.activate([
      mainView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      mainView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      mainView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
      mainView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
      ])
  }
  
  fileprivate func setupNavBar(){
    let logo = UIImage(named: "giphy_logo_small_dark.png")
    let imageView = UIImageView(image:logo)
    self.navigationItem.titleView = imageView
    navigationController?.navigationBar.barTintColor = UIColor.black
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard giphyAPIService.isReady() else { return }
    guard scrollRequestEnabled else { return }
    
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    
    // this check is just a tad risky when the initial cells do not overfill the screen
    // when that happens, the screen will not scroll and stuck with the initial count of gif's
    if offsetY > contentHeight - (2 * scrollView.frame.size.height) {
      semaphoreQueue.async { [unowned self] in
        self.startActivityIndicator()
        self.semaphore.wait()
        self.scrollRequestEnabled = false
        
        self.scrollDown() { [unowned self] in
          self.scrollRequestEnabled = true
          self.semaphore.signal()
          self.stopActivityIndicator()
        }
      }
    }
  }
  
  fileprivate func scrollDown(completion: @escaping ()->()) {
    let increase = Constants.gifIncrementCount
    let oldCount = giphyAPIService.count
    giphyAPIService.add(increase) { [unowned self] in
      var indexPaths = [IndexPath]()
      for i in 0..<increase {
        let indexPath = IndexPath(item: oldCount + i, section: 0)
        indexPaths.append(indexPath)
      }
      DispatchQueue.main.async { [unowned self] in
        self.mainView.insertItems(at: indexPaths)
      }
      completion()
    }
  }
  
  func startInitialLoad(){
    startActivityIndicator()
    giphyAPIService.start() { [weak self] in
      DispatchQueue.main.async { [weak self] in
        self?.mainView.isHidden = false
        self?.stopActivityIndicator()
        self?.mainView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.black
    
    setupNavBar()
    layoutCollectionView()
    setupActivityIndicator()
    
    self.delegate?.finalizeSetup()
    
    startInitialLoad()
  }
}
