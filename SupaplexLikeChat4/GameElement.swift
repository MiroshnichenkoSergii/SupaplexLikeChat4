//
//  GameElement.swift
//  SupaplexLikeChat4
//
//  Created by Sergii Miroshnichenko on 08.09.2023.
//

import UIKit

let numRows = 10
let numColumns = 10
let cellSize: CGFloat = 32.0

enum GameElement: Int {
    case empty = 0
    case player
    case rock
    case enemy

    var color: UIColor {
        switch self {
        case .empty: return .clear
        case .player: return .blue
        case .rock: return .gray
        case .enemy: return .red
        }
    }
}
