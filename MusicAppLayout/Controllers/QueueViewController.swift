//
//  QueueViewController.swift
//  MusicAppLayout
//
//  Created by Thaís Fernandes on 22/06/21.
//

import UIKit

class QueueViewController: UIViewController, UITableViewDataSource {
  
    @IBOutlet weak var tableView: UITableView!
    
    var musicService: MusicService?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    

        guard let musicService = try? MusicService() else {
            return;
        }
                
        self.musicService = musicService
        
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
            
        } else if section == 1, let queue = musicService?.queue {
            
            return queue.nextInCollection.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "queue-cell", for: indexPath) as? QueueCell else {
            return UITableViewCell()
        }
        
        var musica: Music?
        
        guard let queue = musicService?.queue else {
            print("moio")
            return cell;
        }
                
        if indexPath.section == 0, let np = queue.nowPlaying {
            print("np")
            musica = np
        } else if !queue.nextInCollection.isEmpty {
            print("next")
            musica = queue.nextInCollection[indexPath.row]
        }

    
        
        if let musica = musica {
            cell.setUp(image: musicService?.getCoverImage(forItemIded: musica.id) ?? UIImage(), artist: musica.artist, musicName: musica.title, isFavorite: musicService?.favoriteMusics.contains(musica) ?? false)
        }
        
        return cell
    }
}
