//
//  LoginRequestObject.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/13/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class LoginRequestObject: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let versaoConhecida = "versaoConhecida"
    static let platformName = "platformName"
    static let cpf = "cpf"
    static let plataformVersion = "plataformVersion"
    static let deviceId = "deviceId"
    static let sistemaOperacional = "sistemaOperacional"
    static let idInstituicao = "idInstituicao"
    static let architectureInfo = "architectureInfo"
    static let model = "model"
    static let versaoInstalada = "versaoInstalada"
    static let latitude = "latitude"
    static let origemAcesso = "origemAcesso"
    static let senha = "senha"
    static let idProcessadora = "idProcessadora"
    static let longitude = "longitude"
  }

  // MARK: Properties
  public var versaoConhecida: String?
  public var platformName: String?
  public var cpf: String?
  public var plataformVersion: String?
  public var deviceId: String?
  public var sistemaOperacional: Int?
  public var idInstituicao: Int?
  public var architectureInfo: String?
  public var model: String?
  public var versaoInstalada: String?
  public var latitude: Int?
  public var origemAcesso: Int?
  public var senha: String?
  public var idProcessadora: Int?
  public var longitude: Int?

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
    versaoConhecida = json[SerializationKeys.versaoConhecida].string
    platformName = json[SerializationKeys.platformName].string
    cpf = json[SerializationKeys.cpf].string
    plataformVersion = json[SerializationKeys.plataformVersion].string
    deviceId = json[SerializationKeys.deviceId].string
    sistemaOperacional = json[SerializationKeys.sistemaOperacional].int
    idInstituicao = json[SerializationKeys.idInstituicao].int
    architectureInfo = json[SerializationKeys.architectureInfo].string
    model = json[SerializationKeys.model].string
    versaoInstalada = json[SerializationKeys.versaoInstalada].string
    latitude = json[SerializationKeys.latitude].int
    origemAcesso = json[SerializationKeys.origemAcesso].int
    senha = json[SerializationKeys.senha].string
    idProcessadora = json[SerializationKeys.idProcessadora].int
    longitude = json[SerializationKeys.longitude].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = versaoConhecida { dictionary[SerializationKeys.versaoConhecida] = value }
    if let value = platformName { dictionary[SerializationKeys.platformName] = value }
    if let value = cpf { dictionary[SerializationKeys.cpf] = value }
    if let value = plataformVersion { dictionary[SerializationKeys.plataformVersion] = value }
    if let value = deviceId { dictionary[SerializationKeys.deviceId] = value }
    if let value = sistemaOperacional { dictionary[SerializationKeys.sistemaOperacional] = value }
    if let value = idInstituicao { dictionary[SerializationKeys.idInstituicao] = value }
    if let value = architectureInfo { dictionary[SerializationKeys.architectureInfo] = value }
    if let value = model { dictionary[SerializationKeys.model] = value }
    if let value = versaoInstalada { dictionary[SerializationKeys.versaoInstalada] = value }
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = origemAcesso { dictionary[SerializationKeys.origemAcesso] = value }
    if let value = senha { dictionary[SerializationKeys.senha] = value }
    if let value = idProcessadora { dictionary[SerializationKeys.idProcessadora] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.versaoConhecida = aDecoder.decodeObject(forKey: SerializationKeys.versaoConhecida) as? String
    self.platformName = aDecoder.decodeObject(forKey: SerializationKeys.platformName) as? String
    self.cpf = aDecoder.decodeObject(forKey: SerializationKeys.cpf) as? String
    self.plataformVersion = aDecoder.decodeObject(forKey: SerializationKeys.plataformVersion) as? String
    self.deviceId = aDecoder.decodeObject(forKey: SerializationKeys.deviceId) as? String
    self.sistemaOperacional = aDecoder.decodeObject(forKey: SerializationKeys.sistemaOperacional) as? Int
    self.idInstituicao = aDecoder.decodeObject(forKey: SerializationKeys.idInstituicao) as? Int
    self.architectureInfo = aDecoder.decodeObject(forKey: SerializationKeys.architectureInfo) as? String
    self.model = aDecoder.decodeObject(forKey: SerializationKeys.model) as? String
    self.versaoInstalada = aDecoder.decodeObject(forKey: SerializationKeys.versaoInstalada) as? String
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? Int
    self.origemAcesso = aDecoder.decodeObject(forKey: SerializationKeys.origemAcesso) as? Int
    self.senha = aDecoder.decodeObject(forKey: SerializationKeys.senha) as? String
    self.idProcessadora = aDecoder.decodeObject(forKey: SerializationKeys.idProcessadora) as? Int
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(versaoConhecida, forKey: SerializationKeys.versaoConhecida)
    aCoder.encode(platformName, forKey: SerializationKeys.platformName)
    aCoder.encode(cpf, forKey: SerializationKeys.cpf)
    aCoder.encode(plataformVersion, forKey: SerializationKeys.plataformVersion)
    aCoder.encode(deviceId, forKey: SerializationKeys.deviceId)
    aCoder.encode(sistemaOperacional, forKey: SerializationKeys.sistemaOperacional)
    aCoder.encode(idInstituicao, forKey: SerializationKeys.idInstituicao)
    aCoder.encode(architectureInfo, forKey: SerializationKeys.architectureInfo)
    aCoder.encode(model, forKey: SerializationKeys.model)
    aCoder.encode(versaoInstalada, forKey: SerializationKeys.versaoInstalada)
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(origemAcesso, forKey: SerializationKeys.origemAcesso)
    aCoder.encode(senha, forKey: SerializationKeys.senha)
    aCoder.encode(idProcessadora, forKey: SerializationKeys.idProcessadora)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
  }
}
