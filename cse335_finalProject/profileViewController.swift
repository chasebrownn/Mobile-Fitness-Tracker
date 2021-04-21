//
//  profileViewController.swift
//  cse335_finalProject
//
//  Created by Chase Brown on 4/9/21.
//

import UIKit

class profileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userUsername: UILabel!
    
    var sessionInfo = session()    

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.layer.borderWidth = 1
        profileImg.layer.masksToBounds = false
        profileImg.layer.borderColor = UIColor.black.cgColor
        profileImg.layer.cornerRadius = profileImg.frame.height/2
        profileImg.clipsToBounds = true
        loadUserInfo()

        // Do any additional setup after loading the view.
    }
    
    func loadUserInfo()
    {
        profileImg.image = UIImage(named: sessionInfo.user_img)
        userUsername.text = sessionInfo.user_username
        userFullName.text = sessionInfo.user_name
    }
    
    @IBAction func editProfileImg(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    self.openCamera()
                }))
                
                alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                    self.openGallery()
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Warning", message: "You don't have permission to access the camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        func openGallery(){
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Warning", message: "You don't have permission to access the gallery", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[.originalImage] as? UIImage{
                self.profileImg.image = pickedImage
                self.sessionInfo.user_img = pickedImage.toString()!
            }
            picker.dismiss(animated: true, completion: nil)
        }
    
    @IBAction func backButton(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is homePage {
            let vc = segue.destination as? homePage
            
            vc?.sessionInfo = self.sessionInfo
        }
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

extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
