//
//  DiscoverViewController.swift
//  MusicAppLayout
//
//  Created by Pedro Gomes Rubbo Pacheco on 24/06/21.
//

import UIKit

class DiscoverViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
    }
    
}

extension DiscoverViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0: return recentlyReleasedCell()
            case 1: return songCell()
            case 2: return forYouCell()
            case 3: return songCell()
            case 4: return songCell()
            case 5: return listenAgainCell()
            default:
                return UITableViewCell()
        }
    }
    
    func recentlyReleasedCell() -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recently-released-cell") as? RecentlyReleasedTableViewCell else {
            return UITableViewCell()
        }
        
        guard let musicService = MusicService.shared else {
            return UITableViewCell()
        }
        let music = musicService.loadLibrary()[0].musics[0]
        guard let image = musicService.getCoverImage(forItemIded: music.id) else {
            return UITableViewCell()
        }
        cell.setUp(image: image, name: music.artist)
        return cell
    }
    
    func songCell() -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "song-cell") as? DiscoverMusicTableViewCell else {
            return UITableViewCell()
        }
        
        guard let musicService = MusicService.shared else {
            return UITableViewCell()
        }
        
        let index = Int.random(in: 0...9)
        
        let album = musicService.loadLibrary()[index]
        let music = album.musics[0]
        
        guard let image = musicService.getCoverImage(forItemIded: music.id) else {
            return UITableViewCell()
        }
        
        cell.setUp(albumImage: image, songName: music.title, albumName: album.title)
        
        return cell
    }
    
    func listenAgainCell() -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listen-again-cell") as? ListenAgainTableViewCell else {
            return UITableViewCell()
        }
        
        guard let musicService = MusicService.shared else {
            return UITableViewCell()
        }
        
        let index = Int.random(in: 0...9)
        let index2 = Int.random(in: 0...9)

        let album1 = musicService.loadLibrary()[index]
        let album2 = musicService.loadLibrary()[index2]

        guard let image1 = musicService.getCoverImage(forItemIded: album1.id),
              let image2 = musicService.getCoverImage(forItemIded: album2.id) else {
            return UITableViewCell()
        }
        
        cell.setUp(image1: image1, image2: image2, albumName1: album1.title, albumName2: album2.title)
        
        return cell
    }
    
    func forYouCell() -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "for-you-cell") else {
            return UITableViewCell()
        }
        
        return cell
    }
}
