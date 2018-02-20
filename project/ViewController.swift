//
//  ViewController.swift
//  Project1WordMagnets
//
//  Created by Jordan Sullivan & Nathan Sun on 2/12/18.
//  Copyright © 2018 Jordan Sullivan & Nathan Sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Word banks
    let words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
    
    let words2 = ["valley", "I", "departure", "reveal", "blow","the", "conviction", "dealer", "is","ministry", "observation","a", "estimate", "house", "donor", "cemetery", "breast", "revoke", "favor","to","they","that"]
    
    let words3 = ["beauty", "bare", "at", "as", "as", "an", "a", "a", "ed", "dream", "cry", "but", "forest", "fiddle", "fast", "er", "enourmous", "lather", "it", "it","his", "moon", "sausage", "lagomorph", "rain","song", "to", "wind", "were" , "together", "you", "boy","bear"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeWords()
    }
    
    // Places each word from word bank in rows
    func placeWords(){
        var wordRow:CGFloat = 1.0
        let wordSpacing:CGFloat = 10.0
        let safety:CGFloat = 100        // Right margin to help keep words in view
        var x:CGFloat = wordSpacing
        var y:CGFloat = wordSpacing
        
        view.backgroundColor = UIColor.orange
        
        for word in words{
            let label = UILabel()
            label.backgroundColor = UIColor.white
            label.text = word
            label.textAlignment = .center
            label.sizeToFit()
            
            // Corrects short words/letters and adds white space
            if label.frame.size.width < 20{
                label.frame.size.width = 40
            }
            else{
                label.frame.size.width += 20
            }
            label.frame.size.height = 40
            
            x += wordSpacing
            
            // Moves to next row
            if (x+label.frame.size.width+wordSpacing)>(UIScreen.main.bounds.width-safety){
                x = wordSpacing
                wordRow += 1
            }
            y = wordRow*(wordSpacing+label.frame.size.height)
            
            // Position words
            label.frame.origin.x = x
            label.frame.origin.y = y
            
            x += label.frame.size.width
            
            label.isUserInteractionEnabled = true
            
            let panGesture = UIPanGestureRecognizer(target:self,action:#selector(doPanGesture))
            label.addGestureRecognizer(panGesture)
            
            view.addSubview(label)
        }
    }
    
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer){
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
    }


}

