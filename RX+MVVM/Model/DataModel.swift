//
//  DataModel.swift
//  RX+MVVM
//
//  Created by Karem on 8/16/20.
//  Copyright © 2020 Karem. All rights reserved.
//


//   let dataModel = try? newJSONDecoder().decode(DataModel.self, from: jsonData)

import Foundation

// MARK: - DataModelElement
struct DataModel: Codable {
    let userID:Int
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}

//typealias DataModel = [DataModel]

//decoding data
extension DataModel {
    init?(data: Data){
        guard let data = try? JSONDecoder().decode(DataModel.self,from:data)
            else {return nil}
        self = data
    }
    
}
