//
//  VirtualCardStatement.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/19/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class VirtualCardStatement: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let sinal = "sinal"
    static let idTransacao = "idTransacao"
    static let descLocal = "descLocal"
    static let dataTransacao = "dataTransacao"
    static let dataTransacaoFmt = "dataTransacaoFmt"
    static let descTransacao = "descTransacao"
    static let valorTransacao = "valorTransacao"
    static let dataTransacaoFmtMes = "dataTransacaoFmtMes"
    static let descSeguimento = "descSeguimento"
  }

  // MARK: Properties
  public var sinal: Int?
  public var idTransacao: Int?
  public var descLocal: String?
  public var dataTransacao: DataTransacao?
  public var dataTransacaoFmt: String?
  public var descTransacao: String?
  public var valorTransacao: Int?
  public var dataTransacaoFmtMes: String?
  public var descSeguimento: String?

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
    sinal = json[SerializationKeys.sinal].int
    idTransacao = json[SerializationKeys.idTransacao].int
    descLocal = json[SerializationKeys.descLocal].string
    dataTransacao = DataTransacao(json: json[SerializationKeys.dataTransacao])
    dataTransacaoFmt = json[SerializationKeys.dataTransacaoFmt].string
    descTransacao = json[SerializationKeys.descTransacao].string
    valorTransacao = json[SerializationKeys.valorTransacao].int
    dataTransacaoFmtMes = json[SerializationKeys.dataTransacaoFmtMes].string
    descSeguimento = json[SerializationKeys.descSeguimento].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = sinal { dictionary[SerializationKeys.sinal] = value }
    if let value = idTransacao { dictionary[SerializationKeys.idTransacao] = value }
    if let value = descLocal { dictionary[SerializationKeys.descLocal] = value }
    if let value = dataTransacao { dictionary[SerializationKeys.dataTransacao] = value.dictionaryRepresentation() }
    if let value = dataTransacaoFmt { dictionary[SerializationKeys.dataTransacaoFmt] = value }
    if let value = descTransacao { dictionary[SerializationKeys.descTransacao] = value }
    if let value = valorTransacao { dictionary[SerializationKeys.valorTransacao] = value }
    if let value = dataTransacaoFmtMes { dictionary[SerializationKeys.dataTransacaoFmtMes] = value }
    if let value = descSeguimento { dictionary[SerializationKeys.descSeguimento] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.sinal = aDecoder.decodeObject(forKey: SerializationKeys.sinal) as? Int
    self.idTransacao = aDecoder.decodeObject(forKey: SerializationKeys.idTransacao) as? Int
    self.descLocal = aDecoder.decodeObject(forKey: SerializationKeys.descLocal) as? String
    self.dataTransacao = aDecoder.decodeObject(forKey: SerializationKeys.dataTransacao) as? DataTransacao
    self.dataTransacaoFmt = aDecoder.decodeObject(forKey: SerializationKeys.dataTransacaoFmt) as? String
    self.descTransacao = aDecoder.decodeObject(forKey: SerializationKeys.descTransacao) as? String
    self.valorTransacao = aDecoder.decodeObject(forKey: SerializationKeys.valorTransacao) as? Int
    self.dataTransacaoFmtMes = aDecoder.decodeObject(forKey: SerializationKeys.dataTransacaoFmtMes) as? String
    self.descSeguimento = aDecoder.decodeObject(forKey: SerializationKeys.descSeguimento) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(sinal, forKey: SerializationKeys.sinal)
    aCoder.encode(idTransacao, forKey: SerializationKeys.idTransacao)
    aCoder.encode(descLocal, forKey: SerializationKeys.descLocal)
    aCoder.encode(dataTransacao, forKey: SerializationKeys.dataTransacao)
    aCoder.encode(dataTransacaoFmt, forKey: SerializationKeys.dataTransacaoFmt)
    aCoder.encode(descTransacao, forKey: SerializationKeys.descTransacao)
    aCoder.encode(valorTransacao, forKey: SerializationKeys.valorTransacao)
    aCoder.encode(dataTransacaoFmtMes, forKey: SerializationKeys.dataTransacaoFmtMes)
    aCoder.encode(descSeguimento, forKey: SerializationKeys.descSeguimento)
  }

}
