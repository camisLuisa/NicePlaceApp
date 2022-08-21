//
//  DispatchQueueWrapper.swift
//  NicePlaceApp
//
//  Created by Camila Luísa Farias on 21/08/22.
//

import Foundation

protocol DispatchQueueWrapperProtocol {
    func mainAsync(completion: @escaping () -> Void)
}

struct DispatchQueueWrapper: DispatchQueueWrapperProtocol {
    func mainAsync(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            completion()
        }
    }
}
