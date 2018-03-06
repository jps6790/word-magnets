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
    /*
    let words1 = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
    */
    
    let words1 = AppData.shared.fetchWords()
    
    var selectedBank: [String]?
    
    var backgroundImage: UIImage?
    
    @IBAction func reset(_ sender: Any) {
        deleteWords()
        placeWords(selectedBank)
    }
    
    @IBAction func share(_ sender: AnyObject) {
        
        let image = self.view.takeSnapshot()
        let textToShare = "I made a poem!"
        let igmWebsite = NSURL(string: "http://igm.rit.edu/")
        let objectsToShare:[AnyObject] = [textToShare as AnyObject, igmWebsite!,image!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.print]
        
        //code here prevents crashing if on iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityVC.popoverPresentationController?.sourceView = self.view
            activityVC.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            activityVC.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
        }
        self.present(activityVC, animated: true, completion: nil)
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
        selectedBank = words1
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
    func placeWords(_ wordSet: Array<String>? = nil) {
        
        //adjusts screen size based on device. Default is if on phone.
        var screenAdjust: CGFloat = 1.0
        if UIDevice.current.userInterfaceIdiom == .pad{
            screenAdjust = 1.50
        }
        
        let wordSpacing: CGFloat = 10
        let safety: CGFloat = 20
        let topMargin: CGFloat = UIScreen.main.bounds.size.height / 20
        let minMagnetLength: CGFloat = 40 * screenAdjust
        let minMagnetHeight = minMagnetLength
        let magnetAdjustmentValue = minMagnetLength / 2
        var wordRow = 0
        var x = safety
        var y = safety
        
        // Fill wordArray with parameterized array, or default array if none specified
        var wordArray: Array<String>
        if wordSet != nil {
            wordArray = wordSet!
        } else {
            wordArray = words1
        }
        
        for word in wordArray {
            let label = UILabel()
            if UIDevice.current.userInterfaceIdiom == .pad{ //adjusts font size if on iPad
                label.font = label.font.withSize(30)
            }
            
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
    
    //deletes words off the view. Used for replacing.
    func deleteWords(){
        for subview in view.subviews {
            if subview.isKind(of: UILabel.self) {
                subview.removeFromSuperview()
            }
        }
    }
    
    //MARK: - Pan Gestures
    @objc func doPanGesture(panGesture: UIPanGestureRecognizer) {
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
    }

}
