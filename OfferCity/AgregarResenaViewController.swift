//
//  AgregarResenaViewController.swift
//  OfferCity
//
//  Created by ginppian on 24/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class AgregarResenaViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var floatRatingComida: FloatRatingView!
    @IBOutlet weak var floatRatingServicio: FloatRatingView!
    @IBOutlet weak var floatRatingLimpieza: FloatRatingView!
    @IBOutlet weak var buttonEnviar: UIButton!
    
    // MARK: - Constructor
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    @IBAction func buttonEnviarActions(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
        print("Pop 👀")
    }
    
}

// MARK: - Life Cycle

extension AgregarResenaViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Setup Navigation Bar
        
        setupNavigationBar()
        
        // Setup Button Enviar
        
        setupButtonEnviar()
        
        // Setup Float Rating Views
        
        setupFloatRatingViews()
        
        // Setup Text View
        
        setupTextView()
        
        // Setup Text Field
        
        setupTextField()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default // Hora y Pila
    }
}

// MARK: - View

extension AgregarResenaViewController {
    
    func setupButtonEnviar() {
    
        self.buttonEnviar.layer.cornerRadius = 21
    }
}

// MARK: - Navigation Bar

extension AgregarResenaViewController {
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "azulOffer"), for: .default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black // Hora y Pila
        self.navigationController?.navigationBar.tintColor = UIColor.white // ??
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white] // Texto
    }
    
}

// MARK: - Float Rating

extension AgregarResenaViewController {
    
    func setupFloatRatingViews() {
        
        // Load Image
        
        floatRatingComida.emptyImage = #imageLiteral(resourceName: "emptyStar")
        floatRatingComida.fullImage = #imageLiteral(resourceName: "fullStar")
        
        floatRatingServicio.emptyImage = #imageLiteral(resourceName: "emptyStar")
        floatRatingServicio.fullImage = #imageLiteral(resourceName: "fullStar")
        
        floatRatingLimpieza.emptyImage = #imageLiteral(resourceName: "emptyStar")
        floatRatingLimpieza.fullImage = #imageLiteral(resourceName: "fullStar")
        
        // Delegate
        
        floatRatingComida.delegate = self
        floatRatingServicio.delegate = self
        floatRatingServicio.delegate = self
        
        // Settings
        
        self.floatRatingComida.backgroundColor = UIColor.white
        self.floatRatingComida.contentMode = UIViewContentMode.scaleAspectFit
        self.floatRatingComida.maxRating = 5
        self.floatRatingComida.minRating = 1
        self.floatRatingComida.rating = 2.5
        self.floatRatingComida.editable = true
        self.floatRatingComida.halfRatings = false
        self.floatRatingComida.floatRatings = true
        
        self.floatRatingServicio.backgroundColor = UIColor.white
        self.floatRatingServicio.contentMode = UIViewContentMode.scaleAspectFit
        self.floatRatingServicio.maxRating = 5
        self.floatRatingServicio.minRating = 1
        self.floatRatingServicio.rating = 2.5
        self.floatRatingServicio.editable = true
        self.floatRatingServicio.halfRatings = false
        self.floatRatingServicio.floatRatings = true
        
        self.floatRatingLimpieza.backgroundColor = UIColor.white
        self.floatRatingLimpieza.contentMode = UIViewContentMode.scaleAspectFit
        self.floatRatingLimpieza.maxRating = 5
        self.floatRatingLimpieza.minRating = 1
        self.floatRatingLimpieza.rating = 2.5
        self.floatRatingLimpieza.editable = true
        self.floatRatingLimpieza.halfRatings = false
        self.floatRatingLimpieza.floatRatings = true
        
        // Tag
        
        self.floatRatingComida.tag = 1
        self.floatRatingServicio.tag = 2
        self.floatRatingLimpieza.tag = 3
    }
}

// MARK: Float Rating Delegate

extension AgregarResenaViewController: FloatRatingViewDelegate {
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating:Float) {
        

    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        
        print(ratingView)
        print(rating)
    }
    
}

// MARK: - Text View

extension AgregarResenaViewController: UITextViewDelegate {

    func setupTextView() {
        
        self.textView.delegate = self
        self.textView.tag = 1 // Primera Vez
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        print("Begin Edit...")
        
        if self.textView.tag == 1 {
            
            self.textView.tag = 0
            self.textView.textColor = UIColor.black
            self.textView.text = nil
        }
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        
        if(text == "\n") {
            
            self.textView.endEditing(true)
            return false
        } else {
            
            return true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.textView.endEditing(true)
        self.textField.endEditing(true)
    }
    
}

// MARK: - Text View

extension AgregarResenaViewController: UITextFieldDelegate {
    
    func setupTextField() {
        
        self.textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.textField.resignFirstResponder()
        return true
    }
}











