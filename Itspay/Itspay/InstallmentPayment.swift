//
//  InstallmentPayment.swift
//
//  Created by Arthur Augusto Sousa Marques on 1/9/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class InstallmentPayment: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let valorFinal = "valorFinal"
    static let valorParcela = "valorParcela"
    static let quantidadeParcelas = "quantidadeParcelas"
  }

  // MARK: Properties
  public var valorFinal: Int?
  public var valorParcela: Int?
  public var quantidadeParcelas: Int?

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
    valorFinal = json[SerializationKeys.valorFinal].int
    valorParcela = json[SerializationKeys.valorParcela].int
    quantidadeParcelas = json[SerializationKeys.quantidadeParcelas].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = valorFinal { dictionary[SerializationKeys.valorFinal] = value }
    if let value = valorParcela { dictionary[SerializationKeys.valorParcela] = value }
    if let value = quantidadeParcelas { dictionary[SerializationKeys.quantidadeParcelas] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.valorFinal = aDecoder.decodeObject(forKey: SerializationKeys.valorFinal) as? Int
    self.valorParcela = aDecoder.decodeObject(forKey: SerializationKeys.valorParcela) as? Int
    self.quantidadeParcelas = aDecoder.decodeObject(forKey: SerializationKeys.quantidadeParcelas) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(valorFinal, forKey: SerializationKeys.valorFinal)
    aCoder.encode(valorParcela, forKey: SerializationKeys.valorParcela)
    aCoder.encode(quantidadeParcelas, forKey: SerializationKeys.quantidadeParcelas)
  }

}
