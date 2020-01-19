//
//  Endpoint.swift
//  National Parks
//
//  Created by Will Said on 1/19/20.
//  Copyright © 2020 Will Said. All rights reserved.
//

import Foundation

// See https://github.com/mkoohang/national-parks-api
struct Endpoint {
    var url: String

    private static let base = Endpoint(url: "https://powerful-wildwood-07865.herokuapp.com")
    static let registration = Endpoint(url: base.url + "/rest/register")
    static let login        = Endpoint(url: base.url + "/rest/login")
}
