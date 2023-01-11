//
//  ToastConfirm.swift
//  stockTrading
//
//  Created by Bob Dai on 5/2/22.
//

import SwiftUI

struct ToastConfirm<Presenting>: View where Presenting: View {
    /// The binding that decides the appropriate drawing in the body.
    @Binding var isShowing: Bool
    /// The view that will be "presenting" this toast
    let presenting: () -> Presenting
    let text: Text

    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                self.presenting()
                if isShowing {
                    VStack {
                        self.text
                    }
                    .frame(width: geometry.size.width / 4 * 3,
                           height: geometry.size.height / 12)
                    .background(.gray)
                    .foregroundColor(.white)
                    .cornerRadius(40)
                    .transition(.opacity)
                    .opacity(self.isShowing ? 1 : 0)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                          withAnimation {
                            self.isShowing = false
                          }
                        }
                    }
                }
            }
        }
        
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, text: Text) -> some View {
        ToastConfirm(isShowing: isShowing,
              presenting: { self },
              text: text)
    }
}

//struct ToastConfirm_Previews: PreviewProvider {
//    static var previews: some View {
//        ToastConfirm(isShowing: true, presenting: <#T##() -> View#>, text: <#T##Text#>)
//    }
//}

