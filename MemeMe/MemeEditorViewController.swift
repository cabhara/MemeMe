//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Christina Bharara on 3/19/17.
//  Copyright © 2017 cabhara. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var albumButton: UIBarButtonItem!
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    var meme:Meme?
    
    var topNotEdited = true
    var bottomNotEdited = true
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(textField: topTextField, text: "TOP")
        configure(textField: bottomTextField, text: "BOTTOM")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func configure(textField: UITextField, text: String){
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "Impact", size: 40)!,
            NSStrokeWidthAttributeName: "-3.0",
            NSParagraphStyleAttributeName: style]

        textField.text = text
        textField.defaultTextAttributes = memeTextAttributes
    }
    
    //MARK: - IBActions
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if sender == cameraButton{
            imagePicker.sourceType = .camera
        } else{
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        guard imagePickerView.image != nil else {
            showAlert("Issue sharing meme", message: "Please select an image")
            return
        }
        
        //generate and save meme
        let memedImage = generateMemedImage()
        //share
        let image = [ memedImage ]
        let activityViewController = UIActivityViewController(activityItems: image, applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {
            (s, ok, items, err) in
            if !ok {
                return
            }
            self.save(memedImage: memedImage)
            self.dismiss(animated: true, completion: nil)
        }
        
        // present the view controller
        present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: - Image functions
    func save(memedImage:UIImage) {
        // save the meme
        meme = Meme(top:topTextField.text!, bottom: bottomTextField.text!, original: imagePickerView.image!, memed: memedImage)
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //do something
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //do somthing
        dismiss(animated: true, completion: nil)
    }
    
    func configureBars(hidden:Bool){
        if hidden {
            //hide
            navBar.isHidden = true
            toolBar.isHidden = true
        } else{
            //hide
            navBar.isHidden = false
            toolBar.isHidden = false
        }
    }
    
    func generateMemedImage() -> UIImage {
        //hide
        configureBars(hidden: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //show
        configureBars(hidden: false)
        
        return memedImage
    }
    
    //MARK: - Alert
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - KeyBoard
    func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    //MARK: - TextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField==topTextField && topNotEdited {
            topNotEdited = false
            textField.text = ""
        } else if textField==bottomTextField && bottomNotEdited {
            bottomNotEdited = false
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }



}

