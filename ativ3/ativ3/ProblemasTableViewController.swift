//
//  ProblemasTableViewController.swift
//  ativ3
//
//  Created by Edivaldo Serafim on 05/09/21.
//  Copyright © 2021 Edivaldo Serafim. All rights reserved.
//

import UIKit
import CoreData

class ProblemasTableViewController: UITableViewController {
    
    var fetchetResultController : NSFetchedResultsController<Problema>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProblemas()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
                
        if let problemaViewController = segue.destination as? ProblemaViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            problemaViewController.problema =  fetchetResultController.object(at: indexPath)
        }
    }
    
    func loadProblemas(){
        let fetchRequest : NSFetchRequest<Problema> = Problema.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchetResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchetResultController.delegate = self
        try? fetchetResultController.performFetch()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchetResultController.fetchedObjects?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProblemaTableViewCell else {
            return UITableViewCell()
        }
        
        let problema = fetchetResultController.object(at: indexPath)
        cell.configWith(problema)

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let problema = fetchetResultController.object(at: indexPath)
            context.delete(problema)
            try? context.save()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProblemasTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        tableView.reloadData()
    }
}
