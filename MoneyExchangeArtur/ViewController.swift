//
//  ViewController.swift
//  MoneyExchangeArtur
//
//  Created by Artur Viader Mataix on 30/10/2018.
//  Copyright © 2018 Artur Viader Mataix. All rights reserved.
//

import UIKit

//Controlador de la pantalla principal
class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //Variable del label que muestra la conversión
    @IBOutlet weak var lconversion: UILabel!
    //Variable que contiene el cuadro de imagen de fondo
    @IBOutlet weak var ifondo: UIImageView!
    //Variable que contiene el cuadro de imagen de la moneda actual
    @IBOutlet weak var imoneda: UIImageView!
    //Variable que contiene el objeto label que muestra el valor en dólares de la moneda actual
    @IBOutlet weak var lvalordolares: UILabel!
    //Contiene el label que muestra el nombre de la moneda
    @IBOutlet weak var lnombremoneda: UILabel!
    //La caja de texto donde el usuario introduce números
    @IBOutlet weak var tentrada: UITextField!
    //El label que muestra el resultado de la conversión
    @IBOutlet weak var tresultado: UILabel!
    //El pickerview que nos permite seleccionar moneda de origen y de destino
    @IBOutlet weak var selecciona: UIPickerView!
    //Guarda el número de moneda en la lista que se ha seleccionado en la parte izquierda del pickerview.
    var seleccionado:Int = 0
    //Guarda el número de moneda en la lista que se ha seleccionado en la parte derecha del pickerview.
    var seleccionadob:Int = 0
    //Guarda la posición de la visualización del valor de una moneda
    var posicionactual:Int = 0
    
    //Click en el botón de ir atrás cambiando moneda
    @IBAction func bantes(_ sender: UIButton) {
        if(posicionactual>0)
        {
            //Se va a la posición anterior
            posicionactual-=1
        }
        else
        {
            //Si estábamos en la posición 0 vamos a la última
            posicionactual=Variables.monedas.count-1
        }
        //Mostramos los datos de la moneda que ahora es la actual
        refrescamoneda()
    }
    //Click en el botón de siguiente cambiando moneda
    @IBAction func bdespues(_ sender: UIButton) {
        if(posicionactual<Variables.monedas.count-1)
        {
            //Se va a la posición siguiente
            posicionactual+=1
        }
        else
        {
            //Si estábamos en el último elemento volvemos al primero
            posicionactual=0
        }
        //Mostramos datos de la moneda actual
        refrescamoneda()
    }
    
    //Muestra una alerta al usuario
    func muestralerta(mensaje:String)
    {
        let alerta = UIAlertController(title: "Alerta", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Acción por defecto"), style: .default, handler: { _ in NSLog("The \"OK\" alert occured.")
        }))
        self.present(alerta, animated: true, completion: nil)
    }
  
    //Detecta si hay un error de entrada
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
    
    //Botón de conversión
    @IBAction func bconvert(_ sender: Any) {
        //Se guarda el valor del campo de entra transformado a numérico 
        let entrada:Double = Double(tentrada.text!) ?? 0
      
        
        
        var dolares:Double
        var monedadestino:Double
        
        //Si el usuario introduce 999
        if(entrada==999)
        {
            //Se muestra la pantalla de administración
            performSegue(withIdentifier: "cambiapantalla", sender: self)
        }
        else
        {
            if(nodetectaerror(entrada: entrada))
            {
                //Se realiza la conversión
                //Obtenemos el valor en dólares de lo que el usuario ha introducido
                dolares = entrada / Variables.monedas[seleccionado].valordolares
                //Obtenemos el valor en la moneda destino de los dólares
                monedadestino = dolares * Variables.monedas[seleccionadob].valordolares
                //Mostramos el resultado
                tresultado.text = "\(monedadestino) \(Variables.monedas[seleccionadob].simbolo)"
                //Mostramos el tipo de conversión
                lconversion.text = "This conversion from \(Variables.monedas[seleccionado].nombre)s to \(Variables.monedas[seleccionadob].nombre)s"
            }
        }
    }
   
    //Pone en los campos o actualiza la información de la moneda actual
    func refrescamoneda()
    {
        //nombre de la moneda
        lnombremoneda.text = Variables.monedas[posicionactual].nombre
        //valor en dólares
        lvalordolares.text = "\(String(Variables.monedas[posicionactual].valordolares)) USD"
        //se carga la imagen de la moneda que tiene el mismo nombre que esta
        imoneda.image = UIImage(named: Variables.monedas[posicionactual].nombre)
        //se carga la imagen de fondo de la moneda que tiene el mismo nombre con una f al final
        ifondo.image = UIImage(named: "\(Variables.monedas[posicionactual].nombre)f")
    }
    
    //Cuando el usuario selecciona algo en el pickerview
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component{
        case 0:
            //Si ha cambiado la primera columna se guarda la posición
            seleccionado = row
        case 1:
            //Si ha cambiado la segunda columna se guarda la posición
            seleccionadob = row
        default:
            print("nunca entra aquí")
        }
    }
    
    //Cuantos componentes tiene el picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //Tiene dos componentes
        return 2
    }
    
    //Cuantos elementos tiene la lista
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //Número de monedas en la lista
        return Variables.monedas.count
    }
    
    //Muestra monedas con imágenes
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width/2-30, height: 60))
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        myImageView.image = UIImage(named: Variables.monedas[row].nombre)
        let myLabel = UILabel(frame: CGRect(x: 60, y: 0, width: pickerView.bounds.width/2-90, height: 60))
        myLabel.font = UIFont(name: "ArialMT", size: 18)
        myLabel.text = Variables.monedas[row].nombre
        myView.addSubview(myLabel)
        myView.addSubview(myImageView)
        return myView
    }
    
    //Recoge el valor de cada elemento de la lista
   /* func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //Valor de la lista de monedas
        return Variables.monedas[row].nombre
    }*/
    
    //Crea las monedas por defecto
    func creamonedas()
    {
        Variables.monedas.append(Moneda(nombre: "euro", valordolares: 0.878545,simbolo:"EUR"))
        Variables.monedas.append(Moneda(nombre: "pound", valordolares: 0.7703,simbolo:"GBP"))
        Variables.monedas.append(Moneda(nombre: "bitcoin", valordolares: 0.0001551185,simbolo:"BTC"))
        Variables.monedas.append(Moneda(nombre: "yen", valordolares: 113.205,simbolo:"JPY"))
        Variables.monedas.append(Moneda(nombre: "dollar", valordolares: 1,simbolo:"USD"))
        Variables.monedas.append(Moneda(nombre: "rupia", valordolares: 73.047178461282,simbolo:"RS"))
        Variables.monedas.append(Moneda(nombre: "yuan", valordolares: 6.9198218614531,simbolo:"CNY"))
        
    }
    
    //Se refresca la moneda al volver de la segunda pantalla
    override func viewDidAppear(_ animated: Bool) {
        refrescamoneda()
    }
    
    //Al iniciar la app
    override func viewDidLoad() {
        super.viewDidLoad()
        //Crea las monedas por defecto
     
        let userdefaults = UserDefaults.standard
        
        let monedasData = userdefaults.object(forKey: "monedas")
        
        if monedasData != nil{
            do
            {
                Variables.monedas = (try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(monedasData as!Data))as![Moneda]
            }
            catch{
                creamonedas();
            }
        }
        else
        {
            creamonedas();
        }
        
        /*
        var cont=0
        while(cont<Variables.monedas.count)
        {
            if preferences.string(forKey: Variables.monedas[cont].nombre) != nil{
                Variables.monedas[cont].valordolares = preferences.double(forKey: Variables.monedas[cont].nombre)
            }
            cont+=1
        }
        */
        
        //La clase que se encarga de manejar los eventos del pickerview es esta misma
        selecciona.delegate = self
        selecciona.dataSource = self
        //Se muestra la moneda actual , la primera
        refrescamoneda()
    }
}
