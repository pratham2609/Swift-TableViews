//
//  Model.swift
//  HotelCodeable
//
//  Created by Pratham on 11/04/24.
//

import UIKit

struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
    static var allTypes: [RoomType] {
        return (
            [
            RoomType(id: 1, name: "Two Queens", shortName: "2Qs", price: 160),
            RoomType(id: 2, name: "One king", shortName: "k", price: 169),
            RoomType(id: 3, name: "Penthouse suite", shortName: "phs", price: 200)
            ]
        )
    }
}
