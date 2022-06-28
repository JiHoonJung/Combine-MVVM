//
//  RandomUserViewModel.swift
//  Combine_Test
//
//  Created by 정지훈 on 2022/06/23.
//

import Foundation
import Combine
import Alamofire

class RandomUserViewModel: ObservableObject {
    
    @Published var randomUsers: [RandomUser] = []
    
    var randomUserProtocol: RandomUserProtocol
    var subscription = Set<AnyCancellable>()

    init(randomUserProtocol: RandomUserProtocol = RandomUserReqeust()) {
        self.randomUserProtocol = randomUserProtocol
    }
    
    func fetchRandomUser() {
        self.randomUserProtocol.getRandomUserData(page: "1", results: "30")
            .compactMap({ $0 }) // Optional 제거 (unwrapping)
            .map({ $0.results })
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("데이터 스트림 완료")
            } receiveValue: { (receivedValue: [RandomUser]) in
                self.randomUsers = receivedValue
            }
            .store(in: &subscription)
    }
}
