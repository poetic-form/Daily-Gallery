//
//  ArtDescriptionView.swift
//  DailyGallery
//
//  Created by Lee Sihyeong on 6/23/24.
//

import SwiftUI
import SwiftData

struct ArtDescriptionView: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) var modelContext
    @Query var artworks: [Artwork]
    
    @Binding var artwork: Artwork
    @Binding var isCreate: Bool
    
    @State var h: CGFloat = 393
    
    var registerDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: Date())
    }
    
    var body: some View {
        VStack {
            
            VStack {
                Image(uiImage: UIImage(data: artwork.imageData)!)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                
                TextField("Title", text: $artwork.title)
                    .padding(.leading, 13)
                    .padding(.vertical, 7)
                
                Divider()
                
                ZStack(alignment: .topLeading) {
                    VStack {
                        TextEditor(text: $artwork.artDescription)
                            .frame(minHeight: 150, maxHeight: 250)
                            .background(.clear)
                    }
                    
                    if artwork.artDescription.isEmpty {
                        VStack {
                            Text("Description")
                                .opacity(0.25)
                                .padding(.top, 7)
                                .padding(.leading, 4)
                                .allowsHitTesting(false)
                        }
                    }
                }
                .padding(.leading, 7)
                .padding(.trailing, 3)
                Spacer()
            }
            
        }
        .navigationTitle("Description")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    artwork.date = registerDate
                    modelContext.insert(artwork)
                    isCreate = false
                } label: {
                    Text("Register")
                }
                .disabled(artwork.title.isEmpty)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SelectPhotoView(showCreate: .constant(true))
}
