//
//  Imagens.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/29/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Imagens: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let url = "url"
    static let idSKU = "idSKU"
    static let principal = "principal"
    static let idImagem = "idImagem"
    static let idProduto = "idProduto"
    static let nomeImagem = "nomeImagem"
  }

  // MARK: Properties
  public var url: String?
  public var idSKU: Int?
  public var principal: Bool? = false
  public var idImagem: Int?
  public var idProduto: String?
  public var nomeImagem: String?

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
    url = json[SerializationKeys.url].string
    idSKU = json[SerializationKeys.idSKU].int
    principal = json[SerializationKeys.principal].boolValue
    idImagem = json[SerializationKeys.idImagem].int
    idProduto = json[SerializationKeys.idProduto].string
    nomeImagem = json[SerializationKeys.nomeImagem].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = idSKU { dictionary[SerializationKeys.idSKU] = value }
    dictionary[SerializationKeys.principal] = principal
    if let value = idImagem { dictionary[SerializationKeys.idImagem] = value }
    if let value = idProduto { dictionary[SerializationKeys.idProduto] = value }
    if let value = nomeImagem { dictionary[SerializationKeys.nomeImagem] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.idSKU = aDecoder.decodeObject(forKey: SerializationKeys.idSKU) as? Int
    self.principal = aDecoder.decodeBool(forKey: SerializationKeys.principal)
    self.idImagem = aDecoder.decodeObject(forKey: SerializationKeys.idImagem) as? Int
    self.idProduto = aDecoder.decodeObject(forKey: SerializationKeys.idProduto) as? String
    self.nomeImagem = aDecoder.decodeObject(forKey: SerializationKeys.nomeImagem) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(idSKU, forKey: SerializationKeys.idSKU)
    aCoder.encode(principal, forKey: SerializationKeys.principal)
    aCoder.encode(idImagem, forKey: SerializationKeys.idImagem)
    aCoder.encode(idProduto, forKey: SerializationKeys.idProduto)
    aCoder.encode(nomeImagem, forKey: SerializationKeys.nomeImagem)
  }

}
