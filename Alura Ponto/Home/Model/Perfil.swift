//
//  Perfil.swift
//  Alura Ponto
//
//  Created by Ana Carolina Ferreira on 14/02/22.
//

import UIKit

class Perfil {
    
    private let nomeDaFoto = "perfil.png"
    
    func saveImage(_ image: UIImage) {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let urlDoArquivo = diretorio.appendingPathComponent(nomeDaFoto)
        
        if FileManager.default.fileExists(atPath: urlDoArquivo.path) {
            // remover a foto
            removeOldImage(urlDoArquivo.path)
        }
        
        guard let imagemData = image.jpegData(compressionQuality: 1) else { return }
        
        do {
            try imagemData.write(to: urlDoArquivo)
        } catch let erro {
            print(erro)
        }
        
    }
    
    func removeOldImage(_ url: String) {
        do {
            try FileManager.default.removeItem(atPath: url)
        } catch let erro {
            print(erro)
        }
    }
    
    func loadImage() -> UIImage? {
        
        let diretorio = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        
        let urlDoArquivo = NSSearchPathForDirectoriesInDomains(diretorio, userDomainMask, true)
        
        if let caminho = urlDoArquivo.first {
            let urlDaImagem = URL(fileURLWithPath: caminho).appendingPathComponent(nomeDaFoto)
            
            let imagem = UIImage(contentsOfFile: urlDaImagem.path)
            
            return imagem
        }
        
        return nil
    }
}
