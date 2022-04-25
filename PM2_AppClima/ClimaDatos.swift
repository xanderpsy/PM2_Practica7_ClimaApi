//
//  ClimaDatos.swift
//  PM2_AppClima
//
//  Created by Alexander Tapia on 23/04/22.
//

import Foundation
 

struct DatosClima: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let base: String
}

struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    
}

struct Weather: Decodable {
    
    let description: String
    let id: Int
}
