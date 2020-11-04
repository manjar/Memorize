//
//  MemoryGame.swift
//  Memorize
//
//  Created by Eli Manjarrez on 9/23/20.
//

import Foundation

struct MemoryGame<CardContent> where CardContent : Equatable {
    private(set) var cards: Array<Card>
    var score: Int = 0
    
    mutating func choose(card: Card) {
//        print("card chosen \(card)");
        guard !card.isMatched, !card.isFaceUp else {
            return
        }
        let countOfFaceUp =  cards.filter{ $0.isFaceUp == true }.count
        switch countOfFaceUp {
        case 0:
            // flip the card
            flipCard(card)
        case 1:
            // flip the card
            flipCard(card)
            // check for pair
            checkForPairAndMatch()
            break
        case 2:
            // flip over face up cards, then do same as for 0
            resetFaceUpCards()
            flipCard(card)
            break
        default:
            // log error
            break
        }
    }
    
    mutating func resetFaceUpCards() {
        let faceUpUnmatchedCards = cards.filter({ $0.isFaceUp == true })
        for aCard in faceUpUnmatchedCards {
            flipCard(aCard)
        }
    }
    
    mutating func checkForPairAndMatch() {
        let faceUpUnmatchedCards = cards.filter { $0.isFaceUp == true && $0.isMatched == false }
        guard faceUpUnmatchedCards.count == 2 else {
            return
        }
        let indexOfCard1 = cards.firstIndex(matching: faceUpUnmatchedCards[0])!
        let indexOfCard2 = cards.firstIndex(matching: faceUpUnmatchedCards[1])!
        if faceUpUnmatchedCards[0].content == faceUpUnmatchedCards[1].content {
            cards[indexOfCard1].isMatched = true
            cards[indexOfCard2].isMatched = true
            score += 2
            print("matched \(cards[indexOfCard1]) to \(cards[indexOfCard2]), score is \(score)");
        } else {
            if cards[indexOfCard1].hasBeenSeen {
                score -= 1
            }
            if cards[indexOfCard2].hasBeenSeen {
                score -= 1
            }
        }
        cards[indexOfCard1].hasBeenSeen = true
        cards[indexOfCard2].hasBeenSeen = true
    }
    
    mutating func flipCard(_ card:Card) {
        if let indexOfCard = cards.firstIndex(matching: card) {
            cards[indexOfCard].isFaceUp = !cards[indexOfCard].isFaceUp
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: (pairIndex * 2)    ))
            cards.append(Card(content: content, id: (pairIndex * 2) + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }
        var hasBeenSeen: Bool = false
        var content: CardContent
        var id: Int
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0) && (bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
