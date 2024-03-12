//
//  SectionModel.swift
//  spotify
//
//  Created by Диас Мухамедрахимов on 03.03.2024.
//

import Foundation

struct Section {
    let title: String
    let rows: [Row]
}

struct Row {
    let title: String
    let handler: () -> Void
}
