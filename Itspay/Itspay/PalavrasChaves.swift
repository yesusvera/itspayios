//
//  PalavrasChaves.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/29/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PalavrasChaves: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let idPalavraChave = "idPalavraChave"
    static let nome = "nome"
  }

  // MARK: Properties
  public var idPalavraChave: Int?
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
    idPalavraChave = json[SerializationKeys.idPalavraChave].int
    nome = json[SerializationKeys.nome].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = idPalavraChave { dictionary[SerializationKeys.idPalavraChave] = value }
    if let value = nome { dictionary[SerializationKeys.nome] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.idPalavraChave = aDecoder.decodeObject(forKey: SerializationKeys.idPalavraChave) as? Int
    self.nome = aDecoder.decodeObject(forKey: SerializationKeys.nome) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(idPalavraChave, forKey: SerializationKeys.idPalavraChave)
    aCoder.encode(nome, forKey: SerializationKeys.nome)
  }

}
