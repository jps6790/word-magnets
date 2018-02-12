//
//  ViewController.swift
//  Project1WordMagnets
//
//  Created by Jordan Sullivan on 2/12/18.
//  Copyright © 2018 Jordan Sullivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Word bank
    let words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
    
    // Places each word from word bank in rows
    func placeWords(){
        var wordRow:CGFloat = 1.0
        let wordSpacing:CGFloat = 10.0
        let safety:CGFloat = 100        // Right margin to help keep words in view
        var x:CGFloat = wordSpacing
        var y:CGFloat = wordSpacing
        
        view.backgroundColor = UIColor.orange
        
        for word in words{
            let l = UILabel()
            l.backgroundColor = UIColor.white
            l.text = word
            l.textAlignment = .center
            l.sizeToFit()
            
            // Corrects short words/letters and adds white space
            if l.frame.size.width < 20{
                l.frame.size.width = 40
            }
            else{
                l.frame.size.width += 20
            }
            l.frame.size.height = 40
            
            x += wordSpacing
            
            // Moves to next row
            if (x+l.frame.size.width+wordSpacing)>(UIScreen.main.bounds.width-safety){
                x = wordSpacing
                wordRow += 1
            }
            y = wordRow*(wordSpacing+l.frame.size.height)
            
            // Position words
            l.frame.origin.x = x
            l.frame.origin.y = y
            
            x += l.frame.size.width
            
            l.isUserInteractionEnabled = true
            
            let panGesture = UIPanGestureRecognizer(target:self,action:#selector(doPanGesture))
            l.addGestureRecognizer(panGesture)
            
            view.addSubview(l)
        }
    }
    
    @objc func doPanGesture(panGesture:UIPanGestureRecognizer){
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeWords()
    }
}

