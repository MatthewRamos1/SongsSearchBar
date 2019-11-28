//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

enum SongScope {
    case title
    case artist
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var songs = Song.loveSongs {
        didSet {
            tableView.reloadData()
        }
    }
    var currentScope = SongScope.title
    
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .title:
                songs = Song.loveSongs.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
            case .artist:
                songs = Song.loveSongs.filter {
                    $0.artist.lowercased().contains(searchQuery.lowercased()) }
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let songDetailViewController = segue.destination as? SongDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Error with preparing segue")
        }
        songDetailViewController.song = songs[indexPath.row]
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let song = songs[indexPath.row]
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artist
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = .title
        case 1:
            currentScope = .artist
        default:
            print("Error: Not Valid Scope")
            
        }
    }
}
