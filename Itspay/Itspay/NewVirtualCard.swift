//
//  NewVirtualCard.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/27/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class NewVirtualCard: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let ultimos4Digitos = "ultimos4Digitos"
    static let habilitaExterior = "habilitaExterior"
    static let dataHoraStatus = "dataHoraStatus"
    static let habilitaSaque = "habilitaSaque"
    static let dataValidade = "dataValidade"
    static let habilitaUsoPessoa = "habilitaUsoPessoa"
    static let chip = "chip"
    static let dataHoraInclusao = "dataHoraInclusao"
    static let tokenInterno = "tokenInterno"
    static let bin6 = "bin6"
    static let habilitaEcommerce = "habilitaEcommerce"
    static let apelidoVirtual = "apelidoVirtual"
    static let idContaPagamento = "idContaPagamento"
    static let habilitaNotificacaoTransacao = "habilitaNotificacaoTransacao"
    static let motivoEmissao = "motivoEmissao"
    static let titularidade = "titularidade"
    static let nomeImpresso = "nomeImpresso"
    static let idPessoa = "idPessoa"
    static let virtual = "virtual"
    static let binEstendido = "binEstendido"
    static let status = "status"
    static let idCredencial = "idCredencial"
    static let csn = "csn"
    static let idUsuarioInclusao = "idUsuarioInclusao"
    static let idPlastico = "idPlastico"
    static let idConta = "idConta"
  }

  // MARK: Properties
  public var ultimos4Digitos: Int?
  public var habilitaExterior: Int?
  public var dataHoraStatus: String?
  public var habilitaSaque: Int?
  public var dataValidade: String?
  public var habilitaUsoPessoa: Int?
  public var chip: Int?
  public var dataHoraInclusao: String?
  public var tokenInterno: Int?
  public var bin6: Int?
  public var habilitaEcommerce: Int?
  public var apelidoVirtual: String?
  public var idContaPagamento: Int?
  public var habilitaNotificacaoTransacao: Int?
  public var motivoEmissao: Int?
  public var titularidade: Int?
  public var nomeImpresso: String?
  public var idPessoa: Int?
  public var virtual: Int?
  public var binEstendido: Int?
  public var status: Int?
  public var idCredencial: Int?
  public var csn: Int?
  public var idUsuarioInclusao: Int?
  public var idPlastico: Int?
  public var idConta: Int?

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
    ultimos4Digitos = json[SerializationKeys.ultimos4Digitos].int
    habilitaExterior = json[SerializationKeys.habilitaExterior].int
    dataHoraStatus = json[SerializationKeys.dataHoraStatus].string
    habilitaSaque = json[SerializationKeys.habilitaSaque].int
    dataValidade = json[SerializationKeys.dataValidade].string
    habilitaUsoPessoa = json[SerializationKeys.habilitaUsoPessoa].int
    chip = json[SerializationKeys.chip].int
    dataHoraInclusao = json[SerializationKeys.dataHoraInclusao].string
    tokenInterno = json[SerializationKeys.tokenInterno].int
    bin6 = json[SerializationKeys.bin6].int
    habilitaEcommerce = json[SerializationKeys.habilitaEcommerce].int
    apelidoVirtual = json[SerializationKeys.apelidoVirtual].string
    idContaPagamento = json[SerializationKeys.idContaPagamento].int
    habilitaNotificacaoTransacao = json[SerializationKeys.habilitaNotificacaoTransacao].int
    motivoEmissao = json[SerializationKeys.motivoEmissao].int
    titularidade = json[SerializationKeys.titularidade].int
    nomeImpresso = json[SerializationKeys.nomeImpresso].string
    idPessoa = json[SerializationKeys.idPessoa].int
    virtual = json[SerializationKeys.virtual].int
    binEstendido = json[SerializationKeys.binEstendido].int
    status = json[SerializationKeys.status].int
    idCredencial = json[SerializationKeys.idCredencial].int
    csn = json[SerializationKeys.csn].int
    idUsuarioInclusao = json[SerializationKeys.idUsuarioInclusao].int
    idPlastico = json[SerializationKeys.idPlastico].int
    idConta = json[SerializationKeys.idConta].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = ultimos4Digitos { dictionary[SerializationKeys.ultimos4Digitos] = value }
    if let value = habilitaExterior { dictionary[SerializationKeys.habilitaExterior] = value }
    if let value = dataHoraStatus { dictionary[SerializationKeys.dataHoraStatus] = value }
    if let value = habilitaSaque { dictionary[SerializationKeys.habilitaSaque] = value }
    if let value = dataValidade { dictionary[SerializationKeys.dataValidade] = value }
    if let value = habilitaUsoPessoa { dictionary[SerializationKeys.habilitaUsoPessoa] = value }
    if let value = chip { dictionary[SerializationKeys.chip] = value }
    if let value = dataHoraInclusao { dictionary[SerializationKeys.dataHoraInclusao] = value }
    if let value = tokenInterno { dictionary[SerializationKeys.tokenInterno] = value }
    if let value = bin6 { dictionary[SerializationKeys.bin6] = value }
    if let value = habilitaEcommerce { dictionary[SerializationKeys.habilitaEcommerce] = value }
    if let value = apelidoVirtual { dictionary[SerializationKeys.apelidoVirtual] = value }
    if let value = idContaPagamento { dictionary[SerializationKeys.idContaPagamento] = value }
    if let value = habilitaNotificacaoTransacao { dictionary[SerializationKeys.habilitaNotificacaoTransacao] = value }
    if let value = motivoEmissao { dictionary[SerializationKeys.motivoEmissao] = value }
    if let value = titularidade { dictionary[SerializationKeys.titularidade] = value }
    if let value = nomeImpresso { dictionary[SerializationKeys.nomeImpresso] = value }
    if let value = idPessoa { dictionary[SerializationKeys.idPessoa] = value }
    if let value = virtual { dictionary[SerializationKeys.virtual] = value }
    if let value = binEstendido { dictionary[SerializationKeys.binEstendido] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = idCredencial { dictionary[SerializationKeys.idCredencial] = value }
    if let value = csn { dictionary[SerializationKeys.csn] = value }
    if let value = idUsuarioInclusao { dictionary[SerializationKeys.idUsuarioInclusao] = value }
    if let value = idPlastico { dictionary[SerializationKeys.idPlastico] = value }
    if let value = idConta { dictionary[SerializationKeys.idConta] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.ultimos4Digitos = aDecoder.decodeObject(forKey: SerializationKeys.ultimos4Digitos) as? Int
    self.habilitaExterior = aDecoder.decodeObject(forKey: SerializationKeys.habilitaExterior) as? Int
    self.dataHoraStatus = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraStatus) as? String
    self.habilitaSaque = aDecoder.decodeObject(forKey: SerializationKeys.habilitaSaque) as? Int
    self.dataValidade = aDecoder.decodeObject(forKey: SerializationKeys.dataValidade) as? String
    self.habilitaUsoPessoa = aDecoder.decodeObject(forKey: SerializationKeys.habilitaUsoPessoa) as? Int
    self.chip = aDecoder.decodeObject(forKey: SerializationKeys.chip) as? Int
    self.dataHoraInclusao = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraInclusao) as? String
    self.tokenInterno = aDecoder.decodeObject(forKey: SerializationKeys.tokenInterno) as? Int
    self.bin6 = aDecoder.decodeObject(forKey: SerializationKeys.bin6) as? Int
    self.habilitaEcommerce = aDecoder.decodeObject(forKey: SerializationKeys.habilitaEcommerce) as? Int
    self.apelidoVirtual = aDecoder.decodeObject(forKey: SerializationKeys.apelidoVirtual) as? String
    self.idContaPagamento = aDecoder.decodeObject(forKey: SerializationKeys.idContaPagamento) as? Int
    self.habilitaNotificacaoTransacao = aDecoder.decodeObject(forKey: SerializationKeys.habilitaNotificacaoTransacao) as? Int
    self.motivoEmissao = aDecoder.decodeObject(forKey: SerializationKeys.motivoEmissao) as? Int
    self.titularidade = aDecoder.decodeObject(forKey: SerializationKeys.titularidade) as? Int
    self.nomeImpresso = aDecoder.decodeObject(forKey: SerializationKeys.nomeImpresso) as? String
    self.idPessoa = aDecoder.decodeObject(forKey: SerializationKeys.idPessoa) as? Int
    self.virtual = aDecoder.decodeObject(forKey: SerializationKeys.virtual) as? Int
    self.binEstendido = aDecoder.decodeObject(forKey: SerializationKeys.binEstendido) as? Int
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? Int
    self.idCredencial = aDecoder.decodeObject(forKey: SerializationKeys.idCredencial) as? Int
    self.csn = aDecoder.decodeObject(forKey: SerializationKeys.csn) as? Int
    self.idUsuarioInclusao = aDecoder.decodeObject(forKey: SerializationKeys.idUsuarioInclusao) as? Int
    self.idPlastico = aDecoder.decodeObject(forKey: SerializationKeys.idPlastico) as? Int
    self.idConta = aDecoder.decodeObject(forKey: SerializationKeys.idConta) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(ultimos4Digitos, forKey: SerializationKeys.ultimos4Digitos)
    aCoder.encode(habilitaExterior, forKey: SerializationKeys.habilitaExterior)
    aCoder.encode(dataHoraStatus, forKey: SerializationKeys.dataHoraStatus)
    aCoder.encode(habilitaSaque, forKey: SerializationKeys.habilitaSaque)
    aCoder.encode(dataValidade, forKey: SerializationKeys.dataValidade)
    aCoder.encode(habilitaUsoPessoa, forKey: SerializationKeys.habilitaUsoPessoa)
    aCoder.encode(chip, forKey: SerializationKeys.chip)
    aCoder.encode(dataHoraInclusao, forKey: SerializationKeys.dataHoraInclusao)
    aCoder.encode(tokenInterno, forKey: SerializationKeys.tokenInterno)
    aCoder.encode(bin6, forKey: SerializationKeys.bin6)
    aCoder.encode(habilitaEcommerce, forKey: SerializationKeys.habilitaEcommerce)
    aCoder.encode(apelidoVirtual, forKey: SerializationKeys.apelidoVirtual)
    aCoder.encode(idContaPagamento, forKey: SerializationKeys.idContaPagamento)
    aCoder.encode(habilitaNotificacaoTransacao, forKey: SerializationKeys.habilitaNotificacaoTransacao)
    aCoder.encode(motivoEmissao, forKey: SerializationKeys.motivoEmissao)
    aCoder.encode(titularidade, forKey: SerializationKeys.titularidade)
    aCoder.encode(nomeImpresso, forKey: SerializationKeys.nomeImpresso)
    aCoder.encode(idPessoa, forKey: SerializationKeys.idPessoa)
    aCoder.encode(virtual, forKey: SerializationKeys.virtual)
    aCoder.encode(binEstendido, forKey: SerializationKeys.binEstendido)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(idCredencial, forKey: SerializationKeys.idCredencial)
    aCoder.encode(csn, forKey: SerializationKeys.csn)
    aCoder.encode(idUsuarioInclusao, forKey: SerializationKeys.idUsuarioInclusao)
    aCoder.encode(idPlastico, forKey: SerializationKeys.idPlastico)
    aCoder.encode(idConta, forKey: SerializationKeys.idConta)
  }

}
