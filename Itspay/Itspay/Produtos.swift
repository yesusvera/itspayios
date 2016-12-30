//
//  Produtos.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/29/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Produtos: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let tipoProduto = "tipoProduto"
    static let idSKU = "idSKU"
    static let categorias = "categorias"
    static let destaque = "destaque"
    static let nomeProduto = "nomeProduto"
    static let descricao = "descricao"
    static let idInstituicao = "idInstituicao"
    static let imagens = "imagens"
    static let vitrine = "vitrine"
    static let referencias = "referencias"
    static let ativo = "ativo"
    static let palavrasChaves = "palavrasChaves"
    static let idParceiro = "idParceiro"
    static let idProcessadora = "idProcessadora"
    static let url = "url"
    static let idProduto = "idProduto"
  }

  // MARK: Properties
  public var tipoProduto: String?
  public var idSKU: Int?
  public var categorias: [Categorias]?
  public var destaque: Int?
  public var nomeProduto: String?
  public var descricao: String?
  public var idInstituicao: Int?
  public var imagens: [Imagens]?
  public var vitrine: Bool? = false
  public var referencias: [Referencias]?
  public var ativo: Bool? = false
  public var palavrasChaves: [PalavrasChaves]?
  public var idParceiro: Int?
  public var idProcessadora: Int?
  public var url: String?
  public var idProduto: String?

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
    tipoProduto = json[SerializationKeys.tipoProduto].string
    idSKU = json[SerializationKeys.idSKU].int
    if let items = json[SerializationKeys.categorias].array { categorias = items.map { Categorias(json: $0) } }
    destaque = json[SerializationKeys.destaque].int
    nomeProduto = json[SerializationKeys.nomeProduto].string
    descricao = json[SerializationKeys.descricao].string
    idInstituicao = json[SerializationKeys.idInstituicao].int
    if let items = json[SerializationKeys.imagens].array { imagens = items.map { Imagens(json: $0) } }
    vitrine = json[SerializationKeys.vitrine].boolValue
    if let items = json[SerializationKeys.referencias].array { referencias = items.map { Referencias(json: $0) } }
    ativo = json[SerializationKeys.ativo].boolValue
    if let items = json[SerializationKeys.palavrasChaves].array { palavrasChaves = items.map { PalavrasChaves(json: $0) } }
    idParceiro = json[SerializationKeys.idParceiro].int
    idProcessadora = json[SerializationKeys.idProcessadora].int
    url = json[SerializationKeys.url].string
    idProduto = json[SerializationKeys.idProduto].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = tipoProduto { dictionary[SerializationKeys.tipoProduto] = value }
    if let value = idSKU { dictionary[SerializationKeys.idSKU] = value }
    if let value = categorias { dictionary[SerializationKeys.categorias] = value.map { $0.dictionaryRepresentation() } }
    if let value = destaque { dictionary[SerializationKeys.destaque] = value }
    if let value = nomeProduto { dictionary[SerializationKeys.nomeProduto] = value }
    if let value = descricao { dictionary[SerializationKeys.descricao] = value }
    if let value = idInstituicao { dictionary[SerializationKeys.idInstituicao] = value }
    if let value = imagens { dictionary[SerializationKeys.imagens] = value.map { $0.dictionaryRepresentation() } }
    dictionary[SerializationKeys.vitrine] = vitrine
    if let value = referencias { dictionary[SerializationKeys.referencias] = value.map { $0.dictionaryRepresentation() } }
    dictionary[SerializationKeys.ativo] = ativo
    if let value = palavrasChaves { dictionary[SerializationKeys.palavrasChaves] = value.map { $0.dictionaryRepresentation() } }
    if let value = idParceiro { dictionary[SerializationKeys.idParceiro] = value }
    if let value = idProcessadora { dictionary[SerializationKeys.idProcessadora] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = idProduto { dictionary[SerializationKeys.idProduto] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.tipoProduto = aDecoder.decodeObject(forKey: SerializationKeys.tipoProduto) as? String
    self.idSKU = aDecoder.decodeObject(forKey: SerializationKeys.idSKU) as? Int
    self.categorias = aDecoder.decodeObject(forKey: SerializationKeys.categorias) as? [Categorias]
    self.destaque = aDecoder.decodeObject(forKey: SerializationKeys.destaque) as? Int
    self.nomeProduto = aDecoder.decodeObject(forKey: SerializationKeys.nomeProduto) as? String
    self.descricao = aDecoder.decodeObject(forKey: SerializationKeys.descricao) as? String
    self.idInstituicao = aDecoder.decodeObject(forKey: SerializationKeys.idInstituicao) as? Int
    self.imagens = aDecoder.decodeObject(forKey: SerializationKeys.imagens) as? [Imagens]
    self.vitrine = aDecoder.decodeBool(forKey: SerializationKeys.vitrine)
    self.referencias = aDecoder.decodeObject(forKey: SerializationKeys.referencias) as? [Referencias]
    self.ativo = aDecoder.decodeBool(forKey: SerializationKeys.ativo)
    self.palavrasChaves = aDecoder.decodeObject(forKey: SerializationKeys.palavrasChaves) as? [PalavrasChaves]
    self.idParceiro = aDecoder.decodeObject(forKey: SerializationKeys.idParceiro) as? Int
    self.idProcessadora = aDecoder.decodeObject(forKey: SerializationKeys.idProcessadora) as? Int
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.idProduto = aDecoder.decodeObject(forKey: SerializationKeys.idProduto) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(tipoProduto, forKey: SerializationKeys.tipoProduto)
    aCoder.encode(idSKU, forKey: SerializationKeys.idSKU)
    aCoder.encode(categorias, forKey: SerializationKeys.categorias)
    aCoder.encode(destaque, forKey: SerializationKeys.destaque)
    aCoder.encode(nomeProduto, forKey: SerializationKeys.nomeProduto)
    aCoder.encode(descricao, forKey: SerializationKeys.descricao)
    aCoder.encode(idInstituicao, forKey: SerializationKeys.idInstituicao)
    aCoder.encode(imagens, forKey: SerializationKeys.imagens)
    aCoder.encode(vitrine, forKey: SerializationKeys.vitrine)
    aCoder.encode(referencias, forKey: SerializationKeys.referencias)
    aCoder.encode(ativo, forKey: SerializationKeys.ativo)
    aCoder.encode(palavrasChaves, forKey: SerializationKeys.palavrasChaves)
    aCoder.encode(idParceiro, forKey: SerializationKeys.idParceiro)
    aCoder.encode(idProcessadora, forKey: SerializationKeys.idProcessadora)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(idProduto, forKey: SerializationKeys.idProduto)
  }

}
