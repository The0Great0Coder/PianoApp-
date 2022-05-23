//
//  Piano.swift
//  notes
//
//  Created by Kadir Uraz Alacali on 11/05/2022.
//

import Foundation

class Piano{
    
    private static var firstkey = 24 //initialize in GameScene
    
    
    static let noteDict : [Int: String] = [0:"DO",1:"DOd",2:"RE",3:"REd",4:"MI",5:"FA",6:"FAd",7:"SOL",8:"SOLd",9:"LA",10:"LAd",11:"SI"]
    
    static let notePlace : [String: Int] = ["DO":0,"DOd":0,"RE":1,"REd":1,"MI":2,"FA":3,"FAd":3,"SOL":4,"SOLd":4,"LA":5,"LAd":5,"SI":6]
    
    
    class func setFirstKey(newFirstKey:Int){
        self.firstkey = newFirstKey
    }
    
    
    class func withDiese(note : String) -> Bool {
        switch note {
        case "DOd","REd","FAd","SOLd","LAd" :
                return true
        default :
                return false
        }
    }
    
    class func findNote(key:Int) -> String{
        return noteDict[(key-firstkey)%12]!
    }
    
    class func findSection(key:Int) -> Int{   //MIDDLE C is in section 3
        return Int((key - firstkey)/12)
    }
    
    class func findkey(section:Int , noteValue:Int) -> Int {
        print("section: ",section,"note: ",noteValue)
        return firstkey + section*12 + noteValue
    }
    
    class func findkey(section:Int , note:String) -> Int {
        
        if let noteval = noteDict.someKey(forValue: note) {
            return findkey(section: section, noteValue: noteval)
        }
        return -1
    }
    
}

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}

