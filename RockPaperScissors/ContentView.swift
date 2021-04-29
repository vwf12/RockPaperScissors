//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by FARIT GATIATULLIN on 23.03.2021.
//

import SwiftUI

var previousNumber: Int?

func randomNumber() -> Int {
    var randomNumber = Int.random(in: 0...2)
    while previousNumber == randomNumber {
        randomNumber = Int.random(in: 0...2)
    }
    previousNumber = randomNumber
    return randomNumber
}

// var previousRandom: Int = 0

struct ContentView: View {
    
    
    @State private var moves: [String] = ["Scissors", "Rock", "Paper"]
        //.shuffled()
    @State private var playersChoice = ""
    @State private var isPlayerHaveToWin = Bool.random()
    @State private var shuffleButtons = false
    
    
    @State private var computerMove = randomNumber()
//    private var computerMovee: Int {
//        //var current = 1
//        var next: Int
//
//        repeat {
//            next = Int.random(in: 0...2)
//        } while previousRandom == next
//
//        previousRandom = next
//        return next
//    }
    
    
    @State private var moveNumber: Int = 0
    @State private var gameEnded = false
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertText = ""
    @State private var userScore = 0
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.5277768330401685, saturation: 0.6483301369540663, brightness: 1.0, opacity: 0.7521986444312406), location: 0.0), Gradient.Stop(color: Color(hue: 0.9220270363681289, saturation: 0.1626485342002777, brightness: 0.8897384275873024, opacity: 0.7689514160156251), location: 1.0)]), startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            if gameEnded == false {
            VStack {
            
                Text("You must")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                Text(isPlayerHaveToWin ? "WIN" : "LOSE")
                    .font(.system(size: 100))
                    .fontWeight(.black)
                    .foregroundColor(.white)
                Image(self.moves[computerMove])
                    .resizable()
                    .frame(minWidth: 50, maxWidth: 300, minHeight: 50, maxHeight: 150, alignment: .center)
                    .padding(.bottom)
                Spacer()
                
                VStack(spacing: 30) {
//                    ForEach(moves, id: \.self) {
////                        Text($0)
//                        Button(action: {
//                            print("tap")
//                        }) {
//                            Text($0)
//                        }
//                    }
                    ForEach(0 ..< 3) { move in
                        Button(action: {
                           buttonTapped(move)
                        }) {
                            Text(self.moves[move])
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width - 100, alignment: .center)
                        }
                        
                        .buttonStyle(NeumorphicButtonStyle(bgColor: Color.pink.opacity(0.0)))
                    }
                }.alert(isPresented: $showingScore) {
                    Alert(title: Text(scoreTitle), message:
                            Text(alertText), dismissButton: .default(Text("Continue")) {
                        self.askQuestion()
                    })
                }
                
                Toggle(isOn: $shuffleButtons) {
                    Text("Shuffle buttons")
                        .foregroundColor(.white)
                        .padding()
                        
                        
                }
                .toggleStyle(SwitchToggleStyle(tint: Color.pink.opacity(0.2)))
                .frame(width: UIScreen.main.bounds.width - 190, alignment: .center)
                .background(
                    ZStack {
//                        RoundedRectangle(cornerRadius: 5, style: .continuous)
//                            .shadow(color: Color.white.opacity(0.5), radius: 5, x: -5, y: -5)
//                            .shadow(color: .black, radius: 5, x: 5, y: 5)
//                            .blendMode(.softLight)
//                        RoundedRectangle(cornerRadius: 10, style: .continuous)
//                            .fill(Color.pink.opacity(0.0))
                    }
            )
            } }
                 else {
                    Button(action: {
                        moveNumber = 0
                        gameEnded.toggle()
                        askQuestion()
                    }) {
                        
                        HStack() {
                            Circle()
                               .fill(Color.white)
                               .frame(width: 50, height: 50)
                               .mask(
                                   Image(systemName: "arrow.counterclockwise")
                                       .font(.system(size: 24))
                                       .foregroundColor(Color.black)
                                       .frame(width: 50, height: 50)
                               )
                                
                            Text("Replay")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width - 100, alignment: .center)
                        }
                    }
                    .alert(isPresented: $showingScore) {
                        Alert(title: Text(scoreTitle), message:
                                Text(alertText), dismissButton: .default(Text("Continue")) {

                        })
                    }
                    .buttonStyle(NeumorphicButtonStyle(bgColor: Color.pink.opacity(0.0)))
                }
            
                Spacer()
            }
        }
    
    
    func buttonTapped (_ move: Int) {
        let result = whoIsWinner(computerItem: moves[computerMove], playerItem: moves[move])
        moveNumber += 1
        guard moveNumber < 10 else {
            scoreTitle = "GAME OVER"
            alertText = "Total score is \(userScore)"
            showingScore = true
            gameEnded.toggle()
            return
        }
        switch isPlayerHaveToWin {
        case true:
            if result == "Player" {
                userScore += 1
                scoreTitle = "RIGHT. SCORE + 1"
                alertText = "\(10 - moveNumber) moves left"
            } else if result == "Computer" {
                userScore -= 1
                scoreTitle = "FAIL. SCORE - 1"
                alertText = "\(10 - moveNumber) moves left"
            } else if result == "Tie" {
                userScore -= 1
                scoreTitle = "FAIL. SCORE - 1"
                alertText = "\(10 - moveNumber) moves left"
            }
            showingScore = true
        case false:
            if result == "Player" {
                userScore -= 1
                scoreTitle = "FAIL. SCORE - 1"
                alertText = "\(10 - moveNumber) moves left"
            } else if result == "Computer" {
                userScore += 1
                scoreTitle = "RIGHT. SCORE + 1"
                alertText = "\(10 - moveNumber) moves left"
            } else if result == "Tie" {
                userScore -= 1
                scoreTitle = "FAIL. SCORE - 1"
                alertText = "\(10 - moveNumber) moves left"
            }
            showingScore = true
        }
    }
    
    func whoIsWinner(computerItem: String, playerItem: String) -> (String) {
        if  (computerItem == "Scissors" && playerItem == "Rock") || (computerItem == "Rock" && playerItem == "Paper") || (computerItem == "Paper" && playerItem == "Scissors" ) {
        return "Player"
        } else if computerItem == playerItem {
            return "Tie"
        } else {
            return "Computer"
        }
    }
    
    func askQuestion() {
        if shuffleButtons == true {
        moves.shuffle()
        }
        //computerMove = Int.random(in: 0...2)
        computerMove = randomNumber()
        isPlayerHaveToWin = Bool.random()
    }
    
    
}



struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .shadow(color: Color.white.opacity(0.5), radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? -5: -15, y: configuration.isPressed ? -5: -15)
                        .shadow(color: .black, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? 5: 15, y: configuration.isPressed ? 5: 15)
                        .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                }
        )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .foregroundColor(.primary)
            .animation(.spring())
    }
}

extension Int {
    static func random(in range: ClosedRange<Int>, excluding x: Int) -> Int {
        if range.contains(x) {
            let r = Int.random(in: Range(uncheckedBounds: (range.lowerBound, range.upperBound)))
            return r == x ? range.upperBound : r
        } else {
            return Int.random(in: range)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
