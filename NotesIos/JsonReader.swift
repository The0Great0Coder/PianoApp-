//
//  JsonReader.swift
//  NotesIos
//
//  Created by Kadir Uraz Alacali on 18/05/2022.
//

import Foundation


    


struct ResponseData: Decodable {
    var partition: [Alligned]
}

struct Alligned: Decodable {
    var allignednotes: [Note]
}
struct Note : Decodable {
    var name: String
    var section: Int
    var size: Int
}

class JsonReader{
    
    func loadJson(filename fileName: String) -> ResponseData? {
        print(Bundle.main)
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json" ,subdirectory: ".") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    
    
}
