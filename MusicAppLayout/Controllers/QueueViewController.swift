//
//  QueueViewController.swift
//  MusicAppLayout
//
//  Created by Thaís Fernandes on 22/06/21.
//

import UIKit

class QueueViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func onTapClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var sections = 2
        
        if let musicService = MusicService.shared {
            
            if musicService.queue.nowPlaying == nil {
                sections -= 1
            }
            
            if musicService.queue.nextInCollection.isEmpty {
                sections -= 1
            }
            
        }
        
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let musicService = MusicService.shared {
            if section == 0 {
                return 1
            } else if section == 1 {
                return musicService.queue.nextInCollection.count
            }
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "queue-cell", for: indexPath) as? QueueCell,
              let musicService = MusicService.shared
        else {
            return UITableViewCell()
        }
        
        var musica: Music?

        if indexPath.section == 0, let np = musicService.queue.nowPlaying {
            musica = np
        } else if !musicService.queue.nextInCollection.isEmpty {
            musica = musicService.queue.nextInCollection[indexPath.row]
        }

        if let musica = musica {
            cell.setUp(image: musicService.getCoverImage(forItemIded: musica.id) ?? UIImage(), artist: musica.artist, musicName: musica.title, isFavorite: musicService.favoriteMusics.contains(musica))
        }
        
        cell.music = musica
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var title: String = ""
        if section == 0 {
            title = "Now Playing"
        } else if section == 1 {
            title = "Next in \(MusicService.shared?.queue.nextInCollection.first?.title ?? "")"
        }
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        header.backgroundColor = .clear
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: view.frame.size.width, height: 22))
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = title
        header.addSubview(label)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
}
