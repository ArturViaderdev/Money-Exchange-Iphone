//
//  Controladoradmin.swift
//  MoneyExchangeArtur
//
//  Created by Artur Viader Mataix on 4/11/18.
//  Copyright © 2018 Artur Viader Mataix. All rights reserved.
//

import UIKit
//Clase que controla la segunda ventana y el pickerview de esta
class Controladoradmin: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    //Botón para volver a la ventana principal
    @IBAction func bcancel(_ sender: UIButton) {
        //Se cierra la ventana actual
        self.dismiss(animated: true, completion: nil)
    }
    //Botón para guardar el cambio
    @IBAction func bapply(_ sender: UIButton) {
        //Convierto lo que ha introducido el usuario a numérico
        let entrada:Double = Double(tentrada.text!) ?? 0
        if(nodetectaerror(entrada: entrada))
        {
            if(Variables.monedas[seleccionado].nombre != "dollar")
            {
                //Introduzco el nuevo valor de la moneda en la lista
                Variables.monedas[seleccionado].valordolares = entrada
                //se informa del cambio en el label
                lactual.text = "The new value \(Variables.monedas[seleccionado].nombre) is \(Variables.monedas[seleccionado].valordolares)"
                
                //let preferences = UserDefaults.standard
                // preferences.set(Variables.monedas[seleccionado].valordolares, forKey: Variables.monedas[seleccionado].nombre)
            }
            else
            {
                muestralerta(mensaje: "You cannot modifify the dollar value.")
            }
        }
    }
    
    @IBOutlet weak var lactual: UILabel!
    //Campo de texto donde el usuario introduce el nuevo valor
    @IBOutlet weak var tentrada: UITextField!
    //Pickerview para seleccionar moneda a cambiar el valor
    @IBOutlet weak var selecciona: UIPickerView!
    //recuerda que ha seleccionado el pickerview
    var seleccionado:Int = 0

    //Se carga al abrirse la segunda ventana
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //La clase encargada de manejar el pickerview de la segunda ventana es esta
        selecciona.delegate = self
        selecciona.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //Detecta cuando el usuario cambia la selección del pickerview
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        seleccionado = row
    }
    
    //Número de columnas del pickerview 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Número de elementos
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //Cuantas monedas hay
       return Variables.monedas.count

    }
    
    //Datos del pickerview
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width-30, height: 60))
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        myImageView.image = UIImage(named: Variables.monedas[row].nombre)
        let myLabel = UILabel(frame: CGRect(x: 60, y: 0, width: pickerView.bounds.width-90, height: 60))
        myLabel.font = UIFont(name: "ArialMT", size: 18)
        myLabel.text = Variables.monedas[row].nombre
        myView.addSubview(myLabel)
        myView.addSubview(myImageView)
        
        return myView
        
    }
    
    //func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> UIView? {
    //func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        
        
        //recoge nombres de monedas
        //return Variables.monedas[row].nombre
    //}
    
    func muestralerta(mensaje:String)
    {
        let alerta = UIAlertController(title: "Alerta", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Acción por defecto"), style: .default, handler: { _ in NSLog("The \"OK\" alert occured.")
        }))
        self.present(alerta, animated: true, completion: nil)
    }
    
    func nodetectaerror(entrada:Double) -> Bool
    {
        var salida = false
        if(entrada==0)
        {
            muestralerta(mensaje: "Not valid value")
        }
        else if(entrada>9999999)
        {
            muestralerta(mensaje: "Too big value")
        }
        else if(entrada<0)
        {
            muestralerta(mensaje: "The value cannot be negative")
        }
        else
        {
            salida = true;
        }
        print(salida)
        return salida
    }
}
