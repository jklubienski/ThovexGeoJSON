//
//  AppModel.swift
//  ThovexGeoJSON
//
//  Created by James on 08/03/2023.
//

import Foundation
import Alamofire

class AppModel: NSObject {
    
    func getGeoJSON(completionHandler: @escaping (Data) -> Void) {
        
        let requestURL = "https://landstack-public-dev2.s3-eu-west-2.amazonaws.com/temp/testAppData.json"
        
        AF.request(requestURL)
            .responseData { (response) in
                switch response.result {
                case .success:
                    completionHandler(response.data!)
                case let .failure(error):
                    print(error)
                }
            }
    }
}
