//
//  BuildConfig.swift
//  Combine_Test
//
//  Created by 정지훈 on 2022/06/27.
//

import Foundation

// App Configuration Base
protocol AppConfiguration {
    
    var baseURL : String { get }
    var version : String { get }
    
    func isVPNConnected() -> Bool
    func isJailBrokenDevice() -> Bool
    func enableCertificatePinning() -> Bool
}

// App Configuration Set Base
protocol AppConfigurable {
    static var setAppState : AppConfiguration { get }
}
