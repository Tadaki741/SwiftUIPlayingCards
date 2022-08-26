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
            Text("GAME RULES");
        }
        
        VStack{
            Text("Stage 1: When game start").bold()
            Text("User and computer will be given 2 cards, if either you or computer hit the special case, or Quach, you need to press deal")
            
            Group{
                Text("Stage 2: After pulling more than 2 cards").bold()
                Text("To win, you need to be higher than computer in temrs of card value");
                Text("The card value will have normal number case and special case");
                Text("If cards hits value greater than 21, it is considered a straight defeat")
            }
            
            
            Group{
                Text("Special case:").bold();
                List{
                    Text("Double Ace, also called Xi Ban, highest value")
                    Text("One Ace and one (king or queen or jack), also called Xi Dach, 2nd highest")
                    Text("If you have 5 cards and their value smaller than 21, it is called Ngu Linh, 3rd highest");
                    Text("The rest are cards that based on numbers value")
                    Text("If cards exceed 21 points, it is called Quach, means lose")
                    
                }
               
            }
            Spacer();
            Text("Card value").bold();
            Text("Ace = 10 or 1")
            Text("Queen or Jack or King = 10")
            Text("Numbers card = self")
            
        }
        
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
