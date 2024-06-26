//
//  ContentView.swift
//  DailyGallery
//
//  Created by Lee Sihyeong on 6/22/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) var modelContext
    @Query var artworks: [Artwork]
    
    @State var isCreate: Bool = false
    @State var artwork: Artwork = .init()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(Array(zip(artworks.indices, artworks)), id: \.0) { index, item in
                        VStack {
                            Image(uiImage: UIImage(data: item.imageData)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipped()
                            Text("NO.\(index + 1)")
                            Text(item.title)
                        }
                        .onTapGesture {
                            artwork = item
                            modelContext.delete(artwork)
                        }
                    }
                }
                .navigationTitle("Daily Gallery")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isCreate.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isCreate, content: {
            SelectPhotoView(isCreate: $isCreate)
        })
    }
}

#Preview {
    MainView()
}
