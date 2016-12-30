//
//  ProductPartner.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/29/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ProductPartner: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let quantMaxParcelaSemJuros = "quantMaxParcelaSemJuros"
    static let dataHoraStatus = "dataHoraStatus"
    static let jurosAoMes = "jurosAoMes"
    static let entrega = "entrega"
    static let quantMaxParcelaComJuros = "quantMaxParcelaComJuros"
    static let nomeImagem = "nomeImagem"
    static let cnpj = "cnpj"
    static let status = "status"
    static let idUsuarioManutencao = "idUsuarioManutencao"
    static let idUsuarioInclusao = "idUsuarioInclusao"
    static let nomeParceiro = "nomeParceiro"
    static let idParceiro = "idParceiro"
    static let unidades = "unidades"
    static let produtos = "produtos"
  }

  // MARK: Properties
  public var quantMaxParcelaSemJuros: Int?
  public var dataHoraStatus: DataHoraStatus?
  public var jurosAoMes: Int?
  public var entrega: Int?
  public var quantMaxParcelaComJuros: Int?
  public var nomeImagem: String?
  public var cnpj: String?
  public var status: Int?
  public var idUsuarioManutencao: Int?
  public var idUsuarioInclusao: Int?
  public var nomeParceiro: String?
  public var idParceiro: Int?
  public var unidades: [Unidades]?
  public var produtos: [Produtos]?

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
    quantMaxParcelaSemJuros = json[SerializationKeys.quantMaxParcelaSemJuros].int
    dataHoraStatus = DataHoraStatus(json: json[SerializationKeys.dataHoraStatus])
    jurosAoMes = json[SerializationKeys.jurosAoMes].int
    entrega = json[SerializationKeys.entrega].int
    quantMaxParcelaComJuros = json[SerializationKeys.quantMaxParcelaComJuros].int
    nomeImagem = json[SerializationKeys.nomeImagem].string
    cnpj = json[SerializationKeys.cnpj].string
    status = json[SerializationKeys.status].int
    idUsuarioManutencao = json[SerializationKeys.idUsuarioManutencao].int
    idUsuarioInclusao = json[SerializationKeys.idUsuarioInclusao].int
    nomeParceiro = json[SerializationKeys.nomeParceiro].string
    idParceiro = json[SerializationKeys.idParceiro].int
    if let items = json[SerializationKeys.unidades].array { unidades = items.map { Unidades(json: $0) } }
    if let items = json[SerializationKeys.produtos].array { produtos = items.map { Produtos(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = quantMaxParcelaSemJuros { dictionary[SerializationKeys.quantMaxParcelaSemJuros] = value }
    if let value = dataHoraStatus { dictionary[SerializationKeys.dataHoraStatus] = value.dictionaryRepresentation() }
    if let value = jurosAoMes { dictionary[SerializationKeys.jurosAoMes] = value }
    if let value = entrega { dictionary[SerializationKeys.entrega] = value }
    if let value = quantMaxParcelaComJuros { dictionary[SerializationKeys.quantMaxParcelaComJuros] = value }
    if let value = nomeImagem { dictionary[SerializationKeys.nomeImagem] = value }
    if let value = cnpj { dictionary[SerializationKeys.cnpj] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = idUsuarioManutencao { dictionary[SerializationKeys.idUsuarioManutencao] = value }
    if let value = idUsuarioInclusao { dictionary[SerializationKeys.idUsuarioInclusao] = value }
    if let value = nomeParceiro { dictionary[SerializationKeys.nomeParceiro] = value }
    if let value = idParceiro { dictionary[SerializationKeys.idParceiro] = value }
    if let value = unidades { dictionary[SerializationKeys.unidades] = value.map { $0.dictionaryRepresentation() } }
    if let value = produtos { dictionary[SerializationKeys.produtos] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.quantMaxParcelaSemJuros = aDecoder.decodeObject(forKey: SerializationKeys.quantMaxParcelaSemJuros) as? Int
    self.dataHoraStatus = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraStatus) as? DataHoraStatus
    self.jurosAoMes = aDecoder.decodeObject(forKey: SerializationKeys.jurosAoMes) as? Int
    self.entrega = aDecoder.decodeObject(forKey: SerializationKeys.entrega) as? Int
    self.quantMaxParcelaComJuros = aDecoder.decodeObject(forKey: SerializationKeys.quantMaxParcelaComJuros) as? Int
    self.nomeImagem = aDecoder.decodeObject(forKey: SerializationKeys.nomeImagem) as? String
    self.cnpj = aDecoder.decodeObject(forKey: SerializationKeys.cnpj) as? String
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? Int
    self.idUsuarioManutencao = aDecoder.decodeObject(forKey: SerializationKeys.idUsuarioManutencao) as? Int
    self.idUsuarioInclusao = aDecoder.decodeObject(forKey: SerializationKeys.idUsuarioInclusao) as? Int
    self.nomeParceiro = aDecoder.decodeObject(forKey: SerializationKeys.nomeParceiro) as? String
    self.idParceiro = aDecoder.decodeObject(forKey: SerializationKeys.idParceiro) as? Int
    self.unidades = aDecoder.decodeObject(forKey: SerializationKeys.unidades) as? [Unidades]
    self.produtos = aDecoder.decodeObject(forKey: SerializationKeys.produtos) as? [Produtos]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(quantMaxParcelaSemJuros, forKey: SerializationKeys.quantMaxParcelaSemJuros)
    aCoder.encode(dataHoraStatus, forKey: SerializationKeys.dataHoraStatus)
    aCoder.encode(jurosAoMes, forKey: SerializationKeys.jurosAoMes)
    aCoder.encode(entrega, forKey: SerializationKeys.entrega)
    aCoder.encode(quantMaxParcelaComJuros, forKey: SerializationKeys.quantMaxParcelaComJuros)
    aCoder.encode(nomeImagem, forKey: SerializationKeys.nomeImagem)
    aCoder.encode(cnpj, forKey: SerializationKeys.cnpj)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(idUsuarioManutencao, forKey: SerializationKeys.idUsuarioManutencao)
    aCoder.encode(idUsuarioInclusao, forKey: SerializationKeys.idUsuarioInclusao)
    aCoder.encode(nomeParceiro, forKey: SerializationKeys.nomeParceiro)
    aCoder.encode(idParceiro, forKey: SerializationKeys.idParceiro)
    aCoder.encode(unidades, forKey: SerializationKeys.unidades)
    aCoder.encode(produtos, forKey: SerializationKeys.produtos)
  }

}
