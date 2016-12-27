//
//  SecuritySettings.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/27/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SecuritySettings: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let habilitaEcommerce = "habilitaEcommerce"
    static let habilitaSaque = "habilitaSaque"
    static let habilitaExterior = "habilitaExterior"
    static let habilitaUsoPessoa = "habilitaUsoPessoa"
    static let habilitaNotificacaoTransacao = "habilitaNotificacaoTransacao"
  }

  // MARK: Properties
  public var habilitaEcommerce: Bool? = false
  public var habilitaSaque: Bool? = false
  public var habilitaExterior: Bool? = false
  public var habilitaUsoPessoa: Bool? = false
  public var habilitaNotificacaoTransacao: Bool? = false

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
    habilitaEcommerce = json[SerializationKeys.habilitaEcommerce].boolValue
    habilitaSaque = json[SerializationKeys.habilitaSaque].boolValue
    habilitaExterior = json[SerializationKeys.habilitaExterior].boolValue
    habilitaUsoPessoa = json[SerializationKeys.habilitaUsoPessoa].boolValue
    habilitaNotificacaoTransacao = json[SerializationKeys.habilitaNotificacaoTransacao].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.habilitaEcommerce] = habilitaEcommerce
    dictionary[SerializationKeys.habilitaSaque] = habilitaSaque
    dictionary[SerializationKeys.habilitaExterior] = habilitaExterior
    dictionary[SerializationKeys.habilitaUsoPessoa] = habilitaUsoPessoa
    dictionary[SerializationKeys.habilitaNotificacaoTransacao] = habilitaNotificacaoTransacao
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.habilitaEcommerce = aDecoder.decodeBool(forKey: SerializationKeys.habilitaEcommerce)
    self.habilitaSaque = aDecoder.decodeBool(forKey: SerializationKeys.habilitaSaque)
    self.habilitaExterior = aDecoder.decodeBool(forKey: SerializationKeys.habilitaExterior)
    self.habilitaUsoPessoa = aDecoder.decodeBool(forKey: SerializationKeys.habilitaUsoPessoa)
    self.habilitaNotificacaoTransacao = aDecoder.decodeBool(forKey: SerializationKeys.habilitaNotificacaoTransacao)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(habilitaEcommerce, forKey: SerializationKeys.habilitaEcommerce)
    aCoder.encode(habilitaSaque, forKey: SerializationKeys.habilitaSaque)
    aCoder.encode(habilitaExterior, forKey: SerializationKeys.habilitaExterior)
    aCoder.encode(habilitaUsoPessoa, forKey: SerializationKeys.habilitaUsoPessoa)
    aCoder.encode(habilitaNotificacaoTransacao, forKey: SerializationKeys.habilitaNotificacaoTransacao)
  }

}
