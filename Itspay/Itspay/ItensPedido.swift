//
//  ItensPedido.swift
//
//  Created by Arthur Augusto Sousa Marques on 1/8/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ItensPedido: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let idSKU = "idSKU"
    static let caracteristicas = "caracteristicas"
    static let descricao = "descricao"
    static let nomeProduto = "nomeProduto"
    static let idPedido = "idPedido"
    static let valorTotalItem = "valorTotalItem"
    static let idInstituicao = "idInstituicao"
    static let quantidadeItem = "quantidadeItem"
    static let idParceiro = "idParceiro"
    static let idProcessadora = "idProcessadora"
    static let valorUnitario = "valorUnitario"
    static let sequenciaItemPedido = "sequenciaItemPedido"
    static let idReferenciaSKU = "idReferenciaSKU"
  }

  // MARK: Properties
  public var idSKU: Int?
  public var caracteristicas: [Caracteristicas]?
  public var descricao: String?
  public var nomeProduto: String?
  public var idPedido: Int?
  public var valorTotalItem: Float?
  public var idInstituicao: Int?
  public var quantidadeItem: Int?
  public var idParceiro: Int?
  public var idProcessadora: Int?
  public var valorUnitario: Float?
  public var sequenciaItemPedido: Int?
  public var idReferenciaSKU: Int?

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
    idSKU = json[SerializationKeys.idSKU].int
    if let items = json[SerializationKeys.caracteristicas].array { caracteristicas = items.map { Caracteristicas(json: $0) } }
    descricao = json[SerializationKeys.descricao].string
    nomeProduto = json[SerializationKeys.nomeProduto].string
    idPedido = json[SerializationKeys.idPedido].int
    valorTotalItem = json[SerializationKeys.valorTotalItem].float
    idInstituicao = json[SerializationKeys.idInstituicao].int
    quantidadeItem = json[SerializationKeys.quantidadeItem].int
    idParceiro = json[SerializationKeys.idParceiro].int
    idProcessadora = json[SerializationKeys.idProcessadora].int
    valorUnitario = json[SerializationKeys.valorUnitario].float
    sequenciaItemPedido = json[SerializationKeys.sequenciaItemPedido].int
    idReferenciaSKU = json[SerializationKeys.idReferenciaSKU].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = idSKU { dictionary[SerializationKeys.idSKU] = value }
    if let value = caracteristicas { dictionary[SerializationKeys.caracteristicas] = value.map { $0.dictionaryRepresentation() } }
    if let value = descricao { dictionary[SerializationKeys.descricao] = value }
    if let value = nomeProduto { dictionary[SerializationKeys.nomeProduto] = value }
    if let value = idPedido { dictionary[SerializationKeys.idPedido] = value }
    if let value = valorTotalItem { dictionary[SerializationKeys.valorTotalItem] = value }
    if let value = idInstituicao { dictionary[SerializationKeys.idInstituicao] = value }
    if let value = quantidadeItem { dictionary[SerializationKeys.quantidadeItem] = value }
    if let value = idParceiro { dictionary[SerializationKeys.idParceiro] = value }
    if let value = idProcessadora { dictionary[SerializationKeys.idProcessadora] = value }
    if let value = valorUnitario { dictionary[SerializationKeys.valorUnitario] = value }
    if let value = sequenciaItemPedido { dictionary[SerializationKeys.sequenciaItemPedido] = value }
    if let value = idReferenciaSKU { dictionary[SerializationKeys.idReferenciaSKU] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.idSKU = aDecoder.decodeObject(forKey: SerializationKeys.idSKU) as? Int
    self.caracteristicas = aDecoder.decodeObject(forKey: SerializationKeys.caracteristicas) as? [Caracteristicas]
    self.descricao = aDecoder.decodeObject(forKey: SerializationKeys.descricao) as? String
    self.nomeProduto = aDecoder.decodeObject(forKey: SerializationKeys.nomeProduto) as? String
    self.idPedido = aDecoder.decodeObject(forKey: SerializationKeys.idPedido) as? Int
    self.valorTotalItem = aDecoder.decodeObject(forKey: SerializationKeys.valorTotalItem) as? Float
    self.idInstituicao = aDecoder.decodeObject(forKey: SerializationKeys.idInstituicao) as? Int
    self.quantidadeItem = aDecoder.decodeObject(forKey: SerializationKeys.quantidadeItem) as? Int
    self.idParceiro = aDecoder.decodeObject(forKey: SerializationKeys.idParceiro) as? Int
    self.idProcessadora = aDecoder.decodeObject(forKey: SerializationKeys.idProcessadora) as? Int
    self.valorUnitario = aDecoder.decodeObject(forKey: SerializationKeys.valorUnitario) as? Float
    self.sequenciaItemPedido = aDecoder.decodeObject(forKey: SerializationKeys.sequenciaItemPedido) as? Int
    self.idReferenciaSKU = aDecoder.decodeObject(forKey: SerializationKeys.idReferenciaSKU) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(idSKU, forKey: SerializationKeys.idSKU)
    aCoder.encode(caracteristicas, forKey: SerializationKeys.caracteristicas)
    aCoder.encode(descricao, forKey: SerializationKeys.descricao)
    aCoder.encode(nomeProduto, forKey: SerializationKeys.nomeProduto)
    aCoder.encode(idPedido, forKey: SerializationKeys.idPedido)
    aCoder.encode(valorTotalItem, forKey: SerializationKeys.valorTotalItem)
    aCoder.encode(idInstituicao, forKey: SerializationKeys.idInstituicao)
    aCoder.encode(quantidadeItem, forKey: SerializationKeys.quantidadeItem)
    aCoder.encode(idParceiro, forKey: SerializationKeys.idParceiro)
    aCoder.encode(idProcessadora, forKey: SerializationKeys.idProcessadora)
    aCoder.encode(valorUnitario, forKey: SerializationKeys.valorUnitario)
    aCoder.encode(sequenciaItemPedido, forKey: SerializationKeys.sequenciaItemPedido)
    aCoder.encode(idReferenciaSKU, forKey: SerializationKeys.idReferenciaSKU)
  }

}
