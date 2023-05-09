//
//  DetailView.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 9.05.23.
//

import SwiftUI

struct DetailView: View {
    
    var viewModel: DetailViewModelProtocol
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 300)
                Text(viewModel.title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                Text(viewModel.subtitle)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                Button(viewModel.buttonText) {
                    viewModel.delegate?.didSelectButton(viewModel)
                }
            }
        }
        .scrollBounceBehavior(.always)
    }
    
}
