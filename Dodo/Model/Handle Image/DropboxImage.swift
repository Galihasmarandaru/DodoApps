//
//  DorpboxImage.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 30/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import SwiftyDropbox

let DropboxAPI_AccessToken = "7IqCkmuBNlAAAAAAAAABTmsyPPE039bW9rvjcbilba8n4WR61jomAvJLdi7hCTct"
let DropboxAPI_AppKey = "04ua43h1jrag0h4"
let BASE_LOCATION = "/home/Apps/DodoApps"
let client = DropboxClient(accessToken: DropboxAPI_AccessToken)


/*
 This is how to Upload File and get shareable link
 */

let fileData:Data = (UIImage(named: "Dodo")?.cgImage?.dataProvider?.data as Data?)!

//let fileData = "testing data example".data(using: String.Encoding.utf8, allowLossyConversion: false)!
let fileName:String = ""

let request = client.files.upload(path: BASE_LOCATION+fileName, input: fileData).response { response, error in
        if let response = response {
            let request = client.sharing.createSharedLinkWithSettings(path: response.pathDisplay!, settings: Sharing.SharedLinkSettings(requestedVisibility: .public_, linkPassword: nil, expires: nil, audience: nil, access: nil)).response(completionHandler: { (res, err) in
                if let res = res {
                    print(res.url)
                }
            })
            
        }
    }
    .progress { progressData in
        print(progressData)
}

