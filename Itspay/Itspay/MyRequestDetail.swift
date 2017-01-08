//
//  MyRequestDetail.swift
//
//  Created by Arthur Augusto Sousa Marques on 1/8/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class MyRequestDetail: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let cep = "cep"
    static let ultimos4Digitos = "ultimos4Digitos"
    static let itensPedido = "itensPedido"
    static let dataHoraStatus = "dataHoraStatus"
    static let numero = "numero"
    static let dataHoraPedido = "dataHoraPedido"
    static let valorFrete = "valorFrete"
    static let valorParcela = "valorParcela"
    static let tipoEntrega = "tipoEntrega"
    static let idInstituicao = "idInstituicao"
    static let descTipoEntrega = "descTipoEntrega"
    static let complemento = "complemento"
    static let descStatus = "descStatus"
    static let nomeParceiro = "nomeParceiro"
    static let enderecoCompleto = "enderecoCompleto"
    static let cidade = "cidade"
    static let idEndereco = "idEndereco"
    static let idParceiro = "idParceiro"
    static let idProcessadora = "idProcessadora"
    static let uf = "uf"
    static let idPedido = "idPedido"
    static let nomeImpresso = "nomeImpresso"
    static let logradouro = "logradouro"
    static let dataHoraStatusStr = "dataHoraStatusStr"
    static let bairro = "bairro"
    static let status = "status"
    static let idCredencial = "idCredencial"
    static let dataHoraPedidoStr = "dataHoraPedidoStr"
    static let quantidadeParcelas = "quantidadeParcelas"
    static let idConta = "idConta"
    static let valorTotal = "valorTotal"
  }

  // MARK: Properties
  public var cep: String?
  public var ultimos4Digitos: String?
  public var itensPedido: [ItensPedido]?
  public var dataHoraStatus: String?
  public var numero: String?
  public var dataHoraPedido: String?
  public var valorFrete: Float?
  public var valorParcela: Float?
  public var tipoEntrega: Int?
  public var idInstituicao: Int?
  public var descTipoEntrega: String?
  public var complemento: String?
  public var descStatus: String?
  public var nomeParceiro: String?
  public var enderecoCompleto: String?
  public var cidade: String?
  public var idEndereco: Int?
  public var idParceiro: Int?
  public var idProcessadora: Int?
  public var uf: String?
  public var idPedido: Int?
  public var nomeImpresso: String?
  public var logradouro: String?
  public var dataHoraStatusStr: String?
  public var bairro: String?
  public var status: Int?
  public var idCredencial: Int?
  public var dataHoraPedidoStr: String?
  public var quantidadeParcelas: Int?
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
    cep = json[SerializationKeys.cep].string
    ultimos4Digitos = json[SerializationKeys.ultimos4Digitos].string
    if let items = json[SerializationKeys.itensPedido].array { itensPedido = items.map { ItensPedido(json: $0) } }
    dataHoraStatus = json[SerializationKeys.dataHoraStatus].string
    numero = json[SerializationKeys.numero].string
    dataHoraPedido = json[SerializationKeys.dataHoraPedido].string
    valorFrete = json[SerializationKeys.valorFrete].float
    valorParcela = json[SerializationKeys.valorParcela].float
    tipoEntrega = json[SerializationKeys.tipoEntrega].int
    idInstituicao = json[SerializationKeys.idInstituicao].int
    descTipoEntrega = json[SerializationKeys.descTipoEntrega].string
    complemento = json[SerializationKeys.complemento].string
    descStatus = json[SerializationKeys.descStatus].string
    nomeParceiro = json[SerializationKeys.nomeParceiro].string
    enderecoCompleto = json[SerializationKeys.enderecoCompleto].string
    cidade = json[SerializationKeys.cidade].string
    idEndereco = json[SerializationKeys.idEndereco].int
    idParceiro = json[SerializationKeys.idParceiro].int
    idProcessadora = json[SerializationKeys.idProcessadora].int
    uf = json[SerializationKeys.uf].string
    idPedido = json[SerializationKeys.idPedido].int
    nomeImpresso = json[SerializationKeys.nomeImpresso].string
    logradouro = json[SerializationKeys.logradouro].string
    dataHoraStatusStr = json[SerializationKeys.dataHoraStatusStr].string
    bairro = json[SerializationKeys.bairro].string
    status = json[SerializationKeys.status].int
    idCredencial = json[SerializationKeys.idCredencial].int
    dataHoraPedidoStr = json[SerializationKeys.dataHoraPedidoStr].string
    quantidadeParcelas = json[SerializationKeys.quantidadeParcelas].int
    idConta = json[SerializationKeys.idConta].int
    valorTotal = json[SerializationKeys.valorTotal].float
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = cep { dictionary[SerializationKeys.cep] = value }
    if let value = ultimos4Digitos { dictionary[SerializationKeys.ultimos4Digitos] = value }
    if let value = itensPedido { dictionary[SerializationKeys.itensPedido] = value.map { $0.dictionaryRepresentation() } }
    if let value = dataHoraStatus { dictionary[SerializationKeys.dataHoraStatus] = value }
    if let value = numero { dictionary[SerializationKeys.numero] = value }
    if let value = dataHoraPedido { dictionary[SerializationKeys.dataHoraPedido] = value }
    if let value = valorFrete { dictionary[SerializationKeys.valorFrete] = value }
    if let value = valorParcela { dictionary[SerializationKeys.valorParcela] = value }
    if let value = tipoEntrega { dictionary[SerializationKeys.tipoEntrega] = value }
    if let value = idInstituicao { dictionary[SerializationKeys.idInstituicao] = value }
    if let value = descTipoEntrega { dictionary[SerializationKeys.descTipoEntrega] = value }
    if let value = complemento { dictionary[SerializationKeys.complemento] = value }
    if let value = descStatus { dictionary[SerializationKeys.descStatus] = value }
    if let value = nomeParceiro { dictionary[SerializationKeys.nomeParceiro] = value }
    if let value = enderecoCompleto { dictionary[SerializationKeys.enderecoCompleto] = value }
    if let value = cidade { dictionary[SerializationKeys.cidade] = value }
    if let value = idEndereco { dictionary[SerializationKeys.idEndereco] = value }
    if let value = idParceiro { dictionary[SerializationKeys.idParceiro] = value }
    if let value = idProcessadora { dictionary[SerializationKeys.idProcessadora] = value }
    if let value = uf { dictionary[SerializationKeys.uf] = value }
    if let value = idPedido { dictionary[SerializationKeys.idPedido] = value }
    if let value = nomeImpresso { dictionary[SerializationKeys.nomeImpresso] = value }
    if let value = logradouro { dictionary[SerializationKeys.logradouro] = value }
    if let value = dataHoraStatusStr { dictionary[SerializationKeys.dataHoraStatusStr] = value }
    if let value = bairro { dictionary[SerializationKeys.bairro] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = idCredencial { dictionary[SerializationKeys.idCredencial] = value }
    if let value = dataHoraPedidoStr { dictionary[SerializationKeys.dataHoraPedidoStr] = value }
    if let value = quantidadeParcelas { dictionary[SerializationKeys.quantidadeParcelas] = value }
    if let value = idConta { dictionary[SerializationKeys.idConta] = value }
    if let value = valorTotal { dictionary[SerializationKeys.valorTotal] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.cep = aDecoder.decodeObject(forKey: SerializationKeys.cep) as? String
    self.ultimos4Digitos = aDecoder.decodeObject(forKey: SerializationKeys.ultimos4Digitos) as? String
    self.itensPedido = aDecoder.decodeObject(forKey: SerializationKeys.itensPedido) as? [ItensPedido]
    self.dataHoraStatus = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraStatus) as? String
    self.numero = aDecoder.decodeObject(forKey: SerializationKeys.numero) as? String
    self.dataHoraPedido = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraPedido) as? String
    self.valorFrete = aDecoder.decodeObject(forKey: SerializationKeys.valorFrete) as? Float
    self.valorParcela = aDecoder.decodeObject(forKey: SerializationKeys.valorParcela) as? Float
    self.tipoEntrega = aDecoder.decodeObject(forKey: SerializationKeys.tipoEntrega) as? Int
    self.idInstituicao = aDecoder.decodeObject(forKey: SerializationKeys.idInstituicao) as? Int
    self.descTipoEntrega = aDecoder.decodeObject(forKey: SerializationKeys.descTipoEntrega) as? String
    self.complemento = aDecoder.decodeObject(forKey: SerializationKeys.complemento) as? String
    self.descStatus = aDecoder.decodeObject(forKey: SerializationKeys.descStatus) as? String
    self.nomeParceiro = aDecoder.decodeObject(forKey: SerializationKeys.nomeParceiro) as? String
    self.enderecoCompleto = aDecoder.decodeObject(forKey: SerializationKeys.enderecoCompleto) as? String
    self.cidade = aDecoder.decodeObject(forKey: SerializationKeys.cidade) as? String
    self.idEndereco = aDecoder.decodeObject(forKey: SerializationKeys.idEndereco) as? Int
    self.idParceiro = aDecoder.decodeObject(forKey: SerializationKeys.idParceiro) as? Int
    self.idProcessadora = aDecoder.decodeObject(forKey: SerializationKeys.idProcessadora) as? Int
    self.uf = aDecoder.decodeObject(forKey: SerializationKeys.uf) as? String
    self.idPedido = aDecoder.decodeObject(forKey: SerializationKeys.idPedido) as? Int
    self.nomeImpresso = aDecoder.decodeObject(forKey: SerializationKeys.nomeImpresso) as? String
    self.logradouro = aDecoder.decodeObject(forKey: SerializationKeys.logradouro) as? String
    self.dataHoraStatusStr = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraStatusStr) as? String
    self.bairro = aDecoder.decodeObject(forKey: SerializationKeys.bairro) as? String
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? Int
    self.idCredencial = aDecoder.decodeObject(forKey: SerializationKeys.idCredencial) as? Int
    self.dataHoraPedidoStr = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraPedidoStr) as? String
    self.quantidadeParcelas = aDecoder.decodeObject(forKey: SerializationKeys.quantidadeParcelas) as? Int
    self.idConta = aDecoder.decodeObject(forKey: SerializationKeys.idConta) as? Int
    self.valorTotal = aDecoder.decodeObject(forKey: SerializationKeys.valorTotal) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(cep, forKey: SerializationKeys.cep)
    aCoder.encode(ultimos4Digitos, forKey: SerializationKeys.ultimos4Digitos)
    aCoder.encode(itensPedido, forKey: SerializationKeys.itensPedido)
    aCoder.encode(dataHoraStatus, forKey: SerializationKeys.dataHoraStatus)
    aCoder.encode(numero, forKey: SerializationKeys.numero)
    aCoder.encode(dataHoraPedido, forKey: SerializationKeys.dataHoraPedido)
    aCoder.encode(valorFrete, forKey: SerializationKeys.valorFrete)
    aCoder.encode(valorParcela, forKey: SerializationKeys.valorParcela)
    aCoder.encode(tipoEntrega, forKey: SerializationKeys.tipoEntrega)
    aCoder.encode(idInstituicao, forKey: SerializationKeys.idInstituicao)
    aCoder.encode(descTipoEntrega, forKey: SerializationKeys.descTipoEntrega)
    aCoder.encode(complemento, forKey: SerializationKeys.complemento)
    aCoder.encode(descStatus, forKey: SerializationKeys.descStatus)
    aCoder.encode(nomeParceiro, forKey: SerializationKeys.nomeParceiro)
    aCoder.encode(enderecoCompleto, forKey: SerializationKeys.enderecoCompleto)
    aCoder.encode(cidade, forKey: SerializationKeys.cidade)
    aCoder.encode(idEndereco, forKey: SerializationKeys.idEndereco)
    aCoder.encode(idParceiro, forKey: SerializationKeys.idParceiro)
    aCoder.encode(idProcessadora, forKey: SerializationKeys.idProcessadora)
    aCoder.encode(uf, forKey: SerializationKeys.uf)
    aCoder.encode(idPedido, forKey: SerializationKeys.idPedido)
    aCoder.encode(nomeImpresso, forKey: SerializationKeys.nomeImpresso)
    aCoder.encode(logradouro, forKey: SerializationKeys.logradouro)
    aCoder.encode(dataHoraStatusStr, forKey: SerializationKeys.dataHoraStatusStr)
    aCoder.encode(bairro, forKey: SerializationKeys.bairro)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(idCredencial, forKey: SerializationKeys.idCredencial)
    aCoder.encode(dataHoraPedidoStr, forKey: SerializationKeys.dataHoraPedidoStr)
    aCoder.encode(quantidadeParcelas, forKey: SerializationKeys.quantidadeParcelas)
    aCoder.encode(idConta, forKey: SerializationKeys.idConta)
    aCoder.encode(valorTotal, forKey: SerializationKeys.valorTotal)
  }

}
