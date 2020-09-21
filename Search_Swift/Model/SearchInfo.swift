//
//  SearchInfo.swift
//  Search_Swift
//
//  Created by KeunHyeong on 2020/09/19.
//  Copyright © 2020 KeunHyeong. All rights reserved.
//

import UIKit

class SearchInfo: Codable {
    
    let advisories : [String]?
    let isGameCenterEnabled : Bool?
    let screenshotUrls : [String]?
    let ipadScreenshotUrls : [String]?
    let appletvScreenshotUrls : [String]?
    let artworkUrl60 : String?
    let artworkUrl512 : String?
    let artworkUrl100 : String?
    let artistViewUrl : String?
    let supportedDevices : [String]?
    let features : [String]?
    let kind :String?
    let trackId :Int?
    let title :String?
    let sellerName :String?
    let genreIds :[String]?
    let formattedPrice :String?
    let releaseNotes :String?
    let primaryGenreName :String?
    let releaseDate :String?
    let isVppDeviceBasedLicensingEnabled : Bool?
    let primaryGenreId : Int?
    let currentVersionReleaseDate : String?
    let currency : String?
    let trackCensoredName :String?
    let languageCodesISO2A :[String]?
    let fileSizeBytes :String?
    let sellerUrl :URL?
    let contentAdvisoryRating :String?
    let averageUserRatingForCurrentVersion :Double?
    let userRatingCountForCurrentVersion :Int?
    let averageUserRating :Double?
    let trackViewUrl :String?
    let trackContentRating :String?
    let minimumOsVersion :String?
    let description :String?
    let price :Float?
    let artistId :Int?
    let corpName :String?
    let genres :[String]?
    let bundleId :String?
    let version :String?
    let wrapperType :String?
    let userRatingCount :Int?
    
    enum CodingKeys: String, CodingKey {
        case advisories = "advisories"
        case isGameCenterEnabled = "isGameCenterEnabled"
        case screenshotUrls = "screenshotUrls"
        case ipadScreenshotUrls = "ipadScreenshotUrls"
        case appletvScreenshotUrls = "appletvScreenshotUrls"
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl512 = "artworkUrl512"
        case artworkUrl100 = "artworkUrl100"
        case artistViewUrl = "artistViewUrl"
        case supportedDevices = "supportedDevices"
        case features = "features"
        case kind = "kind"
        case trackId = "trackId"
        case title = "trackName"
        case sellerName = "sellerName"
        case genreIds = "genreIds"
        case formattedPrice = "formattedPrice"
        case releaseNotes = "releaseNotes"
        case primaryGenreName = "primaryGenreName"
        case releaseDate = "releaseDate"
        case isVppDeviceBasedLicensingEnabled = "isVppDeviceBasedLicensingEnabled"
        case currentVersionReleaseDate = "currentVersionReleaseDate"
        case primaryGenreId = "primaryGenreId"
        case currency = "currency"
        case trackCensoredName = "trackCensoredName"
        case languageCodesISO2A = "languageCodesISO2A"
        case fileSizeBytes = "fileSizeBytes"
        case sellerUrl = "sellerUrl"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case averageUserRatingForCurrentVersion = "averageUserRatingForCurrentVersion"
        case userRatingCountForCurrentVersion = "userRatingCountForCurrentVersion"
        case averageUserRating = "averageUserRating"
        case trackViewUrl = "trackViewUrl"
        case trackContentRating = "trackContentRating"
        case minimumOsVersion = "minimumOsVersion"
        case description = "description"
        case price = "price"
        case artistId = "artistId"
        case corpName = "artistName"
        case genres = "genres"
        case bundleId = "bundleId"
        case version = "version"
        case wrapperType = "wrapperType"
        case userRatingCount = "userRatingCount"
    }

}
