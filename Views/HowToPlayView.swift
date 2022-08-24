//
//  HowToPlayView.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 21/08/2022.
//

import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        
        VStack{
            
            Text("Look at card to evaluate value").bold();
            Text("Special cases are: Ngu Linh(5 cards with oiunt/Xi Ban/Xi Dach")
            Text("If you have special case")
        }
        
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
