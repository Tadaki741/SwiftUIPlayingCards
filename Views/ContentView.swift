//
//  ContentView.swift
//  SwiftUIPlayingCards
//
//  Created by Chris Mash on 15/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    private var gameState = GameState()
    private let roundRect = RoundedRectangle(cornerRadius: 20)
    @Namespace private var animation
    
    
    //Match decision side
    //User deal and computer deal will end the match
    @State private var computerDeal: Bool = false;
    @State private var userDeal:Bool = false;
    
    
    @State private var computerTurn: Bool = false;
    @State private var userTurn: Bool = false;
    
    
    @State private var userQuitMatch: Bool = false;
    @State private var userPoint: String = "0";
    @State private var computerPoint: String = "0";
    
    var body: some View {
        
        ZStack{
            
            VStack(spacing:0) {
                Color.yellow
                Color.purple
            }.onAppear(){
                //Calculate user's point and computer point
                userPoint = gameState.hands[1].calculateTotalPointOfCards();
                computerPoint = gameState.hands[0].calculateTotalPointOfCards();
            }
            
            ZStack{
                VStack {
                    Spacer();
                    //MARK: Master Deck on the top
                    DeckView(deck: gameState.deck,namespace: animation)
                    Spacer();
                    
                    //MARK: Computer side is in the middle, User side is on the bottom
                    // Draw each player's hand of cards, computer is at index 0 and user is at index 1
                    ForEach(gameState.hands) { hand in
                        
                        VStack{
                            
                            HStack {

                                HandView(hand: hand,namespace: animation)
                                
                            }.padding()
                            
                            //Options for the user
                            if(hand.type == "user"){
                                Text("User point: \(userPoint)")
                                Button("Pick more"){
                                    //User will pick
                                    addCard(to: hand)
                                    //Computer will pick the next card
                                    addCard(to: gameState.hands[0])
                                    //Update the user's point
                                    userPoint = gameState.hands[1].calculateTotalPointOfCards()
                                    //Update computer's point
                                    computerPoint = gameState.hands[0].calculateTotalPointOfCards()
                                }.frame(width: 90, height: 40)
                                    .background(roundRect.fill(Color.orange))
                                    .overlay(roundRect.stroke())
                                
                                
                                
                                
                                Button("Deal"){
                                    userDealCard()
                                }.frame(width: 90, height: 40)
                                    .background(roundRect.fill(Color.orange))
                                    .overlay(roundRect.stroke())
                                
                                
                                
                                
                            }
                            else if(hand.type == "computer"){
                                Text("Computer point: \(computerPoint)")
                            }
                            
                        }
                        
                        Spacer();
                        
                    }
                    
        
                    Button("Quit"){
                        print("User quit match !")
                        userQuitMatch = true;
                    }
                    Spacer();
                    
                }
            }
            
            
        }.ignoresSafeArea()
        
    }
    
    //MARK: Game main function
    private func addCard(to hand: Hand) {
        withAnimation {
            guard let card = gameState.deck.cards.popLast() else {
                print("Deck is empty!")
                return
            }
            
            hand.cards.append(card)
            hand.getHandTotalCard()
        }
    }
    
    //This function is no longer in use, but i want to keep it
    private func remove(card: Card, from hand: Hand) {
        withAnimation {
            // Put the card back in the deck
            guard let index = hand.cards.firstIndex(of: card) else {
                fatalError("Failed to find tapped card in hand")
            }
            
            hand.cards.remove(at: index)
            gameState.deck.cards.append(card)
        }
    }
    
    //MARK: Function used for user
    private func userDealCard(){
        userDeal = true;
        //If computer is not deal yet, we will let it continue to play
        if(computerDeal != true && userDeal == true){
            AIPickDecision();
            return;
        }
        else if(userDeal == true && computerDeal == true){
            //End the match, find the winner
        }
        //Now we will calculate the user's points and then compare it with the computer's point
        
        //If the user's point is higher than the computer then the user will win the match
        
        //We will keep gambling until we ran out of money
    }
    
    //MARK: Function used for computer, Computer moves including, pick more, stop picking , deal
    public func AIPickDecision(){
        func pickMoreCard(){
            
        }
        
        func stopPicking(){
            
        }
        
        func deal () {
            
        }
    }
   
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
