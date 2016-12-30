//
//  Unidades.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/29/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Unidades: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let numero = "numero"
    static let dddTelefone1 = "dddTelefone1"
    static let nomeResponsavel = "nomeResponsavel"
    static let logradouro = "logradouro"
    static let bairro = "bairro"
    static let complemento = "complemento"
    static let latitude = "latitude"
    static let observacoes = "observacoes"
    static let dddTelefone2 = "dddTelefone2"
    static let telefone1 = "telefone1"
    static let cidade = "cidade"
    static let uf = "uf"
    static let idParceiro = "idParceiro"
    static let longitude = "longitude"
    static let telefone2 = "telefone2"
    static let idUnidade = "idUnidade"
    static let cep = "cep"
  }

  // MARK: Properties
  public var numero: String?
  public var dddTelefone1: Int?
  public var nomeResponsavel: String?
  public var logradouro: String?
  public var bairro: String?
  public var complemento: String?
  public var latitude: Int?
  public var observacoes: String?
  public var dddTelefone2: Int?
  public var telefone1: Int?
  public var cidade: String?
  public var uf: String?
  public var idParceiro: Int?
  public var longitude: Int?
  public var telefone2: Int?
  public var idUnidade: Int?
  public var cep: String?

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
    numero = json[SerializationKeys.numero].string
    dddTelefone1 = json[SerializationKeys.dddTelefone1].int
    nomeResponsavel = json[SerializationKeys.nomeResponsavel].string
    logradouro = json[SerializationKeys.logradouro].string
    bairro = json[SerializationKeys.bairro].string
    complemento = json[SerializationKeys.complemento].string
    latitude = json[SerializationKeys.latitude].int
    observacoes = json[SerializationKeys.observacoes].string
    dddTelefone2 = json[SerializationKeys.dddTelefone2].int
    telefone1 = json[SerializationKeys.telefone1].int
    cidade = json[SerializationKeys.cidade].string
    uf = json[SerializationKeys.uf].string
    idParceiro = json[SerializationKeys.idParceiro].int
    longitude = json[SerializationKeys.longitude].int
    telefone2 = json[SerializationKeys.telefone2].int
    idUnidade = json[SerializationKeys.idUnidade].int
    cep = json[SerializationKeys.cep].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = numero { dictionary[SerializationKeys.numero] = value }
    if let value = dddTelefone1 { dictionary[SerializationKeys.dddTelefone1] = value }
    if let value = nomeResponsavel { dictionary[SerializationKeys.nomeResponsavel] = value }
    if let value = logradouro { dictionary[SerializationKeys.logradouro] = value }
    if let value = bairro { dictionary[SerializationKeys.bairro] = value }
    if let value = complemento { dictionary[SerializationKeys.complemento] = value }
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = observacoes { dictionary[SerializationKeys.observacoes] = value }
    if let value = dddTelefone2 { dictionary[SerializationKeys.dddTelefone2] = value }
    if let value = telefone1 { dictionary[SerializationKeys.telefone1] = value }
    if let value = cidade { dictionary[SerializationKeys.cidade] = value }
    if let value = uf { dictionary[SerializationKeys.uf] = value }
    if let value = idParceiro { dictionary[SerializationKeys.idParceiro] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    if let value = telefone2 { dictionary[SerializationKeys.telefone2] = value }
    if let value = idUnidade { dictionary[SerializationKeys.idUnidade] = value }
    if let value = cep { dictionary[SerializationKeys.cep] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.numero = aDecoder.decodeObject(forKey: SerializationKeys.numero) as? String
    self.dddTelefone1 = aDecoder.decodeObject(forKey: SerializationKeys.dddTelefone1) as? Int
    self.nomeResponsavel = aDecoder.decodeObject(forKey: SerializationKeys.nomeResponsavel) as? String
    self.logradouro = aDecoder.decodeObject(forKey: SerializationKeys.logradouro) as? String
    self.bairro = aDecoder.decodeObject(forKey: SerializationKeys.bairro) as? String
    self.complemento = aDecoder.decodeObject(forKey: SerializationKeys.complemento) as? String
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? Int
    self.observacoes = aDecoder.decodeObject(forKey: SerializationKeys.observacoes) as? String
    self.dddTelefone2 = aDecoder.decodeObject(forKey: SerializationKeys.dddTelefone2) as? Int
    self.telefone1 = aDecoder.decodeObject(forKey: SerializationKeys.telefone1) as? Int
    self.cidade = aDecoder.decodeObject(forKey: SerializationKeys.cidade) as? String
    self.uf = aDecoder.decodeObject(forKey: SerializationKeys.uf) as? String
    self.idParceiro = aDecoder.decodeObject(forKey: SerializationKeys.idParceiro) as? Int
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? Int
    self.telefone2 = aDecoder.decodeObject(forKey: SerializationKeys.telefone2) as? Int
    self.idUnidade = aDecoder.decodeObject(forKey: SerializationKeys.idUnidade) as? Int
    self.cep = aDecoder.decodeObject(forKey: SerializationKeys.cep) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(numero, forKey: SerializationKeys.numero)
    aCoder.encode(dddTelefone1, forKey: SerializationKeys.dddTelefone1)
    aCoder.encode(nomeResponsavel, forKey: SerializationKeys.nomeResponsavel)
    aCoder.encode(logradouro, forKey: SerializationKeys.logradouro)
    aCoder.encode(bairro, forKey: SerializationKeys.bairro)
    aCoder.encode(complemento, forKey: SerializationKeys.complemento)
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(observacoes, forKey: SerializationKeys.observacoes)
    aCoder.encode(dddTelefone2, forKey: SerializationKeys.dddTelefone2)
    aCoder.encode(telefone1, forKey: SerializationKeys.telefone1)
    aCoder.encode(cidade, forKey: SerializationKeys.cidade)
    aCoder.encode(uf, forKey: SerializationKeys.uf)
    aCoder.encode(idParceiro, forKey: SerializationKeys.idParceiro)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
    aCoder.encode(telefone2, forKey: SerializationKeys.telefone2)
    aCoder.encode(idUnidade, forKey: SerializationKeys.idUnidade)
    aCoder.encode(cep, forKey: SerializationKeys.cep)
  }

}
