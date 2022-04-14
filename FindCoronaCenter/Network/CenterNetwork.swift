//
//  CenterNetwork.swift
//  FindCoronaCenter
//
//  Created by Bo-Young PARK on 2021/09/26.
//

import Foundation
import Combine

/**
 * URLSession :
 * 앱과 서버간에 데이터를 주고받기 위해서 HTTP 사용
 * Alamofie, Moya 모두 URLSession을 wrapping 한 것
 */
class CenterNetwork {
    private let session: URLSession
    let api = CenterAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getCenterList() -> AnyPublisher<[Center], URLError> {
        guard let url = api.getCenterListComponents().url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.setValue("Infuser 3gUbMESKsPcNX1hxbGHzWQPY2uhJ6+d4Y/bPogATMZEwV7OJNfzXbYivSt02upze4G4/VYKFGKY25xgKl6my3g==", forHTTPHeaderField: "Authorization")
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.unknown)
                }
                
                // 위를 통과했으니, httpResponse 가 있는 경우
                switch httpResponse.statusCode {
                case 200..<300: // 정상 응답
                    return data
                case 400..<500: // 클라이언트 에러
                    throw URLError(.clientCertificateRejected)
                case 500..<599: // 서버 에러
                    throw URLError(.badServerResponse)
                default:        // 실패인데 잘 모르는 에러
                    throw URLError(.unknown)
                }
            }
            .decode(type: CenterAPIResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .mapError { $0 as! URLError }
            .eraseToAnyPublisher()
    }
}
