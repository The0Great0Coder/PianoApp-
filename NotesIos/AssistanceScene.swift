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
import SwiftUI

class AssistanceScene: SKScene {
    
    var porte : Porte!
    var rhand : TouchableNode!
    var lhand : TouchableNode!

    enum Suit: String {
        case Right = "RIGHTHAND"
        case Left = "LEFTHAND"
        case Both = "BOTHHAND"
        case NoHand = "NOHAND"
    }

    var activeHand = Suit.NoHand
    var Ractive : Bool = false
    var Lactive : Bool = false
    
    var label : SKLabelNode!
    var succes : Int = 0
    var total : Int = 0

    override func didMove(to view: SKView) {
        
        scene?.backgroundColor = Constants.getPorteGroundColor()
        porte = Porte(currentScene: self)
        porte.createLines()
        
        MIDI.connect()
        MIDI.addObserver(self)
        
        Piano.setFirstKey(newFirstKey: 24)
        
        randomNoteCreate(category: activeHand)
        
        createMenuBurger()
        createHandIcons()
        createBottomLabel()
    }
    
    func createMenuBurger(){
        let height = self.view!.frame.size.height / Constants.GetMenuLogosDivision()
        let width = self.view!.frame.size.height / Constants.GetMenuLogosDivision()
        let menuButton = TouchableNode(imagenamed: Constants.getmenubuttonTheme()){
            MIDI.disconnect()
            self.porte.RemoveAllExpectedNotes()
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
    
    func createBottomLabel(){
        let rectangle = CGRect(x: -self.view!.frame.size.width/2 + 100 , y: -size.height/2 + 30, width: self.view!.frame.size.width - 200, height: 40)
        
        //let RectNode = SKShapeNode(rect: rectangle)
       // RectNode.fillColor = SKColor.black
       // RectNode.alpha = 0.8
        //self.addChild(RectNode)
        
        
        label = SKLabelNode(text: "please select the hand you want to practice from the upper right corner")
        label.position = CGPoint(x: 0, y:  -size.height/2 + 20)
        label.fontColor = Constants.getButonsAndLinesColor()
        adjustLabelFontSizeToFitRect(labelNode: label, rect: rectangle )
        self.addChild(label)
    }
    
    func adjustLabelFontSizeToFitRect(labelNode:SKLabelNode, rect:CGRect) {

    // Determine the font scaling factor that should let the label text fit in the given rectangle.
    let scalingFactor = min(rect.width / labelNode.frame.width, rect.height / labelNode.frame.height)

    // Change the fontSize.
    labelNode.fontSize *= scalingFactor

    // Optionally move the SKLabelNode to the center of the rectangle.
    labelNode.position = CGPoint(x: rect.midX, y: rect.midY - labelNode.frame.height / 2.0)
    }
    
    func createHandIcons(){
        let height = self.view!.frame.size.height /  Constants.GetMenuLogosDivision()
        let width = self.view!.frame.size.height /  Constants.GetMenuLogosDivision()
        rhand = TouchableNode(imagenamed: Constants.getRhandEmptyTheme()){
            self.Ractive = !self.Ractive
            self.handSelect()
        }
        rhand.position = CGPoint(x: size.width/2 - width , y: size.height/2 - height)
        rhand.size = CGSize(width: width, height: height)
        self.addChild(rhand)
        
        lhand = TouchableNode(imagenamed: Constants.getLhandEmptyTheme()){
            self.Lactive = !self.Lactive
            self.handSelect()
        }
        lhand.position = CGPoint(x: size.width/2 - 2.5 * width , y: size.height/2 - height)
        lhand.size = CGSize(width: width, height: height)
        self.addChild(lhand)
    }
    
    func handSelect(){
        if Lactive && Ractive {
            rhand.texture = SKTexture(imageNamed: "Rhand")
            lhand.texture = SKTexture(imageNamed: "Lhand")
            activeHand = Suit.Both
        }
        else if Lactive && !Ractive {
            rhand.texture = SKTexture(imageNamed:  Constants.getRhandEmptyTheme())
            lhand.texture = SKTexture(imageNamed: "Lhand")
            activeHand = Suit.Left
        }
        else if !Lactive && Ractive {
            rhand.texture = SKTexture(imageNamed: "Rhand")
            lhand.texture = SKTexture(imageNamed:  Constants.getLhandEmptyTheme())
            activeHand = Suit.Right
        }
        else if !Lactive && !Ractive {
            rhand.texture = SKTexture(imageNamed:  Constants.getRhandEmptyTheme())
            lhand.texture = SKTexture(imageNamed: Constants.getLhandEmptyTheme())
            activeHand = Suit.NoHand
            label.text = "please select the hand you want to practice from the upper right corner"
        }
        
        if activeHand != Suit.NoHand {
            if self.total > 0 {
                label.text = String(self.succes) + "/" + String(self.total) + "  Accuracy: " + String(self.succes/self.total)
            } else {
                label.text = "play the right note !"
            }

        }
        
        porte.RemoveAllExpectedNotes()
        randomNoteCreate(category: activeHand)
    }
    
    
    func randomNoteCreate(category: Suit){
        
        if category == Suit.NoHand{return}
        
        var category_Temp = category
        var porteSection = 0
        var PorteNote = 0
   
        if category_Temp == Suit.Both {
            let CanBeRight = Bool.random()
            
            if CanBeRight {
                category_Temp = Suit.Right
            } else {
                category_Temp = Suit.Left
            }
            
        }
            
        if category_Temp == Suit.Right{
             porteSection = Int.random(in: 3...4)
             PorteNote = porteSection == 3 ? Int.random(in: 0...11) : Int.random(in: 0...10)
        }
        if category_Temp == Suit.Left {
             porteSection = Int.random(in: 1...2)
             PorteNote = porteSection == 1 ? Int.random(in: 3...11) : Int.random(in: 0...11)
    }
        
        
         let key = Piano.findkey(section: porteSection, noteValue: PorteNote)
         porte.createExpectedNote(noteNumber: key)

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension AssistanceScene: MIDIObserver {
    
    func receive(_ notice: MIDINotice) {
        print(notice)
    }
    
    func receive(_ packet: MIDIPacket, from source: MIDISource) {
        switch packet.message {
        case .noteOn(_, let key, _):
            print("on",key)
            if porte.isEspected(noteNumber: Int(key)) {
                porte.SuccessForExpectedNote(noteNumber: Int(key))
                self.succes += 1
                self.total += 1
                label.text = String(self.succes) + "/" + String(self.total) + "  Accuracy: " + String(Int(Double(self.succes)/Double(self.total)*100)) + "%"
            }
            else {
                porte.createNote(noteNumber: Int(key))
                
                if !porte.ExpectednoteOnPorte.isEmpty {
                    self.total += 1
                    label.text = String(self.succes) + "/" + String(self.total) + "  Accuracy: " + String(Int(Double(self.succes)/Double(self.total)*100)) + "%"
                }
            }
            
        case .noteOff(_, let key, _):
            print("off",key)
            if porte.isEspected(noteNumber: Int(key)) && porte.isSuccess(noteNumber: Int(key)) {
                porte.RemoveExpectedNote(noteNumber: Int(key))
                randomNoteCreate(category: activeHand)
            }else {
                porte.RemoveNote(noteNumber: Int(key))
            }

        default:
            break
        }
    }
    
}

