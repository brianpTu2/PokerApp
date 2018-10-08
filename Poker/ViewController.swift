import UIKit

class ViewController: UIViewController {
    
    //VARIABLES
    @IBOutlet var card1: UIImageView!
    @IBOutlet var card2: UIImageView!
    @IBOutlet var card3: UIImageView!
    @IBOutlet var card4: UIImageView!
    @IBOutlet var card5: UIImageView!
    
    @IBOutlet var deck: UIImageView!
    @IBOutlet var hand1: UIImageView!
    @IBOutlet var hand2: UIImageView!
    
    @IBOutlet var holder1: UIImageView!
    @IBOutlet var holder2: UIImageView!
    @IBOutlet var holder3: UIImageView!
    @IBOutlet var holder4: UIImageView!
    @IBOutlet var holder5: UIImageView!
    
    @IBOutlet var betButton: UIButton!
    @IBOutlet var betEnterButton1: UIButton!
    @IBOutlet var checkButton: UIButton!
    
    @IBOutlet var betTextField: UITextField!
    
    @IBOutlet var potLabel: UILabel!
    
    
    var deckOfCards = ["10_of_clubs","10_of_diamonds","10_of_hearts", "10_of_spades","2_of_clubs","2_of_diamonds","2_of_hearts","2_of_spades","3_of_clubs","3_of_diamonds","3_of_hearts","3_of_spades","4_of_clubs","4_of_diamonds","4_of_hearts","4_of_spades","5_of_clubs","5_of_diamonds","5_of_hearts","5_of_spades","6_of_clubs","6_of_diamonds","6_of_hearts","6_of_spades","7_of_clubs","7_of_diamonds","7_of_hearts","7_of_spades","8_of_clubs","8_of_diamonds","8_of_hearts","8_of_spades","9_of_clubs","9_of_diamonds","9_of_hearts","9_of_spades","ace_of_clubs","ace_of_diamonds","ace_of_hearts","ace_of_spades","jack_of_clubs","jack_of_diamonds","jack_of_hearts","jack_of_spades","king_of_clubs","king_of_diamonds","king_of_hearts","king_of_spades","queen_of_clubs","queen_of_diamonds","queen_of_hearts","queen_of_spades"]
    var shuffled = [String]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        card1.isHidden = true
        card2.isHidden = true
        card3.isHidden = true
        card4.isHidden = true
        card5.isHidden = true
        hand1.isHidden = true
        hand2.isHidden = true
        
        betButton.isHidden = true
        betEnterButton1.isHidden = true
        betTextField.isHidden = true
        checkButton.isHidden = true
        
        for _ in 0..<deckOfCards.count {
            let rand = Int(arc4random_uniform(UInt32(deckOfCards.count)))
            shuffled.append(deckOfCards[rand])
            
            deckOfCards.remove(at: rand)
        }
        
    }
    
    @IBAction func playButtonIsPressed(_ sender: UIButton) {
        randCard(cardImage: card1)
        randCard(cardImage: card2)
        randCard(cardImage: card3)
        randCard(cardImage: card4)
        randCard(cardImage: card5)
        
        dealCard(card: card1, placeholder: holder1)
        dealCard(card: card2, placeholder: holder2)
        dealCard(card: card3, placeholder: holder3)
        
        randCard(cardImage: hand1)
        randCard(cardImage: hand2)
        dealHand(hand: hand1, xpos: 284, ypos: 301)
        dealHand(hand: hand2, xpos: 334, ypos: 301)
        
        // Animate bet button
        betButton.alpha = 0
        betButton.isHidden = false
        UIView.animate(withDuration: 1) {
            self.betButton.alpha = 1
        }
        // Animate check button
        checkButton.alpha = 0
        checkButton.isHidden = false
        UIView.animate(withDuration: 1) {
            self.checkButton.alpha = 1
        }
        
    }
    
    @IBAction func betButtonIsPressed(_ sender: UIButton) {
        betTextField.isHidden = false
        betEnterButton1.isHidden = false
        betTextField.isUserInteractionEnabled = true
    }
    
    @IBAction func betEnterButtonIsPressed1(_ sender: UIButton) {
        let betAmount: Int = Int(betTextField.text!)!
        let bet = betAmount
        betTextField.text = String(betAmount)+"$"
        betTextField.isUserInteractionEnabled = false
        betEnterButton1.isHidden = true
        
        dealCard(card: card4, placeholder: holder4)
        var pot: Int = 0
        pot = bet
        potLabel.text = "Pot: "+String(pot)+"$"
    }

    
    // This function animates the dealing of the flop
    func dealCard(card: UIImageView, placeholder: UIImageView) {
        card.alpha = 0
        card.center.x = CGFloat(deck.center.x)
        card.isHidden = false
        UIView.animate(withDuration: 1) {
            card.alpha = 1
            card.center.x = CGFloat(placeholder.center.x)
        }
    }
    
    // This functon animates the dealing of the hand
    func dealHand(hand: UIImageView, xpos: Int, ypos: Int) {
        hand.alpha = 0
        hand.center.x = CGFloat(deck.center.x)
        hand.center.y = CGFloat(deck.center.y)
        hand.isHidden = false
        UIView.animate(withDuration: 1) {
            hand.alpha = 1
            hand.frame.origin.x = CGFloat(xpos)
            hand.frame.origin.y = CGFloat(ypos)
        }
    }
    
    // This function picks a random card image
    func randCard(cardImage: UIImageView) {
        let randCardImageName = shuffled[Int(arc4random_uniform(UInt32(shuffled.count)))]
        let image = UIImage(named: randCardImageName)
        cardImage.image = image
    }

}

