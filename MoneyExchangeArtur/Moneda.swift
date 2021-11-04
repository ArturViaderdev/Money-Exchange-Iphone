//
//  Moneda.swift
//  MoneyExchangeArtur
//
//  Created by Artur Viader Mataix on 30/10/2018.
//  Copyright © 2018 Artur Viader Mataix. All rights reserved.
//

import Foundation

//Clase que guarda una moneda con todos sus datos
//No es necesario guardar las imágenes ya que tienen el mismo nombre que la moneda
class Moneda: NSObject,NSCoding
{
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nombre, forKey: "nombre")
        aCoder.encode(valordolares, forKey: "valordolares")
        aCoder.encode(simbolo, forKey: "simbolo")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let nombre = aDecoder.decodeObject(forKey: "nombre") as! String
        let valordolares = aDecoder.decodeDouble(forKey: "valordolares")
        let simbolo = aDecoder.decodeObject(forKey: "simbolo") as! String
        self.init(nombre: nombre, valordolares: valordolares, simbolo: simbolo)
    }
    
    var nombre:String
    var valordolares:Double
    var simbolo:String
   
    //Constructor con todos los datos
    init(nombre:String,valordolares:Double,simbolo:String)
    {
        //Se cargan los valores
        self.nombre = nombre
        self.valordolares = valordolares
        self.simbolo = simbolo
    }
}
