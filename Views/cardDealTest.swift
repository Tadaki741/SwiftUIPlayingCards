//
//  cardDealTest.swift
//  SwiftUIPlayingCards
//
//  Created by Duong Vo Dai on 20/08/2022.
//

//Here we are playing blackjack, also known as Xi Dach in Vietnam. The rules are

/**
 
 1. Initial rounds ( where we just had 2 fresh cards)
 
 
 
 2. Critical rounds ( where we are request to pull more cards )
 
 
 */

import SwiftUI

struct cardDealTest: View {
    private let roundRect = RoundedRectangle(cornerRadius: 20)
        @State private var flag: Bool = false;
        
        //This list of card will be available on the beginning of the match
        //Towards the end of the match, it will be continuing reducing the number of items
        @State private var listOfCards = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"
        ,"26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51"]
        
        
        private var valueDictionary:[Int:Int] = [
        
            0 : 10, // Ace
            1 : 2,
            2 : 3,
            3 : 4,
            4 : 5,
            5 : 6,
            6 : 7,
            7 : 8,
            8 : 9,
            9: 10,
            10 : 10, // Jack
            11 : 10, // Queen
            12 : 10, // King
            13 : 10, // Ace
            14 : 2 ,
            15 : 3 ,
            16 : 4 ,
            17 : 5 ,
            18 : 6 ,
            19 : 7 ,
            20 : 8 ,
            21 : 9 ,
            22 : 10,
            23 : 10, // Jack
            24 : 10, // Queen
            25 : 10, // King
            26 : 10, // Ace
            27 : 2 ,
            28 : 3 ,
            29 : 4 ,
            30 : 5 ,
            31 : 6 ,
            32 : 7 ,
            33 : 8 ,
            34 : 9 ,
            35 : 10,
            36 : 10, // Jack
            37 : 10, //Queen
            38 : 10, //King
            39 : 10, //Ace
            40 : 2 ,
            41 : 3 ,
            42 : 4 ,
            43 : 5 ,
            44 : 6 ,
            45 : 7 ,
            46 : 8 ,
            47 : 9 ,
            48 : 10 ,
            49 : 10 , // Jack
            50 : 10 , //Queen
            51 : 10 , //King
            
            
        ]
        
        //User side
        @State private var userPoint = 100;
        @State private var userCurrentDeckValue = 0;
        @State private var userCardDeal = [4,1];
        private var userTotalCardNumber = 0;
        
        
        //Computer side
        @State private var computerPoint = 100;
        @State private var computerCardDeal = [0,3];
        
        //Match information
        @State private var userWin = false;
        @State private var computerWin = false;
        
        

        var body: some View {
            
            
            
            ZStack {
                VStack(spacing:0) {
                    Color.red
                    Color.blue
                }
                
                ZStack{
                    //Big container for user side
                    VStack{
                        Spacer();
                        VStack{
                            Text("Computer current point:\(2)")
                            //On the upper side are the card deck of the computer side
                            HStack{
                                Image(listOfCards[userCardDeal[0]]).resizable().frame(width: 110, height: 160, alignment: .center);
                                Image(listOfCards[userCardDeal[1]]).resizable().frame(width: 110, height: 160, alignment: .center);
                                
                            }.padding()
                        }.onAppear(){
                            //Calculate the user's current deck value
                            calculateUserPoint();
                            //Calculate user total card number
                        }
                        
                        Spacer();
                        
                        
                        VStack{
                            //Show the user side
                            Text("User current point:\(userCurrentDeckValue)")
                            //Bottom are the user card deck
                            HStack{
                                Image(listOfCards[userCardDeal[0]]).resizable().frame(width: 110, height: 160, alignment: .center);
                                Image(listOfCards[userCardDeal[1]]).resizable().frame(width: 110, height: 160, alignment: .center);
                            }.padding()
                            
                        }
                        
                        
                        
                        
                        //-----------Button for user to confirm their selection----------
                        Button("Deal"){
                            
                            //Update the array that contain the value for the card
                            generateRandomCard();
                            
                            //Calculate the user's current card point
                            calculateUserPoint();
                            
                            //Check current winning condition
                            
                            
                            
                        }.frame(width: 70, height: 30)
                        .background(roundRect.fill(Color.orange))
                        .overlay(roundRect.stroke())
                        //---------------BUTTON-----------------------
                        
                        
                        
                        //Add another button for pick more cards into the deck
                        Button("Pick another"){
                            //Add the new card into the user's deck, this will also remove 1 card of the match card deck
                            userCardDeal.append(Int(listOfCards.removeLast()) ?? 0)
                            //Recalculate the user's point
                            calculateUserPoint();
                            //Add the new card image into the phone, if can include animation
                            
                            
                        }.foregroundColor(.black)
                        //------------------Button to pick another card into the deck----------
                        
                    }.padding()
                    
                    
                }
            }.ignoresSafeArea()
            
        }
        
        func generateRandomCard() {
            //We will update the selectionRow array, sort of like shuffle it
            userCardDeal[0] = Int.random(in: 0...51)
            userCardDeal[1] = Int.random(in: 0...51)
            print(userCardDeal)
        }
        
        
        
        //Function to check for the value of the user's card and the computer's card
        func evaluateRoundAfterDeal(){
            
            
        }
        
        func getUserTotalCardNumber()->Int{
            return self.userTotalCardNumber;
        }
        
        //Function to calculate the user's current point of the card deck
        func calculateUserPoint(){
            //Special case, 0 , 13 , 26 , 39 are the Ace, we will need to consider if we can evaluate the Ace as 1, 11 or 10 points. But for
            // the sake of this game, we will give it a 10
            var totalPoint: Int = 0;
            //Get the array that contain their total card
            //Loop through the deck, the deck will have maximum of 5 cards
            for item in userCardDeal {
                totalPoint += valueDictionary[item] ?? 0;
            }
            //Update the user point
            userCurrentDeckValue = totalPoint;
        }
        
        
        
}

struct cardDealTest_Previews: PreviewProvider {
    static var previews: some View {
        cardDealTest()
    }
}
