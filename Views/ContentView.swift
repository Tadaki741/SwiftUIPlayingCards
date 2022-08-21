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

    
    
    @State private var userQuitMatch: Bool = false;
    @State private var userPoint: String = "0";
    @State private var userMoney: String = "0";
    @State private var computerPoint: String = "0";
    @State private var computerMoney: String = "0";
    @State private var bothSideDeal: Bool = false;
    
    var body: some View {
        
        ZStack{
            
            VStack(spacing:0) {
                Color.yellow
                Color.purple
            }.onAppear(){
                //Calculate user's point and computer point before hand
                userPoint = gameState.hands[1].calculateTotalPointOfCards();
                computerPoint = gameState.hands[0].calculateTotalPointOfCards();
            }
            
            ZStack{
                VStack {
                    Spacer();
                    //MARK: Master Deck on the top
                    DeckView(deck: gameState.deck,namespace: animation).blur(radius: 20, opaque: true)
                    Spacer();
                    
                    //MARK: Computer side is in the middle, User side is on the bottom
                    // Draw each player's hand of cards, computer is at index 0 and user is at index 1
                    ForEach(gameState.hands) { hand in
                        
                        VStack{
                            
                            HStack {
                                if(hand.type == "computer"){
                                    //Use ternary operator to identify when the match will end, then we will unveil the computer cards
                                    HandView(hand: hand,namespace: animation).blur(radius: bothSideDeal ? 0 : 20, opaque: true);
                                }
                                else if(hand.type == "user") {
                                    HandView(hand: hand,namespace: animation)
                                }
                                
                                
                            }.padding()
                            
                            //Options for the user
                            if(hand.type == "user"){
                                Text("User point: \(userPoint)").font(.system(size: 30, weight: .heavy, design: .default))
                                Button("Pick more"){
                                    //Action from user
                                    UserPickDecisionPickMore();
                                    
                                    //Then, its turn for computer to move
                                    AIPickDecision();
                                    
                                    summarizeGameState();
                                    
                                    
                                }.frame(width: 90, height: 40)
                                    .background(roundRect.fill(Color.orange))
                                    .overlay(roundRect.stroke())
                                
                                
                                
                                
                                Button("Deal"){
                                    userDealCard();
                                    summarizeGameState();
                                    
                                    
                                }.frame(width: 90, height: 40)
                                    .background(roundRect.fill(Color.orange))
                                    .overlay(roundRect.stroke())
                                
                                
                                
                                
                            }
                            else if(hand.type == "computer"){
                                Text("Computer point: \(computerPoint)").blur(radius: bothSideDeal ? 0 : 20, opaque: true).font(.system(size: 30, weight: .heavy, design: .default))
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
    
    //MARK: Game main functions
    private func addCard(to hand: Hand) {
        withAnimation {
            guard let card = gameState.deck.cards.popLast() else {
                print("Deck is empty!")
                return
            }
            
            hand.cards.append(card)
        }
    }
    
    //This function has no usage but i wanna keep it
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
            bothSideDeal = true;
            evaluateWinner();
        }
    }
    
    //MARK: Function used for computer, Computer moves including, pick more, stop picking , deal
    public func AIPickDecision(){
        
        //----------------------AI MOVES ----------------
        func pickMoreCard(){
            //Computer will pick the next card
            addCard(to: gameState.hands[0])
            //Update computer's point
            computerPoint = gameState.hands[0].calculateTotalPointOfCards()
        }
        
        func stopPicking(){
            return;
        }
        
        func deal () {
            computerDeal = true;
            if(userDeal && computerDeal){
                bothSideDeal = true;
            }
            else {
                return;
            }
        }
        //----------------------AI MOVES--------------------
        
        
        //MARK: AI LOGIC
        //Here the AI will check for the value of its card, we just make a simple rule, the AI will aim to score between 15 and 21
        //If the AI card hits special strong case, or Quach case, it has to deal immediately
        if(computerPoint == "Xi Dach" || computerPoint == "Xi Ban" || computerPoint == "Quach"){
            //Make a move
            deal();
            return;
        }
        //else it will keep picking
        else{
            //until it hits the range 15...21 or try to get Ngu Linh
            let AIcardCounter: Int = gameState.hands[0].cards.count;
            let AIcardPointToInt: Int = Int(computerPoint) ?? 0;
            //Ngu Linh case
            if(AIcardCounter == 5 && AIcardPointToInt <= 21){
                //Make a move
                deal();
                computerPoint = "Ngu Linh"
                return;
            }
            
            else if(AIcardPointToInt >= 15 && AIcardPointToInt <= 21) {
                //Make a move
                deal();
                return;
            }
            
            else {
                //Make a move
                pickMoreCard();
                return;
            }
        }
        
        
    }
    
    public func summarizeGameState(){
        print("user deal state: \(userDeal)")
        print("computer deal state: \(computerDeal)")
        print("both side deal status: \(bothSideDeal)")
        print("user card point: \(userPoint)")
        print("user computer point: \(computerPoint)")
        print("-------------------------------------")
    }
    
    public func UserPickDecisionPickMore(){
        //User will pick
        addCard(to: gameState.hands[1])
        //Update the user's point
        userPoint = gameState.hands[1].calculateTotalPointOfCards()
    }
    
    //MARK: Find out who is the winner
    public func evaluateWinner(){
        
        //Get the point for the user and the computer, these are using for comparison, we will convert string case to number too
//        var userPointNumber: Int = 0;
//        var computerPointNumber: Int = 0;
        
        //3 cases, with string - string
        
        // string - number
        
        // number - number
        
    }
    
    private func checkNumeric(input: String) -> Bool {
        for (_, char) in input.enumerated() {
            if(char.isNumber){
                continue;
            }
            else {
                return false;
            }
        }
        return true;
    }
   
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
