//
//  TypealiasBootcamp.swift
//  SwiftUIContinuedLeaning
//
//  Created by Medhat Mebed on 12/29/23.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

/// typealias is creating a new name for existing type
typealias TVModel = MovieModel

struct TypealiasBootcamp: View {
    
    @State var item = TVModel(title: "TV MODEL", director: "MEDHAT", count: 5)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

#Preview {
    TypealiasBootcamp()
}
