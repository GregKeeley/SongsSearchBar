//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

enum SearchScope {
    case name
    case artist
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResultLabel: UILabel!
    
    var loveSongs = [Song]() {
        didSet {
            tableView.reloadData()
        }
    }
    var currentScope = SearchScope.name
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .name:
                loveSongs = loveSongs.filter { $0.name.lowercased().contains(searchQuery.lowercased())}
            case .artist:
                loveSongs = loveSongs.filter { $0.artist.lowercased().contains(searchQuery.lowercased()) }
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        updateUI()
        noResultLabel.isHidden = true
    }

    func updateUI() {
        loveSongs = Song.loveSongs

    }
    func noResults() {
        if loveSongs.isEmpty  {
            noResultLabel.isHidden = false
            noResultLabel.text = "No Results"
            print("no results")
        }
    }
    func filterSongs( for searchText: String) {
        guard !searchText.isEmpty else { return }
        loveSongs = Song.loveSongs.filter { $0.name.lowercased().contains(searchText.lowercased())}
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let songDetailVC = segue.destination as? SongDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow
        else {
            fatalError("Failed to properly segue")
        }
        let song = loveSongs[indexPath.row]
        songDetailVC.song = song
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loveSongCell", for: indexPath)
        let song = loveSongs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artist
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        loveSongs.count
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        filterSongs(for: searchText)
        noResults()
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            updateUI()
            noResults()
            return
        }
        searchQuery = searchText
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = .name
        case 1:
            currentScope = .artist
        default:
            searchBar.placeholder = "not a valid search scope"
        }
    }
}
