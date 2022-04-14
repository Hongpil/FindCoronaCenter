//
//  SelectRegionView.swift
//  FindCoronaCenter
//
//  Created by Bo-Young PARK on 2021/09/26.
//

import SwiftUI

struct SelectRegionView: View {
    /**
     * ObservableObject로 선언한 SelectRegionViewModel()를 바라보게 하려면,
     * @ObservedObject로 선언해줘야 된다.
     */
    @ObservedObject var viewModel = SelectRegionViewModel()
    
    private var items: [GridItem] {
        Array(repeating: .init(.flexible(minimum: 80)), count: 2)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: items, spacing: 20) {
                    ForEach(Center.Sido.allCases, id: \.id) { sido in
                        /**
                         * viewModel.centers는 sido를 Key로 갖는 Dictionary이다.
                         * 그래서
                         * viewModel.centers[sido] 이렇게 sido를 넣어주면
                         * 해당 sido가 가지고 있는 center의 list를 쭉 뽑아줌
                         */
                        let centers = viewModel.centers[sido] ?? []
                        NavigationLink(
                            destination: Text("Detail View~~!")) {
                            SelectRegionItem(region: sido, count: centers.count)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("코로나19 예방접종 센터")
        }
    }
}

struct SelectRegionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SelectRegionViewModel()
        SelectRegionView(viewModel: viewModel)
    }
}
