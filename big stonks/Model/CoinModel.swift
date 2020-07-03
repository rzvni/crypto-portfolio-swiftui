//
//  CoinModel.swift
//  big stonks
//
//  Created by roli on 20.06.20.
//  Copyright © 2020 Roland Iana. All rights reserved.
//

import Foundation

// MARK: - CoinModel
struct CoinModel: Codable {
    let status: Status
    let data: [CoinData]
}

// MARK: - CoinData
struct CoinData: Codable {
     let id: Int?
        let name, symbol, slug: String?
        let numMarketPairs: Int?
        let dateAdded: String?
        let tags: [Tag]?
        let maxSupply: Double?
        let circulatingSupply, totalSupply: Double?
        let platform: Platform?
        let cmcRank: Int?
        let lastUpdated: String?
        let quote: Quote?

        enum CodingKeys: String, CodingKey {
            case id, name, symbol, slug
            case numMarketPairs = "num_market_pairs"
            case dateAdded = "date_added"
            case tags
            case maxSupply = "max_supply"
            case circulatingSupply = "circulating_supply"
            case totalSupply = "total_supply"
            case platform
            case cmcRank = "cmc_rank"
            case lastUpdated = "last_updated"
            case quote
        }
    }

    // MARK: - Platform
    struct Platform: Codable {
        let id: Int?
        let name: Name?
        let symbol: Symbol?
        let slug: Slug?
        let tokenAddress: String?

        enum CodingKeys: String, CodingKey {
            case id, name, symbol, slug
            case tokenAddress = "token_address"
        }
    }

    enum Name: String, Codable {
        case ethereum = "Ethereum"
        case neo = "NEO"
        case omni = "Omni"
        case rskSmartBitcoin = "RSK Smart Bitcoin"
        case tron = "TRON"
    }

    enum Slug: String, Codable {
        case ethereum = "ethereum"
        case neo = "neo"
        case omni = "omni"
        case rskSmartBitcoin = "rsk-smart-bitcoin"
        case tron = "tron"
    }

    enum Symbol: String, Codable {
        case eth = "ETH"
        case neo = "NEO"
        case omni = "OMNI"
        case rbtc = "RBTC"
        case trx = "TRX"
    }

    // MARK: - Quote
    struct Quote: Codable {
        let usd: Usd?

        enum CodingKeys: String, CodingKey {
            case usd = "USD"
        }
    }

    // MARK: - Usd
    struct Usd: Codable {
        let price, volume24H, percentChange1H, percentChange24H: Double?
        let percentChange7D, marketCap: Double?
        let lastUpdated: String?

        enum CodingKeys: String, CodingKey {
            case price
            case volume24H = "volume_24h"
            case percentChange1H = "percent_change_1h"
            case percentChange24H = "percent_change_24h"
            case percentChange7D = "percent_change_7d"
            case marketCap = "market_cap"
            case lastUpdated = "last_updated"
        }
    }

    enum Tag: String, Codable {
        case mineable = "mineable"
    }

    // MARK: - Status
    struct Status: Codable {
        let timestamp: String?
        let errorCode: Int?
        let errorMessage: JSONNull?
        let elapsed, creditCount: Int?

        enum CodingKeys: String, CodingKey {
            case timestamp
            case errorCode = "error_code"
            case errorMessage = "error_message"
            case elapsed
            case creditCount = "credit_count"
        }
    }

    // MARK: - Encode/decode helpers

    class JSONNull: Codable, Hashable {

        public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
        }

        public var hashValue: Int {
            return 0
        }

        public init() {}

        public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }
