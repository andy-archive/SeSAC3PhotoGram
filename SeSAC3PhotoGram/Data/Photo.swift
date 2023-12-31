//
//  Photo.swift
//  SeSAC3PhotoGram
//
//  Created by Taekwon Lee on 2023/08/30.
//

import Foundation

//// MARK: - Photo
//struct Photo: Codable {
//    let total: Int
//    let totalPages: Int
//    let results: [PhotoResult]
//
//    enum CodingKeys: String, CodingKey {
//        case total
//        case totalPages = "total_pages"
//        case results
//    }
//}
//
//// MARK: - Result
//struct PhotoResult: Codable {
//    let id, slug: String
//    let createdAt, updatedAt: Date
//    let promotedAt: Date
//    let width, height: Int
//    let color, blurHash: String
//    let description: String
//    let altDescription: String
//    let urls: PhotoURL
//
//    enum CodingKeys: String, CodingKey {
//        case id, slug
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case promotedAt = "promoted_at"
//        case width, height, color
//        case blurHash = "blur_hash"
//        case description
//        case altDescription = "alt_description"
//        case urls
//    }
//}
//
//// MARK: - Urls
//struct PhotoURL: Codable {
//    let raw, full, regular, small: String
//    let thumb, smallS3: String
//
//    enum CodingKeys: String, CodingKey {
//        case raw, full, regular, small, thumb
//        case smallS3 = "small_s3"
//    }
//}

struct Photo: Codable {
    let total: Int
    let totalPages: Int
    let results: [PhotoResult]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

struct PhotoResult: Codable {
    let id: String
    let urls: PhotoURL
}

struct PhotoURL: Codable {
    let full: String
    let thumb: String
}
