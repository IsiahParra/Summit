//
//  TrailListTableViewController.swift
//  Summit
//
//  Created by Isiah Parra on 7/13/22.
//

import UIKit

class TrailListTableViewController: UITableViewController {

     var viewModel: TrailListViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TrailListViewModel(delegate: self)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.trails.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trailListCell", for: indexPath) as? TrailListTableViewCell else {
            return UITableViewCell()
        }
        let trail = viewModel.trails[indexPath.row]
        cell.configure(with: trail.trailName, image: nil) //figure out how to get the image out of fire storage
        

        // Configure the cell...

        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(index: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TrailsDetailViewController
        else {return}
        if segue.identifier == "toDetailVC" {
            guard let index = tableView.indexPathForSelectedRow else { return }
            let trailToSend = viewModel.trails[index.row]
            destination.viewModel = TrailDetailViewModel(trail: trailToSend)
        } 
    }
    

}

extension TrailListTableViewController: TrailListViewModelDelegate {
    func fetchedTrailsSuccessfully() {
        tableView.reloadData()
    }
}
