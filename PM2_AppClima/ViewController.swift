//
//  ViewController.swift
//  PM2_AppClima
//
//  Created by Alexander Tapia on 23/04/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, ClimaManagerDelegado {
   
    func actualizarClima(objClima: ClimaModelo) {
            DispatchQueue.main.async {
                self.temperaturaLabel.text = objClima.temperaturaString
                self.ciudadLabel.text = objClima.nombreCiudad
                self.descriptionLabel.text = objClima.description
                self.maxLabel.text = "\(objClima.maxima)ºC"
                self.minLabel.text = "\(objClima.minima)ºC"
                self.condicionClimaImageView.image = UIImage(systemName: objClima.nombreCondicion)
                self.fondoimageView.image = UIImage(named: objClima.fondoCondicion)
                
            }
        }
        
        func huboEror(error: Error) {
            
        }
    
    @IBOutlet weak var buscarTExtField: UITextField!
    
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var condicionClimaImageView: UIImageView!
    @IBOutlet weak var fondoimageView: UIImageView!
    var climaManager = ClimaManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buscarTExtField.delegate = self
        climaManager.delegado = self
    }

    
    @IBAction func buscarButton(_ sender: UIButton) {
        buscarTExtField.endEditing(true)
        print(buscarTExtField.text!)
      //  ciudadLabel.text = buscarTExtField.text
    }
    
    @IBAction func buscarGPSButton(_ sender: UIButton) {
    }
    
    //metodos del delegado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       //Metodo para ocultar el teclado virtual
        
        
        buscarTExtField.endEditing(true)
        print(buscarTExtField.text!)
       // ciudadLabel.text = buscarTExtField.text
        //buscarTExtField.text = ""
        //Realizar ka busqueda en la api
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if buscarTExtField.text != "" {
            return true
        }else{
            buscarTExtField.placeholder = "escribe algo"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       //limpiar textfield
        climaManager.obtenerClima(nombreCiudad: buscarTExtField.text!)
        buscarTExtField.text = ""
    }
    
   
}

