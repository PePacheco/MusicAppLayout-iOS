//
//  LibraryViewController.swift
//  MusicAppLayout
//
//  Created by Thaís Fernandes on 18/06/21.
//

import UIKit

//library-item

class LibraryViewController: UIViewController, UITableViewDataSource {
    
    private var collection: [MusicCollection] = []
    private var musicService: MusicService?
    
    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let musicService = try? MusicService() else {
            self.collection = []
            return
        }
        
        self.collection = musicService.loadLibrary()
        self.musicService = musicService
        
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "library-cell", for: indexPath) as? LibraryCell else {
            return UITableViewCell()
        }
        
        let collectionItem = collection[indexPath.row]
        
        cell.setUp(title: collectionItem.title, subtitle: collectionItem.mainPerson, type: collectionItem.type.rawValue.localizedCapitalized, image: musicService?.getCoverImage(forItemIded: collectionItem.id) ?? nil)
        
        return cell
    }
    
}
