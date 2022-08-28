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

// A view to represent the cards in a hand
struct HandView: View {
    
    @ObservedObject var hand: Hand
    let namespace: Namespace.ID
    
    var body: some View {
        HStack {
            ForEach(hand.cards) { card in
                CardView(card: card, namespace: namespace)
            }
        }
    }
    
}

struct HandView_Previews: PreviewProvider {
    // Create a wrapper view that will let us hold a @Namespace to pass to the view
    struct Wrapper: View {
        @Namespace var namespace
        
        var hand: Hand {
            let hand = Hand()
            hand.cards.append(contentsOf: [
                Card(number: 1),
                Card(number: 2)
            ])
            return hand
        }
        
        var body: some View {
            HandView(hand: hand,namespace: namespace)
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}
