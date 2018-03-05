//
//  ViewController.swift
//  Project1WordMagnets
//
//  Created by Jordan Sullivan & Nathan Sun on 2/12/18.
//  Copyright © 2018 Jordan Sullivan & Nathan Sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    // Word banks
    let words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
    
    let words2 = ["valley","I","departure","reveal","blow","the","conviction","dealer","is","ministry","observation","a","estimate","house","donor","cemetery","breast","revoke","favor","to","they","that"]
    
    let words3 = ["beauty","bare","at","as","as","an","a","a","ed","dream","cry","but","forest","fiddle","fast","er","enormous","lather","it","it","his","moon","sausage","lagomorph","rain","song","to","wind","were","together","you","boy","bear"]
    
    var backgroundImage: UIImage?
    
    @IBAction func reset(_ sender: Any) {

        //placeWords()
    }
    
    @IBAction func share(_ sender: AnyObject) {
        //TODO: Fix file with takeSnapshot() method to implement in ViewController.swift
//        let image = self.view.takeSnapshot()
//        let textToShare = "I made a poem!"
//        let igmWebsite = NSURL(string: "http://igm.rit.edu/")
//        let objectsToShare:[AnyObject] = [textToShare as AnyObject, igmWebsite!,image!]
//        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//        activityVC.excludedActivityTypes = [UIActivityType.print]
//        self.present(activityVC, animated: true, completion: nil)
    }
    @IBAction func setImageBG(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        placeWords()
    }
    
    //MARK: - UIPickerController Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]){
        print("finished picking")
        let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        backgroundImage = image
        (self.view as! UIImageView).contentMode = .center
        (self.view as! UIImageView).image = backgroundImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled")
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Word Placement Methods
    // Places each word from word bank in rows
    func placeWords() {
        let wordSpacing: CGFloat = 10
        let safety: CGFloat = 20
        let topMargin: CGFloat = UIScreen.main.bounds.size.height / 20
        let minMagnetLength: CGFloat = 40
        let minMagnetHeight = minMagnetLength
        let magnetAdjustmentValue = minMagnetLength / 2
        var wordRow = 0
        var x = safety
        var y = safety
        
        for word in words {
            let label = UILabel()
            label.backgroundColor = UIColor.white
            label.text = word
            label.textAlignment = .center
            label.sizeToFit()
            
            // Corrects short words/letters and adds white space
            if label.frame.size.width < magnetAdjustmentValue {
                label.frame.size.width = minMagnetLength
            } else {
                label.frame.size.width += magnetAdjustmentValue
            }
            
            label.frame.size.height = minMagnetHeight
            
            // Moves word to next row
            if (x + label.frame.size.width + safety) > (UIScreen.main.bounds.width) {
                x = safety
                wordRow += 1
            }
            
            // Assigns y-coordinate
            y = (CGFloat(wordRow) * (wordSpacing + label.frame.size.height)) + safety + topMargin
            
            // Position words
            label.frame.origin.x = x
            label.frame.origin.y = y
            
            x = x + label.frame.size.width + wordSpacing
            
            label.isUserInteractionEnabled = true
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            label.addGestureRecognizer(panGesture)
            
            view.addSubview(label)
        }
    }
    
    func deleteWords(){
        
    }
    
    //MARK: - Pan Gestures
    @objc func doPanGesture(panGesture: UIPanGestureRecognizer) {
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
    }

}
