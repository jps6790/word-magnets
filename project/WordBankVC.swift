//
//  WordBankVC.swift
//  Project1WordMagnets
//
//  Created by Student on 2/19/18.
//  Copyright © 2018 Jordan Sullivan. All rights reserved.
//

import UIKit

class WordBankVC: UITableViewController {

    @IBAction func cancelTapped(_ sender: AnyObject) {
    dismiss(animated: true, completion: nil)
    }
    var banks = ["Set 1", "Set 2", "Set 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return banks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = banks[indexPath.row]

        return cell
    }


}
