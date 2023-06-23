//
//  UserProfileView.swift
//  GithubUserSearch
//
//  Created by YUJIN KWON on 2023/06/23.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image("")
                .frame(width: 160, height: 169)
                .background(.gray)
                .cornerRadius(80)
            
            Text("name")
            Text("login ID")
            Text("followers")
            Text("following")
            
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
