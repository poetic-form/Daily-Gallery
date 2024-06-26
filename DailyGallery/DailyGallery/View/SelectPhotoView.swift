//
//  CreateView.swift
//  DailyGallery
//
//  Created by Lee Sihyeong on 6/23/24.
//

import SwiftUI
import PhotosUI

struct SelectPhotoView: View {
    @Binding var showCreate: Bool
    
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedImage: UIImage?
    @State var artwork: Artwork = .init()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                } else {
                    Text("Select photo")
                }
                Spacer()
                ZStack(alignment: .topLeading) {
                    PhotosPicker(selection: $selectedPhoto, matching: .all(of: [.images])) {
                        Label(
                            title: { Text("image") },
                            icon: { Image(systemName: "photo") }
                        )
                    }
                    .photosPickerStyle(.inline)
                    .photosPickerDisabledCapabilities([.selectionActions, .search])
                    .frame(height: 400)
                }
            }
            .onChange(of: selectedPhoto) {
                if let newValue = selectedPhoto {
                    Task {
                        if let imageData = try? await newValue.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                            await MainActor.run(body: {
                                selectedImage = image
                                artwork.imageData = imageData
                            })
                        }
                    }
                }
            }
            .navigationTitle("select photo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showCreate = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ArtDescriptionView(artwork: $artwork, isCreate: $showCreate)
                    } label: {
                        Text("Done")
                    }
                    .disabled(selectedPhoto == nil)
                }
            }
        }
    }
}

#Preview {
    SelectPhotoView(showCreate: .constant(true))
}
