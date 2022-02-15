//
//  AutenticacaoLocal.swift
//  Alura Ponto
//
//  Created by Ana Carolina Ferreira on 14/02/22.
//

import Foundation
import LocalAuthentication

class AutenticacaoLocal {
    let authenticatorContext = LAContext()
    var error: NSError?
    
    func autorizaUsuario(completion: @escaping(_ autenticacao: Bool) -> Void) {
        if authenticatorContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authenticatorContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "É necessário autenticação para apagar um recibo.") { sucesso, erro in
                DispatchQueue.main.async {
                    completion(sucesso)
                }
            }
        }
    }
}
