//
//  LoginResponseObject.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/13/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class LoginResponseObject: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let requisicaoNotificacaoMensagem = "requisicaoNotificacaoMensagem"
    static let requisitarAtualizacao = "requisitarAtualizacao"
    static let token = "token"
    static let dataHoraUltimoAcessso = "dataHoraUltimoAcessso"
    static let requisitarPermissaoNotificacao = "requisitarPermissaoNotificacao"
    static let idLogin = "idLogin"
    static let requisicaoAtualizacaoMensagem = "requisicaoAtualizacaoMensagem"
    static let versaoMaisRecente = "versaoMaisRecente"
  }

  // MARK: Properties
  public var requisicaoNotificacaoMensagem: String?
  public var requisitarAtualizacao: Bool? = false
  public var token: String?
  public var dataHoraUltimoAcessso: DataHoraUltimoAcessso?
  public var requisitarPermissaoNotificacao: Bool? = false
  public var idLogin: Int?
  public var requisicaoAtualizacaoMensagem: String?
  public var versaoMaisRecente: String?

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
    requisicaoNotificacaoMensagem = json[SerializationKeys.requisicaoNotificacaoMensagem].string
    requisitarAtualizacao = json[SerializationKeys.requisitarAtualizacao].boolValue
    token = json[SerializationKeys.token].string
    dataHoraUltimoAcessso = DataHoraUltimoAcessso(json: json[SerializationKeys.dataHoraUltimoAcessso])
    requisitarPermissaoNotificacao = json[SerializationKeys.requisitarPermissaoNotificacao].boolValue
    idLogin = json[SerializationKeys.idLogin].int
    requisicaoAtualizacaoMensagem = json[SerializationKeys.requisicaoAtualizacaoMensagem].string
    versaoMaisRecente = json[SerializationKeys.versaoMaisRecente].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = requisicaoNotificacaoMensagem { dictionary[SerializationKeys.requisicaoNotificacaoMensagem] = value }
    dictionary[SerializationKeys.requisitarAtualizacao] = requisitarAtualizacao
    if let value = token { dictionary[SerializationKeys.token] = value }
    if let value = dataHoraUltimoAcessso { dictionary[SerializationKeys.dataHoraUltimoAcessso] = value.dictionaryRepresentation() }
    dictionary[SerializationKeys.requisitarPermissaoNotificacao] = requisitarPermissaoNotificacao
    if let value = idLogin { dictionary[SerializationKeys.idLogin] = value }
    if let value = requisicaoAtualizacaoMensagem { dictionary[SerializationKeys.requisicaoAtualizacaoMensagem] = value }
    if let value = versaoMaisRecente { dictionary[SerializationKeys.versaoMaisRecente] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.requisicaoNotificacaoMensagem = aDecoder.decodeObject(forKey: SerializationKeys.requisicaoNotificacaoMensagem) as? String
    self.requisitarAtualizacao = aDecoder.decodeBool(forKey: SerializationKeys.requisitarAtualizacao)
    self.token = aDecoder.decodeObject(forKey: SerializationKeys.token) as? String
    self.dataHoraUltimoAcessso = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraUltimoAcessso) as? DataHoraUltimoAcessso
    self.requisitarPermissaoNotificacao = aDecoder.decodeBool(forKey: SerializationKeys.requisitarPermissaoNotificacao)
    self.idLogin = aDecoder.decodeObject(forKey: SerializationKeys.idLogin) as? Int
    self.requisicaoAtualizacaoMensagem = aDecoder.decodeObject(forKey: SerializationKeys.requisicaoAtualizacaoMensagem) as? String
    self.versaoMaisRecente = aDecoder.decodeObject(forKey: SerializationKeys.versaoMaisRecente) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(requisicaoNotificacaoMensagem, forKey: SerializationKeys.requisicaoNotificacaoMensagem)
    aCoder.encode(requisitarAtualizacao, forKey: SerializationKeys.requisitarAtualizacao)
    aCoder.encode(token, forKey: SerializationKeys.token)
    aCoder.encode(dataHoraUltimoAcessso, forKey: SerializationKeys.dataHoraUltimoAcessso)
    aCoder.encode(requisitarPermissaoNotificacao, forKey: SerializationKeys.requisitarPermissaoNotificacao)
    aCoder.encode(idLogin, forKey: SerializationKeys.idLogin)
    aCoder.encode(requisicaoAtualizacaoMensagem, forKey: SerializationKeys.requisicaoAtualizacaoMensagem)
    aCoder.encode(versaoMaisRecente, forKey: SerializationKeys.versaoMaisRecente)
  }

}
