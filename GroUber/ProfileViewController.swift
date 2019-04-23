//
//  ProfileViewController.swift
//  GroUber
//
//  Created by alex chuckas on 4/22/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var name_label: UILabel!
    
    @IBOutlet weak var post_view: UITableView! //cells in table view show all posts sorted by most recent (cell show 2 lines of text at most, click it to go to new view controller with post where you can reply
    
    @IBOutlet weak var user_image: UIImageView!
    
    var profile_name = "Zachary Ward" //we be data taken from the database ultimately
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(setup_edit))
        
        
        let image = loadImageFromDiskWith(fileName: "user_profile")
        if image != nil {
            user_image.image = image
        }


        
        //get the profile name from the web here and place as title and name label
        name_label.text = profile_name
        self.title = profile_name
        
        post_view.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let image2 = RBSquareImage(image: image)
            user_image.image = image2
            //self.set_profile_image()
            saveImage(imageName: "user_profile", image: image2)
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func RBSquareImage(image: UIImage) -> UIImage {
        let originalWidth  = image.size.width
        let originalHeight = image.size.height
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        var edge: CGFloat = 0.0
        
        if (originalWidth > originalHeight) {
            // landscape
            edge = originalHeight
            x = (originalWidth - edge) / 2.0
            y = 0.0
            
        } else if (originalHeight > originalWidth) {
            // portrait
            edge = originalWidth
            x = 0.0
            y = (originalHeight - originalWidth) / 2.0
        } else {
            // square
            edge = originalWidth
        }
        
        let cropSquare = CGRect(x: x, y: y, width: edge, height: edge)
        let imageRef = image.cgImage?.cropping(to: cropSquare)
        
        return UIImage(cgImage: imageRef!)
    }
    
    //save the profile image
    func saveImage(imageName: String, image: UIImage) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
            
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
        
    }
    
    //load the profile image
    func loadImageFromDiskWith(fileName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
            
        }
        
        return nil
    }
    
    //edit the profile photo mainly
    @objc func setup_edit() {
        let image_picker = UIImagePickerController()
        image_picker.delegate = self
        image_picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        image_picker.allowsEditing = false
        self.present(image_picker, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //ADD IN: code to send to the post view controller goes here
    }
    
    //ADD IN: should put in
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profile_cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "profile_cell")
        return profile_cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
