//
//  Product.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/28/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Product: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let titulo = "titulo"
        static let precoAntigo = "precoAntigo"
        static let precoAtual = "precoAtual"
        static let precoParcelado = "precoParcelado"
        static let quantidadeVezesParcelamento = "quantidadeVezesParcelamento"
        static let urlImagem = "urlImagem"
    }
    
    // MARK: Properties
    public var titulo: String?
    public var precoAntigo: String?
    public var precoAtual: String?
    public var precoParcelado: String?
    public var quantidadeVezesParcelamento: Int?
    public var urlImagem: String?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        titulo = json[SerializationKeys.titulo].string
        precoAntigo = json[SerializationKeys.precoAntigo].string
        precoAtual = json[SerializationKeys.precoAtual].string
        precoParcelado = json[SerializationKeys.precoParcelado].string
        quantidadeVezesParcelamento = json[SerializationKeys.quantidadeVezesParcelamento].int
        urlImagem = json[SerializationKeys.urlImagem].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary[SerializationKeys.titulo] = titulo
        dictionary[SerializationKeys.precoAntigo] = precoAntigo
        dictionary[SerializationKeys.precoAtual] = precoAtual
        dictionary[SerializationKeys.precoParcelado] = precoParcelado
        dictionary[SerializationKeys.quantidadeVezesParcelamento] = quantidadeVezesParcelamento
        dictionary[SerializationKeys.urlImagem] = urlImagem
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.titulo = aDecoder.decodeObject(forKey: SerializationKeys.titulo) as? String
        self.precoAntigo = aDecoder.decodeObject(forKey: SerializationKeys.precoAntigo) as? String
        self.precoAtual = aDecoder.decodeObject(forKey: SerializationKeys.precoAtual) as? String
        self.precoParcelado = aDecoder.decodeObject(forKey: SerializationKeys.precoParcelado) as? String
        self.quantidadeVezesParcelamento = aDecoder.decodeObject(forKey: SerializationKeys.quantidadeVezesParcelamento) as? Int
        self.urlImagem = aDecoder.decodeObject(forKey: SerializationKeys.urlImagem) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(titulo, forKey: SerializationKeys.titulo)
        aCoder.encode(precoAntigo, forKey: SerializationKeys.precoAntigo)
        aCoder.encode(precoAtual, forKey: SerializationKeys.precoAtual)
        aCoder.encode(precoParcelado, forKey: SerializationKeys.precoParcelado)
        aCoder.encode(quantidadeVezesParcelamento, forKey: SerializationKeys.quantidadeVezesParcelamento)
        aCoder.encode(urlImagem, forKey: SerializationKeys.urlImagem)
    }
    
}
