//
//  PError.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-22.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation

enum PError: Error {
    case noConnection
}

extension PError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noConnection: return Constants.noConnection
        }
    }
}
