//
//  DiaryViewController.swift
//  EndTermTask
//
//  Created by Macbook Pro 2020 on 11.12.2020.
//  Copyright © 2020 Macbook Pro 2020. All rights reserved.
//

import UIKit
import RealmSwift
var diaries: Results<Diaries>!
var realm3 = try! Realm()

class DiaryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return diaries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! diarycell
        cell.nameD.text = diaries[indexPath.row].name
        cell.timeDate.text = diaries[indexPath.row].time
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.diaryTable.delegate = self
        self.diaryTable.dataSource = self
        diaries = realm3.objects(Diaries.self)
        
    }
    
    @IBOutlet weak var diaryTable: UICollectionView!
    
        override func viewWillAppear(_ animated: Bool) {
            reload()
        }
    
        func reload(){
             diaryTable.reloadData()
         }
    
    

     func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       if !isEditing {
            try! realm3.write {
                realm3.delete(notes[indexPath.row])
            }
            reload()
        }
    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "clicktoCell" {
            let destination = segue.destination as! DiarySet
            if let indexPath = diaryTable?.indexPathsForSelectedItems?.first {
                let diary = diaries[indexPath.row]
                destination.incomingTask = diary
            }
        }
    }

    
    
}

class DiarySet: UIViewController {
    
    @IBOutlet weak var datedset: UITextField!
    @IBOutlet weak var themD: UITextField!
    // @IBOutlet weak var insertD: UITextField!
    @IBOutlet var insertD: UITextView!
    
    
  var incomingTask: Diaries? = nil

    @IBAction func saveD(_ sender: Any) {
          if let taskdone = incomingTask{
              try! realm3.write{
                taskdone.name = themD.text!
                taskdone.time = datedset.text!
                taskdone.textdiary = insertD.text!
                  
              }
          }
          else{
          
          let myNote = Diaries()
          myNote.name = themD.text!
          myNote.time = datedset.text!
         myNote.textdiary = insertD.text!
            
              try! realm3.write {
                  realm3.add(myNote)
              
              }
          }
          navigationController?.popViewController(animated: true)
      }
    
     
     override func viewDidLoad() {
      super.viewDidLoad()
               if let taskdone = incomingTask{
                themD.text =  taskdone.name
                datedset.text =  taskdone.time
                insertD.text =  taskdone.textdiary
            
               }
    }
    
}


class diarycell: UICollectionViewCell{
    
    
    @IBOutlet weak var nameD: UILabel!
    @IBOutlet weak var timeDate: UILabel!
    
    
}

class Diaries: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var time : String = ""
    @objc dynamic var textdiary : String = ""
}
