//
//  DailyGalleryApp.swift
//  DailyGallery
//
//  Created by Lee Sihyeong on 6/22/24.
//

import SwiftUI
import SwiftData

@main
struct DailyGalleryApp: App {
    var modelContainer: ModelContainer = {
            let schema = Schema([Artwork.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(modelContainer)
        }
    }
}
