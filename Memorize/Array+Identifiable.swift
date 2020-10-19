//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Eli Manjarrez on 10/15/20.
//

import Foundation

extension Array where Element : Identifiable {
    func firstIndex(matching item:Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == item.id {
                return index
            }
        }
        return nil
    }
}
