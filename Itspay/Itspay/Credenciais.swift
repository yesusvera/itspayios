//
//  Credenciais.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/15/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Credenciais: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    fileprivate struct SerializationKeys {
        static let codigoSeguranca = "codigoSeguranca"
        static let grupoStatus = "grupoStatus"
        static let credencialVirtual = "credencialVirtual"
        static let descGrupoStatus = "descGrupoStatus"
        static let tipoConta = "tipoConta"
        static let dataValidade = "dataValidade"
        static let credencialUltimosDigitos = "credencialUltimosDigitos"
        static let descStatus = "descStatus"
        static let credencialMascarada = "credencialMascarada"
        static let dataHoraInclusao = "dataHoraInclusao"
        static let saldo = "saldo"
        static let idProduto = "idProduto"
        static let contaPagamento = "contaPagamento"
        static let idProdutoPlataforma = "idProdutoPlataforma"
        static let email = "email"
        static let apelidoVirtual = "apelidoVirtual"
        static let nomeProduto = "nomeProduto"
        static let idPessoa = "idPessoa"
        static let nomeImpresso = "nomeImpresso"
        static let urlImagemProduto = "urlImagemProduto"
        static let status = "status"
        static let limiteDisponivel = "limiteDisponivel"
        static let idCredencial = "idCredencial"
        static let credencialMascaradaReduzida = "credencialMascaradaReduzida"
        static let preparaDataSaldo = "preparaDataSaldo"
        static let idPlastico = "idPlastico"
        static let dataSaldo = "dataSaldo"
        static let idConta = "idConta"
        static let dataValidadeFmt = "dataValidadeFmt"
    }
    
    // MARK: Properties
    public var codigoSeguranca: String?
    public var grupoStatus: Int?
    public var credencialVirtual: String?
    public var descGrupoStatus: String?
    public var tipoConta: Int?
    public var dataValidade: DataValidade?
    public var credencialUltimosDigitos: String?
    public var descStatus: String?
    public var credencialMascarada: String?
    public var dataHoraInclusao: DataHoraInclusao?
    public var saldo: Double?
    public var idProduto: Int?
    public var contaPagamento: String?
    public var idProdutoPlataforma: Int?
    public var email: String?
    public var apelidoVirtual: String?
    public var nomeProduto: String?
    public var idPessoa: Int?
    public var nomeImpresso: String?
    public var urlImagemProduto: String?
    public var status: Int?
    public var limiteDisponivel: Int?
    public var idCredencial: Int?
    public var credencialMascaradaReduzida: String?
    public var preparaDataSaldo: String?
    public var idPlastico: Int?
    public var dataSaldo: String?
    public var idConta: Int?
    public var dataValidadeFmt: String?
    
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
        codigoSeguranca = json[SerializationKeys.codigoSeguranca].string
        grupoStatus = json[SerializationKeys.grupoStatus].int
        credencialVirtual = json[SerializationKeys.credencialVirtual].string
        descGrupoStatus = json[SerializationKeys.descGrupoStatus].string
        tipoConta = json[SerializationKeys.tipoConta].int
        dataValidade = DataValidade(json: json[SerializationKeys.dataValidade])
        credencialUltimosDigitos = json[SerializationKeys.credencialUltimosDigitos].string
        descStatus = json[SerializationKeys.descStatus].string
        credencialMascarada = json[SerializationKeys.credencialMascarada].string
        dataHoraInclusao = DataHoraInclusao(json: json[SerializationKeys.dataHoraInclusao])
        saldo = json[SerializationKeys.saldo].double
        idProduto = json[SerializationKeys.idProduto].int
        contaPagamento = json[SerializationKeys.contaPagamento].string
        idProdutoPlataforma = json[SerializationKeys.idProdutoPlataforma].int
        email = json[SerializationKeys.email].string
        apelidoVirtual = json[SerializationKeys.apelidoVirtual].string
        nomeProduto = json[SerializationKeys.nomeProduto].string
        idPessoa = json[SerializationKeys.idPessoa].int
        nomeImpresso = json[SerializationKeys.nomeImpresso].string
        urlImagemProduto = json[SerializationKeys.urlImagemProduto].string
        status = json[SerializationKeys.status].int
        limiteDisponivel = json[SerializationKeys.limiteDisponivel].int
        idCredencial = json[SerializationKeys.idCredencial].int
        credencialMascaradaReduzida = json[SerializationKeys.credencialMascaradaReduzida].string
        preparaDataSaldo = json[SerializationKeys.preparaDataSaldo].string
        idPlastico = json[SerializationKeys.idPlastico].int
        dataSaldo = json[SerializationKeys.dataSaldo].string
        idConta = json[SerializationKeys.idConta].int
        dataValidadeFmt = json[SerializationKeys.dataValidadeFmt].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = codigoSeguranca { dictionary[SerializationKeys.codigoSeguranca] = value }
        if let value = grupoStatus { dictionary[SerializationKeys.grupoStatus] = value }
        if let value = credencialVirtual { dictionary[SerializationKeys.credencialVirtual] = value }
        if let value = descGrupoStatus { dictionary[SerializationKeys.descGrupoStatus] = value }
        if let value = tipoConta { dictionary[SerializationKeys.tipoConta] = value }
        if let value = dataValidade { dictionary[SerializationKeys.dataValidade] = value.dictionaryRepresentation() }
        if let value = credencialUltimosDigitos { dictionary[SerializationKeys.credencialUltimosDigitos] = value }
        if let value = descStatus { dictionary[SerializationKeys.descStatus] = value }
        if let value = credencialMascarada { dictionary[SerializationKeys.credencialMascarada] = value }
        if let value = dataHoraInclusao { dictionary[SerializationKeys.dataHoraInclusao] = value.dictionaryRepresentation() }
        if let value = saldo { dictionary[SerializationKeys.saldo] = value }
        if let value = idProduto { dictionary[SerializationKeys.idProduto] = value }
        if let value = contaPagamento { dictionary[SerializationKeys.contaPagamento] = value }
        if let value = idProdutoPlataforma { dictionary[SerializationKeys.idProdutoPlataforma] = value }
        if let value = email { dictionary[SerializationKeys.email] = value }
        if let value = apelidoVirtual { dictionary[SerializationKeys.apelidoVirtual] = value }
        if let value = nomeProduto { dictionary[SerializationKeys.nomeProduto] = value }
        if let value = idPessoa { dictionary[SerializationKeys.idPessoa] = value }
        if let value = nomeImpresso { dictionary[SerializationKeys.nomeImpresso] = value }
        if let value = urlImagemProduto { dictionary[SerializationKeys.urlImagemProduto] = value }
        if let value = status { dictionary[SerializationKeys.status] = value }
        if let value = limiteDisponivel { dictionary[SerializationKeys.limiteDisponivel] = value }
        if let value = idCredencial { dictionary[SerializationKeys.idCredencial] = value }
        if let value = credencialMascaradaReduzida { dictionary[SerializationKeys.credencialMascaradaReduzida] = value }
        if let value = preparaDataSaldo { dictionary[SerializationKeys.preparaDataSaldo] = value }
        if let value = idPlastico { dictionary[SerializationKeys.idPlastico] = value }
        if let value = dataSaldo { dictionary[SerializationKeys.dataSaldo] = value }
        if let value = idConta { dictionary[SerializationKeys.idConta] = value }
        if let value = dataValidadeFmt { dictionary[SerializationKeys.dataValidadeFmt] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.codigoSeguranca = aDecoder.decodeObject(forKey: SerializationKeys.codigoSeguranca) as? String
        self.grupoStatus = aDecoder.decodeObject(forKey: SerializationKeys.grupoStatus) as? Int
        self.credencialVirtual = aDecoder.decodeObject(forKey: SerializationKeys.credencialVirtual) as? String
        self.descGrupoStatus = aDecoder.decodeObject(forKey: SerializationKeys.descGrupoStatus) as? String
        self.tipoConta = aDecoder.decodeObject(forKey: SerializationKeys.tipoConta) as? Int
        self.dataValidade = aDecoder.decodeObject(forKey: SerializationKeys.dataValidade) as? DataValidade
        self.credencialUltimosDigitos = aDecoder.decodeObject(forKey: SerializationKeys.credencialUltimosDigitos) as? String
        self.descStatus = aDecoder.decodeObject(forKey: SerializationKeys.descStatus) as? String
        self.credencialMascarada = aDecoder.decodeObject(forKey: SerializationKeys.credencialMascarada) as? String
        self.dataHoraInclusao = aDecoder.decodeObject(forKey: SerializationKeys.dataHoraInclusao) as? DataHoraInclusao
        self.saldo = aDecoder.decodeObject(forKey: SerializationKeys.saldo) as? Double
        self.idProduto = aDecoder.decodeObject(forKey: SerializationKeys.idProduto) as? Int
        self.contaPagamento = aDecoder.decodeObject(forKey: SerializationKeys.contaPagamento) as? String
        self.idProdutoPlataforma = aDecoder.decodeObject(forKey: SerializationKeys.idProdutoPlataforma) as? Int
        self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
        self.apelidoVirtual = aDecoder.decodeObject(forKey: SerializationKeys.apelidoVirtual) as? String
        self.nomeProduto = aDecoder.decodeObject(forKey: SerializationKeys.nomeProduto) as? String
        self.idPessoa = aDecoder.decodeObject(forKey: SerializationKeys.idPessoa) as? Int
        self.nomeImpresso = aDecoder.decodeObject(forKey: SerializationKeys.nomeImpresso) as? String
        self.urlImagemProduto = aDecoder.decodeObject(forKey: SerializationKeys.urlImagemProduto) as? String
        self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? Int
        self.limiteDisponivel = aDecoder.decodeObject(forKey: SerializationKeys.limiteDisponivel) as? Int
        self.idCredencial = aDecoder.decodeObject(forKey: SerializationKeys.idCredencial) as? Int
        self.credencialMascaradaReduzida = aDecoder.decodeObject(forKey: SerializationKeys.credencialMascaradaReduzida) as? String
        self.preparaDataSaldo = aDecoder.decodeObject(forKey: SerializationKeys.preparaDataSaldo) as? String
        self.idPlastico = aDecoder.decodeObject(forKey: SerializationKeys.idPlastico) as? Int
        self.dataSaldo = aDecoder.decodeObject(forKey: SerializationKeys.dataSaldo) as? String
        self.idConta = aDecoder.decodeObject(forKey: SerializationKeys.idConta) as? Int
        self.dataValidadeFmt = aDecoder.decodeObject(forKey: SerializationKeys.dataValidadeFmt) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(codigoSeguranca, forKey: SerializationKeys.codigoSeguranca)
        aCoder.encode(grupoStatus, forKey: SerializationKeys.grupoStatus)
        aCoder.encode(credencialVirtual, forKey: SerializationKeys.credencialVirtual)
        aCoder.encode(descGrupoStatus, forKey: SerializationKeys.descGrupoStatus)
        aCoder.encode(tipoConta, forKey: SerializationKeys.tipoConta)
        aCoder.encode(dataValidade, forKey: SerializationKeys.dataValidade)
        aCoder.encode(credencialUltimosDigitos, forKey: SerializationKeys.credencialUltimosDigitos)
        aCoder.encode(descStatus, forKey: SerializationKeys.descStatus)
        aCoder.encode(credencialMascarada, forKey: SerializationKeys.credencialMascarada)
        aCoder.encode(dataHoraInclusao, forKey: SerializationKeys.dataHoraInclusao)
        aCoder.encode(saldo, forKey: SerializationKeys.saldo)
        aCoder.encode(idProduto, forKey: SerializationKeys.idProduto)
        aCoder.encode(contaPagamento, forKey: SerializationKeys.contaPagamento)
        aCoder.encode(idProdutoPlataforma, forKey: SerializationKeys.idProdutoPlataforma)
        aCoder.encode(email, forKey: SerializationKeys.email)
        aCoder.encode(apelidoVirtual, forKey: SerializationKeys.apelidoVirtual)
        aCoder.encode(nomeProduto, forKey: SerializationKeys.nomeProduto)
        aCoder.encode(idPessoa, forKey: SerializationKeys.idPessoa)
        aCoder.encode(nomeImpresso, forKey: SerializationKeys.nomeImpresso)
        aCoder.encode(urlImagemProduto, forKey: SerializationKeys.urlImagemProduto)
        aCoder.encode(status, forKey: SerializationKeys.status)
        aCoder.encode(limiteDisponivel, forKey: SerializationKeys.limiteDisponivel)
        aCoder.encode(idCredencial, forKey: SerializationKeys.idCredencial)
        aCoder.encode(credencialMascaradaReduzida, forKey: SerializationKeys.credencialMascaradaReduzida)
        aCoder.encode(preparaDataSaldo, forKey: SerializationKeys.preparaDataSaldo)
        aCoder.encode(idPlastico, forKey: SerializationKeys.idPlastico)
        aCoder.encode(dataSaldo, forKey: SerializationKeys.dataSaldo)
        aCoder.encode(idConta, forKey: SerializationKeys.idConta)
        aCoder.encode(dataValidadeFmt, forKey: SerializationKeys.dataValidadeFmt)
    }
    
}
