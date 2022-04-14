//
//  SelectRegionViewModel.swift
//  FindCoronaCenter
//
//  Created by Bo-Young PARK on 2021/09/26.
//

import Foundation
import Combine

/**
 * ObservableObject :
 * Combine에서 제공하는 것으로  '외부에서 바라볼 수 있는 Object' 라는 의미
 */
class SelectRegionViewModel: ObservableObject {
    /**
     * [Center.Sido: [Center]] 이런 형태의 Dictionary 를 반환함
     * 왜냐하면, 메인화면 UI를 보면 알겠지만, "특정 시도의 센터가 몇개" 이런 형태로 받아야 하기 때문
     */
    @Published var centers = [Center.Sido: [Center]]()
    /**
     * Set<AnyCancellable>() :
     * 원하는 처리를 완료한 후, Publisher를 메모리에서 해제하는 방법
     * 보통 Collection 중의 하나인 Set을 이용해서 AnyCancellable 를 넣어서 관리함
     */
    private var cancellables = Set<AnyCancellable>()    //disposeBag
    /**
     * 만들어 두었던 "네트워크 통신을 통해 데이터를 받아오는 클래스" 호출
     */
    init(centerNetwork: CenterNetwork = CenterNetwork()) {
        /**
         * sink() :
         * Publisher를 구독하는 방법
         */
        centerNetwork.getCenterList()
            /**
             * ViewModel은 실제 View에 데이터를 뿌려줘야 하기 때문에
             * receive(on: )을 통해서 main 쓰레드에 뿌려준다.
             */
            .receive(on: DispatchQueue.main)
            /**
             * Subscriber
             * receiveValue, receiveCompletion 순서로 호출됨
             */
            .sink(
                /**
                 * 실패하지 않았으면, return 하고,
                 * 실패했다면, 에러를 print() 하고, centers 변수에는 빈 Dictionary 값을 저장한다.
                 */
                receiveCompletion: {[weak self] in
                    //print("called receiveCompletion!!!!!!!!!")
                    guard case .failure(let error) = $0 else { return }
                    print(error.localizedDescription)
                    self?.centers = [Center.Sido: [Center]]()
                },
                /**
                 * 정상적으로 데이터를 받은 경우
                 * grouping 이라는 Swift 문법을 이용해서,
                 * centers를 grouping하는데, 받은 데이터 중의 sido를 Key로 하는 Dictionary 형태로 저장한다.
                 */
                receiveValue: {[weak self] centers in
                    //print("called receiveValue!!!!!!!!!")
                    self?.centers = Dictionary(grouping: centers) { $0.sido }
                }
            )
            .store(in: &cancellables)   //disposed(by: disposeBag)
    }
}
