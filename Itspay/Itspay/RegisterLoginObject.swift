//
//  RegisterLoginObject.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/15/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class RegisterLoginObject: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let senha = "senha"
    static let email = "email"
    static let dataNascimento = "dataNascimento"
    static let cpf = "cpf"
    static let origemCadastroLogin = "origemCadastroLogin"
    static let idInstituicao = "idInstituicao"
    static let credencial = "credencial"
    static let idProcessadora = "idProcessadora"
  }

  // MARK: Properties
  public var senha: String?
  public var email: String?
  public var dataNascimento: String?
  public var cpf: String?
  public var origemCadastroLogin: Int?
  public var idInstituicao: Int?
  public var credencial: String?
  public var idProcessadora: Int?

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
    senha = json[SerializationKeys.senha].string
    email = json[SerializationKeys.email].string
    dataNascimento = json[SerializationKeys.dataNascimento].string
    cpf = json[SerializationKeys.cpf].string
    origemCadastroLogin = json[SerializationKeys.origemCadastroLogin].int
    idInstituicao = json[SerializationKeys.idInstituicao].int
    credencial = json[SerializationKeys.credencial].string
    idProcessadora = json[SerializationKeys.idProcessadora].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = senha { dictionary[SerializationKeys.senha] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = dataNascimento { dictionary[SerializationKeys.dataNascimento] = value }
    if let value = cpf { dictionary[SerializationKeys.cpf] = value }
    if let value = origemCadastroLogin { dictionary[SerializationKeys.origemCadastroLogin] = value }
    if let value = idInstituicao { dictionary[SerializationKeys.idInstituicao] = value }
    if let value = credencial { dictionary[SerializationKeys.credencial] = value }
    if let value = idProcessadora { dictionary[SerializationKeys.idProcessadora] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.senha = aDecoder.decodeObject(forKey: SerializationKeys.senha) as? String
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
    self.dataNascimento = aDecoder.decodeObject(forKey: SerializationKeys.dataNascimento) as? String
    self.cpf = aDecoder.decodeObject(forKey: SerializationKeys.cpf) as? String
    self.origemCadastroLogin = aDecoder.decodeObject(forKey: SerializationKeys.origemCadastroLogin) as? Int
    self.idInstituicao = aDecoder.decodeObject(forKey: SerializationKeys.idInstituicao) as? Int
    self.credencial = aDecoder.decodeObject(forKey: SerializationKeys.credencial) as? String
    self.idProcessadora = aDecoder.decodeObject(forKey: SerializationKeys.idProcessadora) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(senha, forKey: SerializationKeys.senha)
    aCoder.encode(email, forKey: SerializationKeys.email)
    aCoder.encode(dataNascimento, forKey: SerializationKeys.dataNascimento)
    aCoder.encode(cpf, forKey: SerializationKeys.cpf)
    aCoder.encode(origemCadastroLogin, forKey: SerializationKeys.origemCadastroLogin)
    aCoder.encode(idInstituicao, forKey: SerializationKeys.idInstituicao)
    aCoder.encode(credencial, forKey: SerializationKeys.credencial)
    aCoder.encode(idProcessadora, forKey: SerializationKeys.idProcessadora)
  }

}
