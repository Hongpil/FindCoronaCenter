//
//  CenterAPI.swift
//  FindCoronaCenter
//
//  Created by Bo-Young PARK on 2021/09/26.
//

import Foundation

struct CenterAPI {
    static let scheme = "https"
    static let host = "api.odcloud.kr"
    static let path = "/api/15077586/v1/centers"
    
    /**
     * URLComponents 사용하는 이유 :
     * 일반적으로 HTTP 요청시 아래와 같이 요청하는데, 가독성도 좋지 않고 오타가 있을 수 있는 문제가 있음
     * [GET] http(s)://[hostname]/login/oauth/authorize?client_id=\(client_id)&scope=\(scope)
     * 실제 요청 URL : https://api.odcloud.kr/api/15077586/v1/centers?page=1&perPage=1000&serviceKey=3gUbMESKsPcNX1hxbGHzWQPY2uhJ6+d4Y/bPogATMZEwV7OJNfzXbYivSt02upze4G4/VYKFGKY25xgKl6my3g/3D/3D
     *
     * 그래서 URLComponents를 사용해 아래 코드와 같이 좀 더 깔끔하게 사용할 수 있음 !
     */
    func getCenterListComponents() -> URLComponents {
        var components = URLComponents()
        
        components.scheme = CenterAPI.scheme
        components.host = CenterAPI.host
        components.path = CenterAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "perPage", value: "300")
        ]
        
        return components
    }
}
