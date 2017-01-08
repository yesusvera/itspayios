//
//  MyRequest.swift
//
//  Created by Arthur Augusto Sousa Marques on 1/7/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MyRequest: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let dataHoraStatus = "dataHoraStatus"
    static let dataHoraPedido = "dataHoraPedido"
    static let valorFrete = "valorFrete"
    static let idPedido = "idPedido"
    static let tipoEntrega = "tipoEntrega"
    static let idInstituicao = "idInstituicao"
    static let dataHoraStatusStr = "dataHoraStatusStr"
    static let descStatus = "descStatus"
    static let status = "status"
    static let idCredencial = "idCredencial"
    static let dataHoraPedidoStr = "dataHoraPedidoStr"
    static let idEndereco = "idEndereco"
    static let idParceiro = "idParceiro"
    static let quantidadeParcelas = "quantidadeParcelas"
    static let idProcessadora = "idProcessadora"
    static let idConta = "idConta"
    static let valorTotal = "valorTotal"
  }

  // MARK: Properties
  public var dataHoraStatus: DataHoraStatus?
  public var dataHoraPedido: DataHoraPedido?
  public var valorFrete: Int?
  public var idPedido: Int?
  public var tipoEntrega: Int?
  public var idInstituicao: Int?
  public var dataHoraStatusStr: String?
  public var descStatus: String?
  public var status: Int?
  public var idCredencial: Int?
  public var dataHoraPedidoStr: String?
  public var idEndereco: Int?
  public var idParceiro: Int?
  public var quantidadeParcelas: Int?
  public var idProcessadora: Int?
  public var idConta: Int?
  public var valorTotal: Float?

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
    dataHoraStatus = DataHoraStatus(json: json[SerializationKeys.dataHoraStatus])
    dataHoraPedido = DataHoraPedido(json: json[SerializationKeys.dataHoraPedido])
    valorFrete = json[SerializationKeys.valorFrete].int
    idPedido = json[SerializationKeys.idPedido].int
    tipoEntrega = json[SerializationKeys.tipoEntrega].int
    idInstituicao = json[SerializationKeys.idInstituicao].int
    dataHoraStatusStr = json[SerializationKeys.dataHoraStatusStr].string
    descStatus = json[SerializationKeys.descStatus].string
    status = json[SerializationKeys.status].int
    idCredencial = json[SerializationKeys.idCredencial].int
    dataHoraPedidoStr = json[SerializationKeys.dataHoraPedidoStr].string
    idEndereco = json[SerializationKeys.idEndereco].int
    idParceiro = json[SerializationKeys.idParceiro].int
    quantidadeParcelas = json[SerializationKeys.quantidadeParcelas].int
    idProcessadora = json[SerializationKeys.idProcessadora].int
    idConta = json[SerializationKeys.idConta].int
    valorTotal = json[SerializationKeys.valorTotal].float
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = dataHoraStatus { dictionary[SerializationKeys.dataHoraStatus] = value.dictionaryRepresentation() }
    if let value = dataHoraPedido { dictionary[SerializationKeys.dataHoraPedido] = value.dictionaryRepresentation() }
    if let value = valorFrete { dictionary[SerializationKeys.valorFrete] = value }
    if let value = idPedido { dictionary[SerializationKeys.idPedido] = value }
    if let value = tipoEntrega { dictionary[SerializationKeys.tipoEntrega] = value }
    if let value = idInstituicao { dictionary[SerializationKeys.idInstituicao] = value }
    if let value = dataHoraStatusStr { dictionary[SerializationKeys.dataHoraStatusStr] = value }
    if let value = descStatus { dictionary[SerializationKeys.descStatus] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = idCredencial { dictionary[SerializationKeys.idCredencial] = value }
    if let value = dataHoraPedidoStr { dictionary[SerializationKeys.dataHoraPedidoStr] = value }
    if let value = idEndereco { dictionary[SerializationKeys.idEndereco] = value }
    if let value = idParceiro { dictionary[SerializationKeys.idParceiro] = value }
    if let value = quantidadeParcelas { dictionary[SerializationKeys.quantidadeParcelas] = value }
    if let value = idProcessadora { dictionary[SerializationKeys.idProcessadora] = value }
    if let value = idConta { dictionary[SerializationKeys.idConta] = value }
    if let value = valorTotal { dictionary[SerializationKeys.valorTotal] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.dataHoraStatus = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraStatus) as? DataHoraStatus
    self.dataHoraPedido = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraPedido) as? DataHoraPedido
    self.valorFrete = aDecoder.decodeObject(forKey: SerializationKeys.valorFrete) as? Int
    self.idPedido = aDecoder.decodeObject(forKey: SerializationKeys.idPedido) as? Int
    self.tipoEntrega = aDecoder.decodeObject(forKey: SerializationKeys.tipoEntrega) as? Int
    self.idInstituicao = aDecoder.decodeObject(forKey: SerializationKeys.idInstituicao) as? Int
    self.dataHoraStatusStr = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraStatusStr) as? String
    self.descStatus = aDecoder.decodeObject(forKey: SerializationKeys.descStatus) as? String
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? Int
    self.idCredencial = aDecoder.decodeObject(forKey: SerializationKeys.idCredencial) as? Int
    self.dataHoraPedidoStr = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraPedidoStr) as? String
    self.idEndereco = aDecoder.decodeObject(forKey: SerializationKeys.idEndereco) as? Int
    self.idParceiro = aDecoder.decodeObject(forKey: SerializationKeys.idParceiro) as? Int
    self.quantidadeParcelas = aDecoder.decodeObject(forKey: SerializationKeys.quantidadeParcelas) as? Int
    self.idProcessadora = aDecoder.decodeObject(forKey: SerializationKeys.idProcessadora) as? Int
    self.idConta = aDecoder.decodeObject(forKey: SerializationKeys.idConta) as? Int
    self.valorTotal = aDecoder.decodeObject(forKey: SerializationKeys.valorTotal) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(dataHoraStatus, forKey: SerializationKeys.dataHoraStatus)
    aCoder.encode(dataHoraPedido, forKey: SerializationKeys.dataHoraPedido)
    aCoder.encode(valorFrete, forKey: SerializationKeys.valorFrete)
    aCoder.encode(idPedido, forKey: SerializationKeys.idPedido)
    aCoder.encode(tipoEntrega, forKey: SerializationKeys.tipoEntrega)
    aCoder.encode(idInstituicao, forKey: SerializationKeys.idInstituicao)
    aCoder.encode(dataHoraStatusStr, forKey: SerializationKeys.dataHoraStatusStr)
    aCoder.encode(descStatus, forKey: SerializationKeys.descStatus)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(idCredencial, forKey: SerializationKeys.idCredencial)
    aCoder.encode(dataHoraPedidoStr, forKey: SerializationKeys.dataHoraPedidoStr)
    aCoder.encode(idEndereco, forKey: SerializationKeys.idEndereco)
    aCoder.encode(idParceiro, forKey: SerializationKeys.idParceiro)
    aCoder.encode(quantidadeParcelas, forKey: SerializationKeys.quantidadeParcelas)
    aCoder.encode(idProcessadora, forKey: SerializationKeys.idProcessadora)
    aCoder.encode(idConta, forKey: SerializationKeys.idConta)
    aCoder.encode(valorTotal, forKey: SerializationKeys.valorTotal)
  }

}
