//
//  CenterAPIReponse.swift
//  FindCoronaCenter
//
//  Created by Bo-Young PARK on 2021/09/26.
//

import Foundation

/**
 * 응답값 정의
 */
struct CenterAPIResponse: Decodable {
    let data: [Center]
}
