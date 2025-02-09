//
//  MockNetwork.swift
//  LiveScore
//
//  Created by Suraj Pathak on 9/2/2025.
//

import Foundation

class MockNetwork {
    
    static var mockURLSession: URLSession {
        let config: URLSessionConfiguration = .ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }
}

class MockURLProtocol: URLProtocol {
    
    static var requestHandler: ((URLRequest) -> (error: Error?, data: Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let mockError = Self.requestHandler?(request).error {
            client?.urlProtocol(self, didFailWithError: mockError)
            return
        } else if let mockData = Self.requestHandler?(request).data, let url = request.url {
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: mockData)
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {
        // not needed
    }
}
