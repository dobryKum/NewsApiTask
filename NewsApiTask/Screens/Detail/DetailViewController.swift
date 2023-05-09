//
//  DetailViewController.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 9.05.23.
//

import UIKit
import SwiftUI

final class DetailViewController: UIHostingController<DetailView> {
    // MARK: - Nested Types
    private enum Constants {
        static let screenTitle: String = "Detail Screen"
    }

    // MARK: - Properties
    private let interactor: DetailBusinessLogic
    private let router: DetailRoutingLogic

    // MARK: - UI Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView.autoLayout()
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let subtitileLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView,
                                                       titleLabel,
                                                       subtitileLabel])
        
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView.autoLayout()
    }()
    
    // MARK: - Initialization
    init(rootView: DetailView, interactor: DetailBusinessLogic, router: DetailRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(rootView: rootView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented in DetailViewController")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startSettings()
    }

    // MARK: - Private Methods
    private func startSettings() {
        title = Constants.screenTitle
        view.backgroundColor = .white
       
        requestInitialData()
    }

    // MARK: - Interactor Methods
    private func requestInitialData() {
        interactor.requestInitialData(Detail.Initial.Request())
    }
}

// MARK: - DetailDisplayLogic
extension DetailViewController: DetailDisplayLogic {
    func displayInitialData(_ viewModel: Detail.Initial.ViewModel) {
        let viewModel = DetailViewModel(dto: viewModel)
        viewModel.delegate = self
        rootView.viewModel = viewModel
    }
    
    func displayError(_ viewModel: Detail.Error.ViewModel) {
        let action: (() -> Void) = { [weak self] in
            self?.router.routeToBack()
        }
        
        let alertConfigurationModel = AlertManager.ConfigurationModel(
            title: viewModel.title,
            subtitle: viewModel.subtitle,
            buttonText: viewModel.buttonText,
            action: action
        )
        
        AlertManager.showAlert(with: alertConfigurationModel, from: self)
    }
}

extension DetailViewController: DetailViewDelegate {
    func didSelectButton(_ sender: DetailViewModelProtocol?) {
        guard let url = sender?.url else { return }
        router.routeToBrowser(url: url)
    }
}
