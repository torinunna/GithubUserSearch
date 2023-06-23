//
//  UserProfileView.swift
//  GithubUserSearch
//
//  Created by YUJIN KWON on 2023/06/23.
//

import SwiftUI

struct UserProfileView: View {
    var userProfile: UserProfile
        
    var body: some View {
        VStack(spacing: 15) {
            Image("")
                .frame(width: 160, height: 169)
                .background(.gray)
                .cornerRadius(80)
            
            Text(userProfile.name)
            Text(userProfile.login)
            Text("\(userProfile.followers)")
            Text("\(userProfile.following)")
            
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userProfile: UserProfile.mock)
    }
}
