//
//  DetailViewModel.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 9.05.23.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    func didSelectButton(_ sender: DetailViewModelProtocol?)
}

protocol DetailViewModelProtocol {
    var delegate: DetailViewDelegate? { get set }
    var title: String { get }
    var subtitle: String { get }
    var image: UIImage { get }
    var buttonText: String { get }
    var url: URL? { get }
}

final class DetailViewModel: DetailViewModelProtocol {
    var delegate: DetailViewDelegate?
    @Published private(set) var title: String
    @Published private(set) var subtitle: String
    @Published private(set) var image: UIImage
    @Published private(set) var buttonText: String
    private(set) var url: URL?
    
    init(title: String = .empty,
         subtitle: String = .empty,
         image: UIImage = UIImage(),
         buttonText: String = .empty,
         url: URL? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.buttonText = buttonText
        self.url = url
    }
    
    init(dto: Detail.Initial.ViewModel) {
        self.title = dto.title
        self.subtitle = dto.subtitle ?? .empty
        self.image = dto.image
        self.url = dto.url
        self.buttonText = "Open In Browser"
    }
}
