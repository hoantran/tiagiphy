//
//  GiphyData.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import Foundation

struct ImageData:Decodable {
  let type: String
  let id: String
  let url: String
  let image_original_url: String
  let image_url: String
  let image_mp4_url: String
  let image_frames: String
  let image_width: String
  let image_height: String
  let fixed_height_downsampled_url: String
  let fixed_height_downsampled_width: String
  let fixed_height_downsampled_height: String
  let fixed_width_downsampled_url: String
  let fixed_width_downsampled_width: String
  let fixed_width_downsampled_height: String
  let fixed_height_small_url: String
  let fixed_height_small_still_url: String
  let fixed_height_small_width: String
  let fixed_height_small_height: String
  let fixed_width_small_url: String
  let fixed_width_small_still_url: String
  let fixed_width_small_width: String
  let fixed_width_small_height: String
  let username: String
  let caption: String
}

struct MetaData: Decodable {
  let status: Int
  let msg: String
  let response_id: String
}

struct GiphyData: Decodable {
  let data: ImageData
  let meta: MetaData
}

