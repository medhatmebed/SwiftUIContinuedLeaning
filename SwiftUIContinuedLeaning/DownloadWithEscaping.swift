//
//  DownloadWithEscaping.swift
//  SwiftUIContinuedLeaning
//
//  Created by Medhat Mebed on 12/29/23.
//

import SwiftUI

struct PostModel: Codable, Identifiable {
    let userId, id: Int
    let title, body: String

}

class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts = [PostModel]()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromUrl: url) { returnedData in
            if let data = returnedData {
                guard let newPost = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
           //     DispatchQueue.main.async { [weak self] in
                    self.posts.append(contentsOf: newPost)
         //       }
            } else {
                print("No data returned")
            }
        }
    }
    
    func downloadData(fromUrl url: URL, completionHandler: @escaping (_ data: Data?)->()) {
        URLSession.shared.dataTask(with: url) { data, response , error in
            guard let data = data,
                  error  == nil,
                  let response = response as? HTTPURLResponse,
                  200..<300 ~= response.statusCode
            else {
                print("no data")
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }.resume()
    }
    
    
}

struct DownloadWithEscaping: View {
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    DownloadWithEscaping()
}
