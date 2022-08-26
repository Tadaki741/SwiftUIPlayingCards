//
//  ContentView.swift
//  SwiftUIPlayingCards
//
//  Created by Chris Mash on 15/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: CONTROLLING GAME
    @StateObject private var gameState = GameState()
    @ObservedObject public var coreDM: CoreDataManager;
    @ObservedObject public var soundManager: SoundManager;
    @Namespace private var animation
    //Get the user information from the askPlayerView view
    @Binding var userNameFromAskPlayerNameView: String;
    @State var saveButtonPress: Bool = false;
    
    
    //MARK: Match information
    @State private var hasWinningPerson: Bool = false;
    @State private var alreadyAddedWinCount: Bool = false;
    @State private var winningPerson: String = "";
    
    //MARK: USER INFO
    @State private var userDeal:Bool = false;
    
    
    
    //MARK: COMPUTER INFO
    @State private var computerDeal: Bool = false;
    
    
    
    

    
    @State private var userPoint: String = "0";
    @State private var userWinningCount = 0;
    @State private var computerWinningCount = 0;
    @State private var computerPoint: String = "0";
    @State private var computerMoney: Int = 0;
    @State private var bothSideDeal: Bool = false;
    
    private let roundRect = RoundedRectangle(cornerRadius: 20)
    
    var body: some View {
        
        ZStack{
            
            VStack(spacing:0) {
                Color.yellow
                Color.purple
            }.onAppear(){
                print("incoming user: \(userNameFromAskPlayerNameView)")
                //Calculate user's point and computer point before hand
                userPoint = gameState.hands[1].calculateTotalPointOfCards();
                computerPoint = gameState.hands[0].calculateTotalPointOfCards();
                soundManager.stopBackgroundMusic();
            }
            
            ZStack{
                VStack {
                    Spacer();
                    HStack{
                        Text("computer win: \(computerWinningCount)");
                        Text("user win: \(userWinningCount)");
                    }
                    Spacer();
                    //MARK: Master card deck on the top
                    DeckView(deck: gameState.deck,namespace: animation).blur(radius: 20, opaque: true)
                    Spacer();
                    
                    //MARK: Computer side is in the middle, User side is on the bottom
                    // Draw each player's hand of cards, computer is at index 0 and user is at index 1
                    ForEach(gameState.hands) { hand in
                        
                        VStack{
                            
                            HStack {
                                if(hand.type == "computer"){
                                    //Use ternary operator to identify when the match will end, then we will unveil the computer cards
                                    HandView(hand: hand,namespace: animation).blur(radius: alreadyAddedWinCount ? 0 : 20, opaque: true);
                                }
                                else if(hand.type == "user") {
                                    HandView(hand: hand,namespace: animation)
                                }
                                
                                
                            }.padding()
                            
                            //Options for the user
                            if(hand.type == "user"){
                                //View point of the user
                                Text("\(userNameFromAskPlayerNameView) point: \(userPoint)").font(.system(size: 30, weight: .heavy, design: .default))
                                Button("Pick more"){
                                    //Action from user, can only pick up to 5 cards only AND can still picking if both side haven't dealt yet
                                    if(gameState.hands[1].cards.count < 5 && (bothSideDeal == false)){
                                        UserPickDecisionPickMore();
                                    }
                                    
                                    
                                    //Then, its turn for computer to move
                                    AIPickDecision();
                                    
                                    
                                }.frame(width: 90, height: 40)
                                    .background(roundRect.fill(Color.orange))
                                    .overlay(roundRect.stroke())
                                
                                
                                
                                
                                Button("Deal"){
                                    userDealCard();
                                    
                                    
                                }.frame(width: 90, height: 40)
                                    .background(roundRect.fill(Color.orange))
                                    .overlay(roundRect.stroke())
                                
                                
                                
                                
                            }
                            else if(hand.type == "computer"){
                                Text("Computer point: \(computerPoint)").blur(radius: alreadyAddedWinCount ? 0 : 20, opaque: true).font(.system(size: 30, weight: .heavy, design: .default))
                            }
                            
                        }
                        
                        Spacer();
                        
                    }
                    Spacer();
                    
                    //Display winner
                    if(hasWinningPerson){
                        withAnimation {
                            Button("See result") {}
                            .sheet(isPresented: $hasWinningPerson, content: {
                                
                                VStack{
                                    
                                    Text("\(winningPerson) WIN !").onAppear {
                                        //play the sound
                                        if(winningPerson == "USER"){
                                            //Play sound user win
                                            playSound(sound: "blackJackWinSound", type: "mp3")
                                        }
                                        else if(winningPerson == "COMPUTER"){
                                            //Play sound computer win
                                            playSound(sound: "blackJackDefeatSound", type: "mp3")
                                        }
                                    }
                                    
                                    
                                    
                                    HStack{
                                        
                                        Button("Play again ?"){
                                            //Reset game
                                            resetGame();
                                            
                                        }.frame(width: 100, height: 50)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(10);
                                        
                                        //User when quitting, their data will be saved into the CoreData
                                        Button(saveButtonPress ? "Saving..." : "Save match"){
                                            
                                            savePlayer();
                                            
                                            //Notify the user
                                            saveButtonPress = true;
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                                saveButtonPress = false;
                                            }
                                            
                                            
                                        }.frame(width: 100, height: 50)
                                            .background(saveButtonPress ? Color.yellow : Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(10);
                                    }
                                }
                            })
                        }
                    }
                    
                    Spacer();
                    
                }
            }
            
            
        }.ignoresSafeArea()
        
    }
    
    //MARK: Game main functions
    
    
    
    
    //MARK: Add cards
    private func addCard(to hand: Hand) {
        withAnimation {
            guard let card = gameState.deck.cards.popLast() else {
                print("Deck is empty!")
                return
            }
            
            hand.cards.append(card)
        }
    }
    
    //MARK: Remove cards
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
    
    //MARK: Reset game function
    private func resetGame(){
        //Remove computer cards
        for card in gameState.hands[0].cards {
            remove(card: card, from: gameState.hands[0])
        }
        
        //Remove user cards
        for card in gameState.hands[1].cards {
            remove(card: card, from: gameState.hands[1])
        }
        
        //Reset points
        computerDeal = false;
        userDeal = false;
        hasWinningPerson = false;
        alreadyAddedWinCount = false;
        winningPerson = "";
        userPoint = "0";
        computerPoint = "0";
        bothSideDeal = false;
        
        
        //Then we will shuffle the master card deck again
        gameState.deck.cards.shuffle();
    }
    
    //MARK: PLAYER
    
    
    
    
    
    //MARK: play pick more card
    public func UserPickDecisionPickMore(){
        //Sound effect for user
        playSound(sound: "pageTurnSoundEffect", type: "mp3")
        //User will pick
        addCard(to: gameState.hands[1])
        //Update the user's point
        userPoint = gameState.hands[1].calculateTotalPointOfCards()
    }
    
    //MARK: player deal
    private func userDealCard(){
        
        //Sound effect for user
        playSound(sound: "cardDealSoundEffect", type: "mp3")
        
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
    
    //MARK: Player save data
    private func savePlayer(){
        //Save data to core data model, player can view this data in the leaderboard
        //Convert the winning count to integer
        let userWinCountToString = String(userWinningCount);
        let computerWinCountToString = String(computerWinningCount);
        coreDM.savePlayer(name: userNameFromAskPlayerNameView, score: userWinCountToString, computerScore: computerWinCountToString);
        print("Data saved");
    }
    
    //MARK: COMPUTER
    public func AIPickDecision(){
        
        //----------------------AI MOVES ----------------
        //MARK: AI pick more
        func pickMoreCard(){
            //Computer will pick the next card
            addCard(to: gameState.hands[0])
            //Update computer's point
            computerPoint = gameState.hands[0].calculateTotalPointOfCards()
        }
        
        //MARK: AI did not pick
        func stopPicking(){
            return;
        }
        
        //MARK: AI wants to deal
        func deal () {
            computerDeal = true;
            if(userDeal && computerDeal){
                bothSideDeal = true;
            }
            else {
                return;
            }
        }
        
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
    
    
    
    //MARK: Find out who is the winner
    //MARK: pointcase -> Xi Ban = 100, Xi Dach = 90, Ngu Linh = 80, Quach = -100, numbers value = similar value
    public func evaluateWinner(){
        
        //Convert user point and computer point into number
        func convertStringToNumber(inputPoint: String) -> Int{
            var returningPoint: Int = 0;
            //Case numeric
            if(checkNumeric(input: inputPoint)){
                returningPoint = Int(inputPoint) ?? 0;
            }
            // and Case not numeric
            else if(!checkNumeric(input: inputPoint)){
                switch inputPoint {
                case "Xi Ban":
                    returningPoint = 100;
                    
                case "Xi Dach":
                    returningPoint = 90;
                    
                case "Ngu Linh":
                    returningPoint = 80;
                    
                case "Quach":
                    returningPoint = -100;
                    
                default:
                    returningPoint = 0;
                }
            }
            return returningPoint;
        }
        
        let userFinalResult = convertStringToNumber(inputPoint: userPoint);
        let computerFinalResult = convertStringToNumber(inputPoint: computerPoint);
        
        if(userFinalResult == computerFinalResult){
            //DRAW
            winningPerson = "NO ONE"
            alreadyAddedWinCount = true;
        }
        
        else if((userFinalResult > computerFinalResult) && (!alreadyAddedWinCount) ){
            //USER WIN
            winningPerson = "USER"
            userWinningCount += 1;
            alreadyAddedWinCount = true;
        }
        
        else if( (computerFinalResult > userFinalResult) && (!alreadyAddedWinCount)){
            //COMPUTER WIN
            winningPerson = "COMPUTER"
            computerWinningCount += 1;
            alreadyAddedWinCount = true;
        }
        
        //We already have the winner
        hasWinningPerson = true;
        
    }
    
    
    //MARK: Additional function to support calculations
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
