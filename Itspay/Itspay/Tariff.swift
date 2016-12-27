//
//  Tariff.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/27/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Tariff: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let descTransacaoEstendida = "descTransacaoEstendida"
    static let descPerfil = "descPerfil"
    static let descTransacaoReduzida = "descTransacaoReduzida"
    static let idPerfilTarifario = "idPerfilTarifario"
    static let valorTarifa = "valorTarifa"
  }

  // MARK: Properties
  public var descTransacaoEstendida: String?
  public var descPerfil: String?
  public var descTransacaoReduzida: String?
  public var idPerfilTarifario: Int?
  public var valorTarifa: Float?

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
    descTransacaoEstendida = json[SerializationKeys.descTransacaoEstendida].string
    descPerfil = json[SerializationKeys.descPerfil].string
    descTransacaoReduzida = json[SerializationKeys.descTransacaoReduzida].string
    idPerfilTarifario = json[SerializationKeys.idPerfilTarifario].int
    valorTarifa = json[SerializationKeys.valorTarifa].float
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = descTransacaoEstendida { dictionary[SerializationKeys.descTransacaoEstendida] = value }
    if let value = descPerfil { dictionary[SerializationKeys.descPerfil] = value }
    if let value = descTransacaoReduzida { dictionary[SerializationKeys.descTransacaoReduzida] = value }
    if let value = idPerfilTarifario { dictionary[SerializationKeys.idPerfilTarifario] = value }
    if let value = valorTarifa { dictionary[SerializationKeys.valorTarifa] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.descTransacaoEstendida = aDecoder.decodeObject(forKey: SerializationKeys.descTransacaoEstendida) as? String
    self.descPerfil = aDecoder.decodeObject(forKey: SerializationKeys.descPerfil) as? String
    self.descTransacaoReduzida = aDecoder.decodeObject(forKey: SerializationKeys.descTransacaoReduzida) as? String
    self.idPerfilTarifario = aDecoder.decodeObject(forKey: SerializationKeys.idPerfilTarifario) as? Int
    self.valorTarifa = aDecoder.decodeObject(forKey: SerializationKeys.valorTarifa) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(descTransacaoEstendida, forKey: SerializationKeys.descTransacaoEstendida)
    aCoder.encode(descPerfil, forKey: SerializationKeys.descPerfil)
    aCoder.encode(descTransacaoReduzida, forKey: SerializationKeys.descTransacaoReduzida)
    aCoder.encode(idPerfilTarifario, forKey: SerializationKeys.idPerfilTarifario)
    aCoder.encode(valorTarifa, forKey: SerializationKeys.valorTarifa)
  }

}
