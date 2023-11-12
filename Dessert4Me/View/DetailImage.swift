//
//  DetailImage.swift
//  Dessert4Me
//
//  Created by Benjamin Simpson on 11/10/23.
//

import SwiftUI
import Combine

class DetailImage: ObservableObject {
    
    @Published var image: UIImage?
    private var urlString: String
    private var cancellable: AnyCancellable?

    init(urlString: String) {
        self.urlString = urlString
        loadImage()
    }

    func loadImage() {
        guard let url = URL(string: urlString) else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    deinit {
        cancellable?.cancel()
    }
}
