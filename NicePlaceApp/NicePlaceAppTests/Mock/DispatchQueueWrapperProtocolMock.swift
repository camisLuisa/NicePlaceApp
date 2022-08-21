//
//  DispatchQueueWrapperProtocolMock.swift
//  NicePlaceAppTests
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import Foundation
@testable import NicePlaceApp

struct DispatchQueueWrapperProtocolMock: DispatchQueueWrapperProtocol {
    func mainAsync(completion: @escaping () -> Void) {
        completion()
    }
}
