//
//  DetailView.swift
//  DailyGallery
//
//  Created by Lee Sihyeong on 6/26/24.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @Query var artworks: [Artwork]
    
    @State var id: UUID
    
    var body: some View {
        NavigationStack {
            TabView(selection: $id) {
                ForEach(Array(zip(artworks.indices, artworks)), id: \.0) { index, item in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("NO.\(index + 1)")
                                .padding(.leading, 15)
                            Spacer()
                            Text(item.date)
                                .padding(.trailing, 15)
                        }
                        Image(uiImage: UIImage(data: item.imageData)!)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                        Text(item.title)
                        Text(item.artDescription)
                        Spacer()
                    }
                    .tag(item.id)
                    .navigationTitle(item.title)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                    }
                }
            }
        }
    }
}

//#Preview {
//    DetailView()
//}
