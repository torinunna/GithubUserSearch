//
//  UserProfileView.swift
//  GithubUserSearch
//
//  Created by YUJIN KWON on 2023/06/23.
//

import SwiftUI
import Kingfisher

struct UserProfileView: View {
    
    @StateObject var viewModel: UserProfileViewModel
        
    var body: some View {
        VStack(spacing: 15) {
            KFImage(viewModel.imageURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160, height: 169)
                .background(.gray)
                .cornerRadius(80)
            
            Text(viewModel.name)
            Text(viewModel.login)
            Text(viewModel.followers)
            Text(viewModel.following)
        }.onAppear {
            let id = viewModel.loginID
            viewModel.search(keyword: id)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(viewModel: UserProfileViewModel(network: NetworkService(configuration: .default), loginID: "torinunna"))
    }
}
