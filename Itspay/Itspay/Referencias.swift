//
//  Referencias.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/29/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Referencias: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let precoPor = "precoPor"
    static let idSKU = "idSKU"
    static let referencia = "referencia"
    static let caracteristicas = "caracteristicas"
    static let freteMedio = "freteMedio"
    static let precoDe = "precoDe"
    static let saldo = "saldo"
    static let disponivel = "disponivel"
    static let idParceiro = "idParceiro"
    static let idProduto = "idProduto"
    static let idReferenciaSKU = "idReferenciaSKU"
  }

  // MARK: Properties
  public var precoPor: Float?
  public var idSKU: Int?
  public var referencia: String?
  public var caracteristicas: [Caracteristicas]?
  public var freteMedio: Int?
  public var precoDe: Float?
  public var saldo: Int?
  public var disponivel: Bool? = false
  public var idParceiro: Int?
  public var idProduto: String?
  public var idReferenciaSKU: Int?
  public var idImagem: Int?
  public var nomeProduto: String?
  public var nomeParceiro: String?
  public var quantidade: Int?

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
    precoPor = json[SerializationKeys.precoPor].float
    idSKU = json[SerializationKeys.idSKU].int
    referencia = json[SerializationKeys.referencia].string
    if let items = json[SerializationKeys.caracteristicas].array { caracteristicas = items.map { Caracteristicas(json: $0) } }
    freteMedio = json[SerializationKeys.freteMedio].int
    precoDe = json[SerializationKeys.precoDe].float
    saldo = json[SerializationKeys.saldo].int
    disponivel = json[SerializationKeys.disponivel].boolValue
    idParceiro = json[SerializationKeys.idParceiro].int
    idProduto = json[SerializationKeys.idProduto].string
    idReferenciaSKU = json[SerializationKeys.idReferenciaSKU].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = precoPor { dictionary[SerializationKeys.precoPor] = value }
    if let value = idSKU { dictionary[SerializationKeys.idSKU] = value }
    if let value = referencia { dictionary[SerializationKeys.referencia] = value }
    if let value = caracteristicas { dictionary[SerializationKeys.caracteristicas] = value.map { $0.dictionaryRepresentation() } }
    if let value = freteMedio { dictionary[SerializationKeys.freteMedio] = value }
    if let value = precoDe { dictionary[SerializationKeys.precoDe] = value }
    if let value = saldo { dictionary[SerializationKeys.saldo] = value }
    dictionary[SerializationKeys.disponivel] = disponivel
    if let value = idParceiro { dictionary[SerializationKeys.idParceiro] = value }
    if let value = idProduto { dictionary[SerializationKeys.idProduto] = value }
    if let value = idReferenciaSKU { dictionary[SerializationKeys.idReferenciaSKU] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.precoPor = aDecoder.decodeObject(forKey: SerializationKeys.precoPor) as? Float
    self.idSKU = aDecoder.decodeObject(forKey: SerializationKeys.idSKU) as? Int
    self.referencia = aDecoder.decodeObject(forKey: SerializationKeys.referencia) as? String
    self.caracteristicas = aDecoder.decodeObject(forKey: SerializationKeys.caracteristicas) as? [Caracteristicas]
    self.freteMedio = aDecoder.decodeObject(forKey: SerializationKeys.freteMedio) as? Int
    self.precoDe = aDecoder.decodeObject(forKey: SerializationKeys.precoDe) as? Float
    self.saldo = aDecoder.decodeObject(forKey: SerializationKeys.saldo) as? Int
    self.disponivel = aDecoder.decodeBool(forKey: SerializationKeys.disponivel)
    self.idParceiro = aDecoder.decodeObject(forKey: SerializationKeys.idParceiro) as? Int
    self.idProduto = aDecoder.decodeObject(forKey: SerializationKeys.idProduto) as? String
    self.idReferenciaSKU = aDecoder.decodeObject(forKey: SerializationKeys.idReferenciaSKU) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(precoPor, forKey: SerializationKeys.precoPor)
    aCoder.encode(idSKU, forKey: SerializationKeys.idSKU)
    aCoder.encode(referencia, forKey: SerializationKeys.referencia)
    aCoder.encode(caracteristicas, forKey: SerializationKeys.caracteristicas)
    aCoder.encode(freteMedio, forKey: SerializationKeys.freteMedio)
    aCoder.encode(precoDe, forKey: SerializationKeys.precoDe)
    aCoder.encode(saldo, forKey: SerializationKeys.saldo)
    aCoder.encode(disponivel, forKey: SerializationKeys.disponivel)
    aCoder.encode(idParceiro, forKey: SerializationKeys.idParceiro)
    aCoder.encode(idProduto, forKey: SerializationKeys.idProduto)
    aCoder.encode(idReferenciaSKU, forKey: SerializationKeys.idReferenciaSKU)
  }

}
