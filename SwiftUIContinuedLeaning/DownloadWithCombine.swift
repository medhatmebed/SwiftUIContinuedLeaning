//
//  DownloadWithCombine.swift
//  SwiftUIContinuedLeaning
//
//  Created by Medhat Mebed on 12/30/23.
//

import SwiftUI
import Combine

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts = [PostModel]()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // combine blueprint
        /*
         1. create the publisher
         2. subscribe publisher on a background thread
         3. recieve on the main thread
         4. tryMap "check the data is good"
         5. decode "decode the data into related data model"
         6. sink "put the item into our app"
         7. store (cancel subscription if needed)
        */
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
//            .tryMap { (data, response) -> Data in
//                guard let response = response as? HTTPURLResponse,
//                      200..<300 ~= response.statusCode
//                else { throw URLError(.badServerResponse) }
//                return data
//            }
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("FINISHED")
                case .failure(let error):
                    print("there was an error: \(error)")
                }
            } receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)

        
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              200..<300 ~= response.statusCode
        else { throw URLError(.badServerResponse) }
        return output.data
    }
    
}

struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.title)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    DownloadWithCombine()
}
