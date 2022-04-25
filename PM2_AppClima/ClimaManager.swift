//
//  ClimaManager.swift
//  PM2_AppClima
//
//  Created by Alexander Tapia on 23/04/22.
//

import Foundation

protocol ClimaManagerDelegado {
    
    func actualizarClima(objClima: ClimaModelo)
    func huboEror(error: Error)
}


struct ClimaManager {
    
    let climaURL="https://api.openweathermap.org/data/2.5/weather?appid=d312747904d04909dfaf8f7d3fcaa718&lang=es"
    var delegado: ClimaManagerDelegado?
    
   // var delegado:ClimaManagerDelegado?
    
    func obtenerClima(nombreCiudad: String){
        let urlString="\(climaURL)&q=\(nombreCiudad)"
        print(urlString)
        realizarSolicitud(urlString: urlString)
    }
    
    
    func realizarSolicitud(urlString: String){
        if let url=URL(string: urlString){
            let session=URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) { (datos, respuesta, error) in
                if error != nil {
                    print("Error al obtener los datos")
                    return
                }
                
                if let datosSeguros = datos {
                    //parsear JSON
                    if let objClima = self.parsearJSON(datosClima: datosSeguros){
                        //let ClimaVC = ViewController()
                        //ClimaVC.actualizarClima(objclima: objC)
                        self.delegado?.actualizarClima(objClima: objClima)
                    }
                    
                }
            }
            tarea.resume()
        }
        
    }
    
    func parsearJSON(datosClima: Data) -> ClimaModelo? {
        let decodificador = JSONDecoder()
        do {
            let datosDecodificados = try decodificador.decode(DatosClima.self, from: datosClima)
            let condicionID = datosDecodificados.weather[0].id
            let descripcion = datosDecodificados.weather[0].description
            let nombreCiudad = datosDecodificados.name
            let temperatura = datosDecodificados.main.temp
            let min = datosDecodificados.main.temp_min
            let max = datosDecodificados.main.temp_max
            print(datosDecodificados.name)
            
            let objClima = ClimaModelo (condicionID: condicionID, nombreCiudad: nombreCiudad, temperatura: temperatura, description: descripcion, maxima: max, minima: min)
            
            return objClima
            
        } catch {
            print("Error al decodificar"+error.localizedDescription)
            return nil
        }
        
        
    }
   
}
