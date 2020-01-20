//
//  Filter.swift
//  National Parks
//
//  Created by Will Said on 1/20/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import Foundation

enum Filter: String {
    case Favorites, All
    
    func opposite() -> Filter {
        switch self {
        case .All: return .Favorites
        case.Favorites: return .All
        }
    }
}
