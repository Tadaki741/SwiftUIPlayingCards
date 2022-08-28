/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Your name (e.g. Nguyen Van Minh)
  ID: S3821186
  Created  date: 15/08/2022
  Last modified: 28/08/2022
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

// A view to represent a single card
struct CardView: View {
    
    let card: Card
    let namespace: Namespace.ID
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20,
                             style: .continuous)
                .fill(Color.white)
            RoundedRectangle(cornerRadius: 20,
                             style: .continuous)
                .stroke(.black, lineWidth: 2)
                
            Image(String(card.number)).resizable().frame(width: 80, height: 100)
        }
        .frame(width: 60, height: 80)
        .matchedGeometryEffect(id: "\(card.number)",
                               in: namespace)
        .transition(.scale(scale: 1))
    }
    
}

struct CardView_Previews: PreviewProvider {
    // Create a wrapper view that will let us hold a @Namespace to pass to the view
    struct Wrapper: View {
        @Namespace var animation
        var body: some View {
            CardView(card: Card(number: 1), namespace: animation)
                .padding()
                .background(Color.gray)
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}
