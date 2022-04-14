//
//  Center.swift
//  FindCoronaCenter
//
//  Created by Bo-Young PARK on 2021/09/26.
//

import Foundation
import CoreLocation

/**
 * 총 응답 값 Sample
 * {
 *      "page": 0,
 *      "perPage": 0,
 *      "totalCount": 0,
 *      "currentCount": 0,
 *      "data": [
 *        {
 *          "id": 0.
 *          "centerName": "string",
 *          "sido": "string",
 *          "sigungu": "string",
 *          "facilityName": "string",
 *          "zipCode": "string",
 *          "address": "string",
 *          "lat": "string",
 *          "lng": "string",
 *          "createdAt": "string",
 *          "updatedAt": "string",
 *          "centerType": "string",
 *          "org": "string",
 *          "phoneNumber": "string"
 *        }
 *      ]
 * }
 */
/**
 * 어떤 값을 받을 지 정의
 */
struct Center: Hashable, Decodable {
    let id: Int
    let sido: Sido // string 타입으로 정의해도 되지만, 정해져 있기 때문에 enum 으로 받는 것이 좋음
    let facilityName: String
    let address: String
    let lat: String
    let lng: String
    let centerType: CenterType // string 타입으로 정의해도 되지만, 정해져 있기 때문에 enum 으로 받는 것이 좋음
    let phoneNumber: String
    
    enum CenterType: String, Decodable {
        case central = "중앙/권역"
        case local = "지역"
    }
    
    enum Sido: String, Decodable, CaseIterable, Identifiable {
        case 서울특별시
        case 부산광역시
        case 대구광역시
        case 인천광역시
        case 광주광역시
        case 대전광역시
        case 울산광역시
        case 세종특별자치시
        case 경기도
        case 강원도
        case 충청북도
        case 충청남도
        case 전라북도
        case 전라남도
        case 경상북도
        case 경상남도
        case 제주특별자치도
        
        var id: String {
            return self.rawValue
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: CLLocationDegrees(self.lat) ?? .zero,
            longitude: CLLocationDegrees(self.lng) ?? .zero
        )
    }
}
