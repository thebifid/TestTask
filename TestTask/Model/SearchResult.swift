//
//  SearchResult.swift
//  TestTask
//
//  Created by Vasiliy Matveev on 30.06.2020.
//  Copyright © 2020 Vasiliy Matveev. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let images_results: [Image]
}

struct Image: Decodable {
    let original: String?
}
