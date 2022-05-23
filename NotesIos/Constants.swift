//
//  Constants.swift
//  NotesIos
//
//  Created by Kadir Uraz Alacali on 17/05/2022.
//

import Foundation
import SpriteKit

class Constants {
    
    static var Device:String = "iphone"
    
    static let MainLogosDivision : [String: CGFloat] = ["iphone":3,"ipad":7]
    static let MenuLogosDivision : [String: CGFloat] = ["iphone":10,"ipad":20]
    static let LineSizeDivision : [String: Int] = ["iphone":20,"ipad":30]

    class func SetDeviceType(){
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            print("iphone")
            Device = "iphone"
        case .pad:
            print("ipad")
            Device = "ipad"
        case .unspecified:
            print("unspecified")
            Device = "ipad"
        case .tv:
            print("tv")
            Device = "ipad"
        case .carPlay:
            print("carPlay")
            Device = "ipad"
        case .mac:
            print("mac")
            Device = "ipad"
        @unknown default:
            print("unknown")
            Device = "ipad"
        }
    }
    
    class func GetMainLogosDivision() -> CGFloat{
        return MainLogosDivision[Device]!
    }
    class func GetMenuLogosDivision() -> CGFloat{
        return MenuLogosDivision[Device]!
    }
    class func GetLineSizeDivision() -> Int{
        return LineSizeDivision[Device]!
    }
    
    
    /// THEMES 
    
     enum Themes: String {
        case Clear = "RIGHTHAND"
        case Dark = "LEFTHAND"
        case Colored = "BOTHHAND"
    }
    
    
    static var theme : Themes = Themes.Dark
    
    
    static let PorteGroundColor : [Themes: SKColor] = [
        Themes.Clear:SKColor.white,
        Themes.Dark:SKColor.black
    ]
    
    static let NotesColor : [Themes: SKColor] = [
        Themes.Clear:SKColor.black,
        Themes.Dark:SKColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
    ]
    
    static let ExpectedNotesColor : [Themes: SKColor] = [
        Themes.Clear:SKColor.gray,
        Themes.Dark:SKColor(red: 204/255, green: 204/255, blue: 255/255, alpha: 1)
    ]
    
    static let ExpectedNotesSuccessColor : [Themes: SKColor] = [
        Themes.Clear:SKColor.green,
        Themes.Dark:SKColor(red: 0/255, green: 255/255, blue: 128/255, alpha: 1)
    ]
    
    static let ButonsAndLinesColor : [Themes: SKColor] = [
        Themes.Clear:SKColor.black,
        Themes.Dark:SKColor.gray
    ]
    
    static let solAnahtariTheme : [Themes: String] = [
        Themes.Clear:"solAnahtari",
        Themes.Dark:"solAnahtariDarkTheme"
    ]
    
    static let faAnahtariTheme : [Themes: String] = [
        Themes.Clear:"faAnahtari",
        Themes.Dark:"faAnahtariDarkTheme"
    ]
    
    static let dieseTheme : [Themes: String] = [
        Themes.Clear:"diese",
        Themes.Dark:"dieseDarktheme"
    ]
    
    static let menubuttonTheme : [Themes: String] = [
        Themes.Clear:"menu",
        Themes.Dark:"menuDarkTheme"
    ]
    
    static let restartbuttonTheme : [Themes: String] = [
        Themes.Clear:"restart",
        Themes.Dark:"restartDarkTheme"
    ]
    
    static let RhandEmptyTheme : [Themes: String] = [
        Themes.Clear:"RhandEmpty",
        Themes.Dark:"RhandEmptyDarkTheme"
    ]
    
    static let LhandEmptyTheme : [Themes: String] = [
        Themes.Clear:"LhandEmpty",
        Themes.Dark:"LhandEmptyDarkTheme"
    ]
    
    class func getPorteGroundColor()->SKColor{
        return PorteGroundColor[theme]!
    }
    class func getNotesColor()->SKColor{
        return NotesColor[theme]!
    }
    class func getButonsAndLinesColor()->SKColor{
        return ButonsAndLinesColor[theme]!
    }
    class func getExpectedNotesColor()->SKColor{
        return ExpectedNotesColor[theme]!
    }
    class func getExpectedNotesSuccessColor()->SKColor{
        return ExpectedNotesSuccessColor[theme]!
    }
    class func getsolAnahtariTheme()->String{
        return solAnahtariTheme[theme]!
    }
    class func getfaAnahtariTheme()->String{
        return faAnahtariTheme[theme]!
    }
    class func getdieseTheme()->String{
        return dieseTheme[theme]!
    }
    class func getmenubuttonTheme()->String{
        return menubuttonTheme[theme]!
    }
    class func getrestartbuttonTheme()->String{
        return restartbuttonTheme[theme]!
    }
    class func getRhandEmptyTheme()->String{
        return RhandEmptyTheme[theme]!
    }
    class func getLhandEmptyTheme()->String{
        return LhandEmptyTheme[theme]!
    }
    
}
