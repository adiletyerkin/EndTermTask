//
//  FriendsViewController.swift
//  EndTermTask
//
//  Created by Macbook Pro 2020 on 11.12.2020.
//  Copyright © 2020 Macbook Pro 2020. All rights reserved.
//

import UIKit
import RealmSwift
var friends: Results<Friends>!
var realm2 = try! Realm()
var photodata: Data? = nil
class FriendsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! friendsViewCell
        cell.name.text = friends[indexPath.row].name
        cell.addres.text = friends[indexPath.row].addres
        cell.date.text = friends[indexPath.row].date
        cell.phone.text = friends[indexPath.row].phone
//        cell.photo.image = friends[indexPath.row].UIImage(imageName)
            cell.backgroundColor = UIColor.white
               cell.layer.borderColor = UIColor.black.cgColor
               cell.layer.borderWidth = 1
               cell.layer.cornerRadius = 12
               cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166
    }
 
    
    
    @IBOutlet weak var FriendsTable: UITableView!
    
    @IBAction func addNewFriend(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.FriendsTable.delegate = self
        self.FriendsTable.dataSource = self
        friends = realm2.objects(Friends.self)
        reload()
    }
    
    
       override func viewWillAppear(_ animated: Bool) {
           reload()
       }
       func reload(){
            FriendsTable.reloadData()
        }
    
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete{
               try! realm2.write {
                   realm2.delete(friends[indexPath.row])
               }
               reload()
           }
       }
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "clicktoCell"{
               let destination = segue.destination as! FriendsSetVC
               let friend = friends[FriendsTable.indexPathForSelectedRow!.row]
               destination.incomingFriends = friend
           }
       }
    
    
}
class Friends: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var addres: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var imageName = ""
    
    
}

import ContactsUI
class FriendsSetVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var incomingFriends: Friends? = nil

        @IBOutlet weak var nameText: UITextField!
        @IBOutlet weak var addresText: UITextField!
        @IBOutlet weak var dateText: UITextField!
        @IBOutlet weak var phoneText: UILabel!
        @IBOutlet weak var photoT: UIImageView!
    
   
    
    @IBAction func saveFriends(_ sender: Any) {
        
            if let taskdone = incomingFriends{
                try! realm.write{
                    taskdone.name = nameText.text!
                    taskdone.addres = addresText.text!
                    taskdone.date = dateText.text!
                    taskdone.phone = phoneText.text!
//                    taskdone.imageName =
                    
                }
            }
            else{
            
            let myNote = Friends()
            myNote.name = nameText.text!
            myNote.addres = addresText.text!
            myNote.date = dateText.text!
            myNote.phone = phoneText.text!
               // myNote.imageName = photodata.
                
                
                try! realm.write {
                    realm.add(myNote)
                
                }
            }
        
            navigationController?.popViewController(animated: true)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            contactsController.delegate = self
            if let taskdone = incomingFriends{
                nameText.text = taskdone.name
                addresText.text = taskdone.addres
                dateText.text = taskdone.date
                phoneText.text = taskdone.phone
              //  photoT = taskdone.picture
      
            }
        }
    
    let contactsController = CNContactPickerViewController()
    let imagePickerController = UIImagePickerController()
    
       

    @IBAction func getContactF(_ sender: Any) {
          self.present(contactsController, animated: true, completion: nil)
    }
    
    
    @IBAction func getImageF(_ sender: Any) {
        imagePickerController.delegate = self

              let actionSheet = UIAlertController(title: "Photo Sourse", message: "choose a sourse", preferredStyle: .actionSheet)
              actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
                  if UIImagePickerController.isSourceTypeAvailable(.camera){
                      self.imagePickerController.sourceType = .camera
                       self.present(self.imagePickerController, animated: true, completion: nil)
                  }else{
                      print("Camera not availabel")
                  }
              }))
              actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
                  self.imagePickerController.sourceType = .photoLibrary
                  self.present(self.imagePickerController, animated: true, completion: nil)
                    
              }))
              actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
              self.present(actionSheet, animated: true, completion: nil)
              
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
          photoT.image = image
          picker.dismiss(animated: true, completion: nil)
        
//        guard let photodata = image.pngData() else{
//            return
//        }

      }
    
      
      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          picker.dismiss(animated: true, completion: nil)
      }
    
        

    }

extension FriendsSetVC : CNContactPickerDelegate{
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print(contact.phoneNumbers[0].value.stringValue)
        self.phoneText.text = contact.phoneNumbers[0].value.stringValue
    }
        
}


class friendsViewCell: UITableViewCell  {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var addres: UILabel!
    @IBOutlet weak var phone: UILabel!
    
}
