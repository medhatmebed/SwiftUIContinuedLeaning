//
//  EscapingBootcamp.swift
//  SwiftUIContinuedLeaning
//
//  Created by Medhat Mebed on 12/31/23.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var text = "Hello"
    
    func getData() {
       // text = downloadData()
        downloadData2 { [weak self] returnedData in
            self?.text = returnedData
        }
    }
    func downloadData() -> String {
        return "New Data!"
    }
    
    func downloadData2(completion: @escaping (String) -> ()) {
     //   completion("NEW DATA2")
        DispatchQueue.main.async {
            completion("NEW DATA2")
        }
    }
}

struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingViewModel()
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingBootcamp()
}
