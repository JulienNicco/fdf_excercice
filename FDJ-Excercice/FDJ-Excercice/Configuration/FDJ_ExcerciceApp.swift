//
//  FDJ_ExcerciceApp.swift
//  FDJ-Excercice
//
//  Created by Julien Nicco on 12/05/2023.
//

import SwiftUI

@main
struct FDJ_ExcerciceApp: App {
    var body: some Scene {
        WindowGroup {
            SelectorView(vm: SelectorViewModel())
        }
    }
}
