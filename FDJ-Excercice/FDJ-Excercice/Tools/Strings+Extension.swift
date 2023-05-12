//
//  Strings+Extension.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import Foundation

extension String {
    func getLocal() -> String {
        return NSLocalizedString(self, comment:"")
    }
}
