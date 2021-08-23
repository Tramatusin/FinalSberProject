//
//  NetworkErrors.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 22.08.2021.
//

import Foundation

enum NetworkErrors: Error{
    case warningWithParseJson(message: String)
    case warningResponse(message: String)
    case warningRequest(message: String)
}
