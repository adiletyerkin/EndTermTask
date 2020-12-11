//
//  SecondViewController.swift
//  EndTermTask
//
//  Created by Macbook Pro 2020 on 11.12.2020.
//  Copyright © 2020 Macbook Pro 2020. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.seasonNum.count
    }
    var seasonNum = ["Season 1","Season 2", "Season 3","Season 4", "Season 5","Season 6","Season 7","Season 8"]
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.seasonName.text = seasonNum[indexPath.row]
        cell.seasonPhoto.image = UIImage(named: seasonNum[indexPath.row])
        
        return cell
    }


    @IBOutlet weak var seasonCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.seasonCollection.delegate = self
        self.seasonCollection.dataSource = self
        self.seasonCollection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")

    }
    
}
