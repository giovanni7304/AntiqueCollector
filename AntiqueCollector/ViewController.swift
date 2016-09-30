//
//  ViewController.swift
//  AntiqueCollector
//
//  Created by Terry Johnson on 9/30/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var antiques : [Antiques] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let antique = antiques[indexPath.row]
        cell.textLabel?.text = antique.title
        cell.imageView?.image = UIImage(data: antique.image as! Data)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return antiques.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            antiques = try context.fetch(Antiques.fetchRequest())
            tableView.reloadData()
        } catch {
            print("Error Loading Core Data")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let antique = antiques[indexPath.row]
        performSegue(withIdentifier: "antiqueSegue", sender: antique)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! AntiqueViewController
        nextVC.antique = sender as? Antiques
        
    }
}

