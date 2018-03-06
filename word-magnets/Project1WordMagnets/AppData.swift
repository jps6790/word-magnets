//
//  AppData.swift
//  Project1WordMagnets
//
//  Created by Student on 3/5/18.
//  Copyright © 2018 Jordan Sullivan. All rights reserved.
//

import Foundation

class AppData{
     static let shared = AppData()
    
    //word data
    let words1 = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
    let words2 = ["valley","I","departure","reveal","blow","the","conviction","dealer","is","ministry","observation","a","estimate","house","donor","cemetery","breast","revoke","favor","to","they","that"]
    
    let words3 = ["beauty","bare","at","as","as","an","a","a","ed","dream","cry","but","forest","fiddle","fast","er","enormous","lather","it","it","his","moon","sausage","lagomorph","rain","song","to","wind","were","together","you","boy","bear"]
    
    private init(){}
    
    //Gets words from AppData
    func fetchWords()->[String]{
        return words1
    }
}
