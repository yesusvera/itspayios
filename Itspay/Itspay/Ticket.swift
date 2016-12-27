//
//  Ticket.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/26/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Ticket: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let linhaDigitavel = "linhaDigitavel"
    static let codigoDeBarras = "codigoDeBarras"
    static let dataVencimentoFmtMes = "dataVencimentoFmtMes"
  }

  // MARK: Properties
  public var linhaDigitavel: String?
  public var codigoDeBarras: String?
  public var dataVencimentoFmtMes: String?

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
    linhaDigitavel = json[SerializationKeys.linhaDigitavel].string
    codigoDeBarras = json[SerializationKeys.codigoDeBarras].string
    dataVencimentoFmtMes = json[SerializationKeys.dataVencimentoFmtMes].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = linhaDigitavel { dictionary[SerializationKeys.linhaDigitavel] = value }
    if let value = codigoDeBarras { dictionary[SerializationKeys.codigoDeBarras] = value }
    if let value = dataVencimentoFmtMes { dictionary[SerializationKeys.dataVencimentoFmtMes] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.linhaDigitavel = aDecoder.decodeObject(forKey: SerializationKeys.linhaDigitavel) as? String
    self.codigoDeBarras = aDecoder.decodeObject(forKey: SerializationKeys.codigoDeBarras) as? String
    self.dataVencimentoFmtMes = aDecoder.decodeObject(forKey: SerializationKeys.dataVencimentoFmtMes) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(linhaDigitavel, forKey: SerializationKeys.linhaDigitavel)
    aCoder.encode(codigoDeBarras, forKey: SerializationKeys.codigoDeBarras)
    aCoder.encode(dataVencimentoFmtMes, forKey: SerializationKeys.dataVencimentoFmtMes)
  }

}
