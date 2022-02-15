//
//  Localizacao.swift
//  Alura Ponto
//
//  Created by Ana Carolina Ferreira on 14/02/22.
//

import Foundation
import CoreLocation

protocol LocalizacaoDelegate: AnyObject {
    func atualizaLocalizacaoDoUsuario(latitude: Double?, longitude: Double?)
}

class Localizacao: NSObject {
    
    private var latitude: CLLocationDegrees?
    private var longitude: CLLocationDegrees?
    
    weak var delegate: LocalizacaoDelegate?
    
    func permissao(_ manager: CLLocationManager) {
        manager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                manager.startUpdatingLocation()
                break
            case .denied:
                break
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            default:
                break
            }
        }
    }
}

extension Localizacao: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let localizacao = locations.first {
            latitude = localizacao.coordinate.latitude
            longitude = localizacao.coordinate.longitude
        }
        
        self.delegate?.atualizaLocalizacaoDoUsuario(latitude: latitude, longitude: longitude)
    }
}
