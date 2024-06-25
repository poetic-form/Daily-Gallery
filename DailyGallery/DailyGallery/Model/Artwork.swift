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
class Artwork {
    @Attribute(.unique) var id = UUID()
    
    var title: String = ""
    var artDescription: String = ""
    var imageData: Data = Data()
    var date: String = ""
    
    init() { }
}
