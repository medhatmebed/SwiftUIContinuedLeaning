//
//  LongPressGestureBootcamp.swift
//  SwiftUIContinuedLeaning
//
//  Created by Medhat Mebed on 12/29/23.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State var isCompleted = false
    @State var isSuccess = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isCompleted ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("Click Here!")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, perform: {
                        // at the min duration
                        withAnimation {
                            isSuccess = true
                        }
                        
                    }, onPressingChanged: { isPressing in
                        if isPressing {
                            withAnimation {
                                isCompleted = true
                            }
                        } else {
                            withAnimation {
                                isCompleted = false
                            }
                        }
                    })
            }
        }
    }
}

#Preview {
    LongPressGestureBootcamp()
}
