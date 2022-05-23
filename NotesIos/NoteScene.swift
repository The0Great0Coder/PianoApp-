//
//  GameScene.swift
//  notes
//
//  Created by Kadir Uraz Alacali on 10/05/2022.
//

import SpriteKit
import GameplayKit
import Gong
import CoreMIDI

class NoteScene: SKScene {

    var porte : Porte!

    override func didMove(to view: SKView) {
        
        scene?.backgroundColor = Constants.getPorteGroundColor()
        porte = Porte(currentScene: self)
        porte.createLines()
                
        MIDI.connect()
        MIDI.addObserver(self)
        
        Piano.setFirstKey(newFirstKey: 24)
        createMenuBurger()
        
    }
    
    func createMenuBurger(){
        let height = self.view!.frame.size.height/10
        let width = self.view!.frame.size.height/10
        let menuButton = TouchableNode(imagenamed: Constants.getmenubuttonTheme()){
            MIDI.disconnect()
            self.changeScene()
        }
        menuButton.position = CGPoint(x: -size.width/2 + width , y: size.height/2 - height)
        menuButton.size = CGSize(width: width, height: height)
        self.addChild(menuButton)
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
    

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension NoteScene: MIDIObserver {
    
    func receive(_ notice: MIDINotice) {
        print(notice)
    }
    
    func receive(_ packet: MIDIPacket, from source: MIDISource) {
        switch packet.message {
        case .noteOn(_, let key, _):
            print("on",key)
            porte.createNote(noteNumber: Int(key))
        case .noteOff(_, let key, _):
            print("off",key)
            porte.RemoveNote(noteNumber: Int(key))

        default:
            break
        }
    }
    
}
