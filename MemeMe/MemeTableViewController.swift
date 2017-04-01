//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Christina Bharara on 3/31/17.
//  Copyright © 2017 cabhara. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    var memes = [Meme]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablememecell", for: indexPath) as! MemeTableViewCell

        let meme = memes[indexPath.row]
        
        cell.memeImageView.image = meme.memed
        cell.topLabel.text = meme.top
        cell.bottomLabel.text = meme.bottom

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            memes.remove(at: indexPath.row)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.memes = memes
            tableView.deleteRows(at: [indexPath], with: .fade)
        }   
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "tableDetail", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="tableDetail"){
            let detailVC = segue.destination as! DetailViewController
            let meme = memes[(tableView.indexPathForSelectedRow?.row)!]
            detailVC.meme = meme
        }
    }
    

}
