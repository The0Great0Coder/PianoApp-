//
//  SongScene.swift
//  NotesIos
//
//  Created by Kadir Uraz Alacali on 18/05/2022.
//

import Foundation
import SpriteKit
import Gong
import CoreMIDI

class SongScene:SKScene{
    
    var porte : Porte!
    var reader = JsonReader()
    var SongData : ResponseData!
    
    var allignednotesIndex = 0
    
    override func didMove(to view: SKView) {
        
    scene?.backgroundColor = Constants.getPorteGroundColor()
        
    if let partition = reader.loadJson(filename: "FantasticBeasts"){
        self.SongData = partition
    }
    else {
        print("can't read song")
    }
    
    porte = Porte(currentScene: self)
    porte.createLines()
    
    MIDI.connect()
    MIDI.addObserver(self)
    
    Piano.setFirstKey(newFirstKey: 24)
    
    createMenuBurger()
    createRestartIcon()
    playSong()

    
}
    
    func createMenuBurger(){
        let height = self.view!.frame.size.height / Constants.GetMenuLogosDivision()
        let width = self.view!.frame.size.height / Constants.GetMenuLogosDivision()
        let menuButton = TouchableNode(imagenamed: Constants.getmenubuttonTheme()){
            MIDI.disconnect()
            self.porte.CancelAllExpectedNotes()
            self.changeScene()
        }
        menuButton.position = CGPoint(x: -size.width/2 + width , y: size.height/2 - height)
        menuButton.size = CGSize(width: width, height: height)
        self.addChild(menuButton)
    }
    
    func createRestartIcon(){
        let height = self.view!.frame.size.height /  Constants.GetMenuLogosDivision()
        let width = self.view!.frame.size.height /  Constants.GetMenuLogosDivision()
        let reButton = TouchableNode(imagenamed: Constants.getrestartbuttonTheme()){
            self.porte.CancelAllExpectedNotes()
            self.allignednotesIndex = 0
            self.playSong()
        }
        reButton.position = CGPoint(x: size.width/2 - width , y: size.height/2 - height)
        reButton.size = CGSize(width: width, height: height)
        self.addChild(reButton)
    }
    
    func changeScene(){
        let reveal = SKTransition.reveal(with: .up,
                                                 duration: 1)
        
        
        if let MainScene = SKScene(fileNamed: "MainScene") {
            // Set the scale mode to scale to fit the window
            MainScene.scaleMode = .aspectFit
            MainScene.size = self.size
            // Present the scene
            scene?.view!.presentScene(MainScene,transition: reveal)
        }
    }
    
    func playSong(){
        
        for note in SongData.partition[allignednotesIndex].allignednotes {
            
            let key = Piano.findkey(section: note.section, note: note.name)
            porte.createExpectedNote(noteNumber: key)
        }
        
    }
    
    
    
}

extension SongScene: MIDIObserver {
    
    func receive(_ notice: MIDINotice) {
        print(notice)
    }
    
    func receive(_ packet: MIDIPacket, from source: MIDISource) {
        switch packet.message {
        case .noteOn(_, let key, _):
            print("on",key)
            if porte.isEspected(noteNumber: Int(key)) {
                porte.SuccessForExpectedNote(noteNumber: Int(key))
            }
            else {
                porte.createNote(noteNumber: Int(key))
            }
            
        case .noteOff(_, let key, _):
            print("off",key)
            if porte.isEspected(noteNumber: Int(key)){
                if porte.isAllSuccessfull() {
                    porte.RemoveAllExpectedNotes()
                    allignednotesIndex = allignednotesIndex + 1
                    playSong()
                } else {
                    porte.NoSuccessForExpectedNote(noteNumber: Int(key))
                }
                
            }else {
                porte.RemoveNote(noteNumber: Int(key))
            }

        default:
            break
        }
    }
    
}
