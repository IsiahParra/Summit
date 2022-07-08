//
//  DateHelper.swift
//  Summit
//
//  Created by Isiah Parra on 7/7/22.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
