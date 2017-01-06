//
//  Address.swift
//
//  Created by Arthur Augusto Sousa Marques on 1/6/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Address: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let dataHoraStatus = "dataHoraStatus"
    static let numero = "numero"
    static let idPessoa = "idPessoa"
    static let logradouro = "logradouro"
    static let bairro = "bairro"
    static let complemento = "complemento"
    static let descStatus = "descStatus"
    static let status = "status"
    static let idUsuarioInclusao = "idUsuarioInclusao"
    static let idTipoEndereco = "idTipoEndereco"
    static let idEndereco = "idEndereco"
    static let cidade = "cidade"
    static let uf = "uf"
    static let tipoEndereco = "tipoEndereco"
    static let cep = "cep"
  }

  // MARK: Properties
  public var dataHoraStatus: String?
  public var numero: Int?
  public var idPessoa: Int?
  public var logradouro: String?
  public var bairro: String?
  public var complemento: String?
  public var descStatus: String?
  public var status: Int?
  public var idUsuarioInclusao: Int?
  public var idTipoEndereco: Int?
  public var idEndereco: Int?
  public var cidade: String?
  public var uf: String?
  public var tipoEndereco: TipoEndereco?
  public var cep: Int?

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
    dataHoraStatus = json[SerializationKeys.dataHoraStatus].string
    numero = json[SerializationKeys.numero].int
    idPessoa = json[SerializationKeys.idPessoa].int
    logradouro = json[SerializationKeys.logradouro].string
    bairro = json[SerializationKeys.bairro].string
    complemento = json[SerializationKeys.complemento].string
    descStatus = json[SerializationKeys.descStatus].string
    status = json[SerializationKeys.status].int
    idUsuarioInclusao = json[SerializationKeys.idUsuarioInclusao].int
    idTipoEndereco = json[SerializationKeys.idTipoEndereco].int
    idEndereco = json[SerializationKeys.idEndereco].int
    cidade = json[SerializationKeys.cidade].string
    uf = json[SerializationKeys.uf].string
    tipoEndereco = TipoEndereco(json: json[SerializationKeys.tipoEndereco])
    cep = json[SerializationKeys.cep].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = dataHoraStatus { dictionary[SerializationKeys.dataHoraStatus] = value }
    if let value = numero { dictionary[SerializationKeys.numero] = value }
    if let value = idPessoa { dictionary[SerializationKeys.idPessoa] = value }
    if let value = logradouro { dictionary[SerializationKeys.logradouro] = value }
    if let value = bairro { dictionary[SerializationKeys.bairro] = value }
    if let value = complemento { dictionary[SerializationKeys.complemento] = value }
    if let value = descStatus { dictionary[SerializationKeys.descStatus] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = idUsuarioInclusao { dictionary[SerializationKeys.idUsuarioInclusao] = value }
    if let value = idTipoEndereco { dictionary[SerializationKeys.idTipoEndereco] = value }
    if let value = idEndereco { dictionary[SerializationKeys.idEndereco] = value }
    if let value = cidade { dictionary[SerializationKeys.cidade] = value }
    if let value = uf { dictionary[SerializationKeys.uf] = value }
    if let value = tipoEndereco { dictionary[SerializationKeys.tipoEndereco] = value.dictionaryRepresentation() }
    if let value = cep { dictionary[SerializationKeys.cep] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.dataHoraStatus = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraStatus) as? String
    self.numero = aDecoder.decodeObject(forKey: SerializationKeys.numero) as? Int
    self.idPessoa = aDecoder.decodeObject(forKey: SerializationKeys.idPessoa) as? Int
    self.logradouro = aDecoder.decodeObject(forKey: SerializationKeys.logradouro) as? String
    self.bairro = aDecoder.decodeObject(forKey: SerializationKeys.bairro) as? String
    self.complemento = aDecoder.decodeObject(forKey: SerializationKeys.complemento) as? String
    self.descStatus = aDecoder.decodeObject(forKey: SerializationKeys.descStatus) as? String
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? Int
    self.idUsuarioInclusao = aDecoder.decodeObject(forKey: SerializationKeys.idUsuarioInclusao) as? Int
    self.idTipoEndereco = aDecoder.decodeObject(forKey: SerializationKeys.idTipoEndereco) as? Int
    self.idEndereco = aDecoder.decodeObject(forKey: SerializationKeys.idEndereco) as? Int
    self.cidade = aDecoder.decodeObject(forKey: SerializationKeys.cidade) as? String
    self.uf = aDecoder.decodeObject(forKey: SerializationKeys.uf) as? String
    self.tipoEndereco = aDecoder.decodeObject(forKey: SerializationKeys.tipoEndereco) as? TipoEndereco
    self.cep = aDecoder.decodeObject(forKey: SerializationKeys.cep) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(dataHoraStatus, forKey: SerializationKeys.dataHoraStatus)
    aCoder.encode(numero, forKey: SerializationKeys.numero)
    aCoder.encode(idPessoa, forKey: SerializationKeys.idPessoa)
    aCoder.encode(logradouro, forKey: SerializationKeys.logradouro)
    aCoder.encode(bairro, forKey: SerializationKeys.bairro)
    aCoder.encode(complemento, forKey: SerializationKeys.complemento)
    aCoder.encode(descStatus, forKey: SerializationKeys.descStatus)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(idUsuarioInclusao, forKey: SerializationKeys.idUsuarioInclusao)
    aCoder.encode(idTipoEndereco, forKey: SerializationKeys.idTipoEndereco)
    aCoder.encode(idEndereco, forKey: SerializationKeys.idEndereco)
    aCoder.encode(cidade, forKey: SerializationKeys.cidade)
    aCoder.encode(uf, forKey: SerializationKeys.uf)
    aCoder.encode(tipoEndereco, forKey: SerializationKeys.tipoEndereco)
    aCoder.encode(cep, forKey: SerializationKeys.cep)
  }

    public func fullDescription() -> String {
        var string = ""
        
        if let value = self.logradouro {
            string += "\(value)"
        }
        
        if let value = self.numero {
            string += " \(value)"
        }
        
        if let value = self.complemento {
            string += " \(value)"
        }
        
        if let value = self.cidade {
            string += ", \(value)"
        }
        
        if let value = self.bairro {
            string += ", \(value)"
        }
        
        if let value = self.uf {
            string += ", \(value)"
        }
        
        return string
    }
}
