//
//  GiphyAPIService.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import Foundation

class GiphyAPIService {
  fileprivate var gifInfoSet = [GiphyData]()
  fileprivate var isFirstSetReady = false
  fileprivate var order = 0
  
  func start(_ completion: @escaping ()->()) {
    add(Constants.initialGifCount) { [weak self] in
      self?.isFirstSetReady = true
      completion()
    }
  }
  
  // should put in a limit of "increase" or
  // devise a simple algorithm to limit the number URLSession threads, when
  // "increase" is a very large number, because
  // the for loop would spin up the number of URLSession threads equaled to "increase"
  func add(_ increase: Int, completion: @escaping ()->()) {
    var addedGifSet = [GiphyData]()
    
    for _ in 0..<increase {
      fetch() { [weak self] giphy in
        if let giphy = giphy {
          addedGifSet.append(giphy)
        }
        
        // if there's a network problem, it'd be a long wait
        if addedGifSet.count == increase {
          self?.gifInfoSet.append(contentsOf: addedGifSet)
          completion()
        }
      }
    }
  }
  
  func fetch(_ completion: @escaping (GiphyData?)->Void) {
    guard let url = URL(string: Constants.giphyRandonEndpointURL) else {
      print("ERR: Invalid giphy URL")
      completion(nil)
      return
    }
    
    // URLSession does not seem to retry when Internet connection goes from OFF to ON
    // Perhaps, AlamoFire library does
    let mine = order
    order += 1
    
    print("TASK [\(mine)] >> started")
    URLSession.shared.dataTask(with: url) { data, response, err in
      print("TASK [\(mine)] << FINISHED")
      
      guard let data = data else {
        print("ERR: Invalid giphy URL")
        completion(nil)
        return
      }
      
      do {
        let giphy = try JSONDecoder().decode(GiphyData.self, from: data)
        completion(giphy)
        return
      } catch let jsonErr {
        print("ERR: can not serialize json", jsonErr)
      }
      }.resume()
  }
  
  
  func isReady()->Bool {
    return isFirstSetReady
  }
  
  func get(_ index: Int) -> GiphyData? {
    if !isFirstSetReady || index < 0 || gifInfoSet.count == 0 {
      return nil
    }
    return gifInfoSet[index % gifInfoSet.count]
  }
  
  public var count: Int {
    return gifInfoSet.count
  }
  
}

