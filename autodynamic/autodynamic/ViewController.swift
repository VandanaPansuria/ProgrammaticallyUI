//
//  ViewController.swift
//  autodynamic
//
//  Created by MacV on 26/02/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

   // @IBOutlet weak var tableView: UITableView!
    private var exampleContent = ["This is a short text.\n fhgfhgdhd hhg hdghhdhdhd\nhcbcchdfdgfd", "This is another text, and it is a little bit longer.", "Wow, this text is really very very long! I hope it can be read completely! Luckily, we are using automatic row height!"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
       /* self.tableView.register(UINib(nibName: String(describing: FeedCell.self), bundle: nil), forCellReuseIdentifier: "FeedCell")
        self.tableView.rowHeight  = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 80
        self.tableView.dataSource = self
        self.tableView.delegate = self*/
    }
   
    // MARK: - Table view data source

         func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return exampleContent.count
        }

        
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
             let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
            let content = exampleContent[indexPath.row]
            cell.lblName.text = content
            
            return cell
        }
}
