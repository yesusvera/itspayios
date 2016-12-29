//
//  CarrierInfo.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/29/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class CarrierInfo: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let documento = "documento"
    static let email = "email"
    static let saldoDisponivel = "saldoDisponivel"
    static let nome = "nome"
  }

  // MARK: Properties
  public var documento: Int?
  public var email: String?
  public var saldoDisponivel: Float?
  public var nome: String?

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
    documento = json[SerializationKeys.documento].int
    email = json[SerializationKeys.email].string
    saldoDisponivel = json[SerializationKeys.saldoDisponivel].float
    nome = json[SerializationKeys.nome].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = documento { dictionary[SerializationKeys.documento] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = saldoDisponivel { dictionary[SerializationKeys.saldoDisponivel] = value }
    if let value = nome { dictionary[SerializationKeys.nome] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.documento = aDecoder.decodeObject(forKey: SerializationKeys.documento) as? Int
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
    self.saldoDisponivel = aDecoder.decodeObject(forKey: SerializationKeys.saldoDisponivel) as? Float
    self.nome = aDecoder.decodeObject(forKey: SerializationKeys.nome) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(documento, forKey: SerializationKeys.documento)
    aCoder.encode(email, forKey: SerializationKeys.email)
    aCoder.encode(saldoDisponivel, forKey: SerializationKeys.saldoDisponivel)
    aCoder.encode(nome, forKey: SerializationKeys.nome)
  }

}
