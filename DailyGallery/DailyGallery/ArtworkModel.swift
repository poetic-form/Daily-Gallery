//
//  ArtworkModel.swift
//  DailyGallery
//
//  Created by Lee Sihyeong on 6/22/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class ArtworkModel {
    @Attribute(.unique) var id = UUID()
    
    var title: String
    var explanation: String
    var image: Data
    var number: Int
    var date: String
    
    init(id: UUID = UUID(), title: String, explanation: String, image: Data, number: Int, date: String) {
        self.id = id
        self.title = title
        self.explanation = explanation
        self.image = image
        self.number = number
        self.date = date
    }
}
