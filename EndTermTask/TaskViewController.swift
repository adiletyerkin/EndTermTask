//
//  TaskViewController.swift
//  EndTermTask
//
//  Created by Macbook Pro 2020 on 11.12.2020.
//  Copyright © 2020 Macbook Pro 2020. All rights reserved.
//

import UIKit
import RealmSwift
var notes: Results<Notess>!
var realm = try! Realm()

class TaskViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return notes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! taskToDOViewCell
            cell.nameTask.text = notes[indexPath.row].content
            cell.taskStatus.text = notes[indexPath.row].isDone ? "Done":"Not yet"
            
            return cell
            
        }
    @IBOutlet weak var tableNotes: UITableView!
        
    @IBAction func addNewNote(_ sender: Any) {
    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            notes = realm.objects(Notess.self)
            self.tableNotes.delegate = self
            self.tableNotes.dataSource = self
            reload()
           
        }
        override func viewWillAppear(_ animated: Bool) {
            reload()
        }
    
        func reload(){
             tableNotes.reloadData()
         }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete{
                try! realm.write {
                    realm.delete(notes[indexPath.row])
                }
                reload()
            }
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "clicktoCell"{
                let destination = segue.destination as! secondVC
                let note = notes[tableNotes.indexPathForSelectedRow!.row]
                destination.incomingTask = note
            }
        }

    }


    class Notess: Object {
        @objc dynamic var content: String = ""
        @objc dynamic var isDone = false
    }



    class secondVC: UIViewController {
        
        var incomingTask: Notess? = nil

        
        @IBOutlet weak var textNewNote: UITextField!
        @IBOutlet weak var switchDone: UISwitch!
        
        @IBAction func saveNote(_ sender: Any) {
            if let taskdone = incomingTask{
                try! realm.write{
                    taskdone.content = textNewNote.text!
                    taskdone.isDone = switchDone.isOn
                }
            }
            else{
            
            let myNote = Notess()
            myNote.content = textNewNote.text!
            myNote.isDone = switchDone.isOn
      
                try! realm.write {
                    realm.add(myNote)
                
                }
            }
            navigationController?.popViewController(animated: true)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            if let taskdone = incomingTask{
                textNewNote.text = taskdone.content
                switchDone.isOn = taskdone.isDone
                
            }
        }
    }

class taskToDOViewCell: UITableViewCell {

    @IBOutlet weak var nameTask: UILabel!
    
    @IBOutlet weak var taskStatus: UILabel!
    
}
