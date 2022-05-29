//
//  porte.swift
//  notes
//
//  Created by Kadir Uraz Alacali on 10/05/2022.
//

import Foundation
import SpriteKit
import SwiftUI

class Porte{
    
    var currentScene : SKScene
    var startPosition : Int = 0
    var up : Int = 0
    
    var notedOnPorte : [Int: SKShapeNode] = [:]
    var ExpectednoteOnPorte : [Int: SKShapeNode] = [:]

    
    init(currentScene:SKScene){
        self.currentScene = currentScene
        
    }
    

    
    
    func createLines(){
        let height = currentScene.view!.frame.size.height
        let roundedHeight = Int(height)
        let size : Int = Constants.GetLineSizeDivision()
        self.up = roundedHeight/(2*size)

        
        addLine(position: CGPoint(x: 0, y: 5*(self.up * 2)))
        addLine(position: CGPoint(x: 0, y: 4*(self.up * 2)))
        addLine(position: CGPoint(x: 0, y: 3*(self.up * 2)))
        addLine(position: CGPoint(x: 0, y: 2*(self.up * 2)))
        addLine(position: CGPoint(x: 0, y: 1*(self.up * 2)))
        
        addLine(position: CGPoint(x: 0, y: -1*(self.up * 2)))
        addLine(position: CGPoint(x: 0, y: -2*(self.up * 2)))
        addLine(position: CGPoint(x: 0, y: -3*(self.up * 2)))
        addLine(position: CGPoint(x: 0, y: -4*(self.up * 2)))
        addLine(position: CGPoint(x: 0, y: -5*(self.up * 2)))
        
        
        self.startPosition = -21 * self.up  //3 * 7 // section * notes per section
        
        print("selfup",self.up)

    
        let clefsol = SKSpriteNode(imageNamed: Constants.getsolAnahtariTheme())
        clefsol.position = CGPoint(x: Int(-currentScene.view!.frame.size.width)/2 + 120, y: 2*(roundedHeight/size))
        clefsol.size = CGSize(width: self.up*10, height: self.up*10)
        self.currentScene.addChild(clefsol)
        let cleffa = SKSpriteNode(imageNamed: Constants.getfaAnahtariTheme())
        cleffa.position = CGPoint(x: Int(-currentScene.view!.frame.size.width)/2 + 120, y: -2*(roundedHeight/size))
        cleffa.size = CGSize(width: self.up*8, height: self.up*10)
        self.currentScene.addChild(cleffa)

    }
    
    func addLine(position:CGPoint){
        print(position)
        let bar = SKShapeNode(rectOf: CGSize(width: currentScene.view!.frame.size.width - 200 , height: 3))
        bar.position = position
        bar.fillColor = Constants.getButonsAndLinesColor()
        bar.strokeColor = Constants.getPorteGroundColor()
        self.currentScene.addChild(bar)
    }
    
    
    func createNote(noteNumber:Int){
        let keyExists = self.notedOnPorte[noteNumber] != nil
        if !keyExists {

        let section : Int = Piano.findSection(key: Int(noteNumber))
        let note : String = Piano.findNote(key: Int(noteNumber))
        
        print("---------------")
        //print("section: ",section)
        //print("note place",Piano.notePlace[note]!)
        //print("note: ",note)
        
        let noteNode = SKShapeNode(circleOfRadius: CGFloat(self.up))
            noteNode.strokeColor = Constants.getNotesColor()
        noteNode.fillColor = Constants.getNotesColor()
        noteNode.alpha = 0.8
        let yPos : Int = self.startPosition + (section * 7 * self.up) + (Piano.notePlace[note]! * self.up)
        print(yPos)
        noteNode.position = CGPoint(x: 0, y: yPos)
        
        if Piano.withDiese(note: note){
        
            let diese = SKSpriteNode(imageNamed: Constants.getdieseTheme())
            diese.size = CGSize(width: 1.5 * Double(self.up), height: 1.5 * Double(self.up))
            diese.position = CGPoint(x: 1.4 * Double(self.up), y: 0.8 * Double(self.up))
            noteNode.addChild(diese)
            
        }
        
        self.currentScene.addChild(noteNode)
        self.notedOnPorte[noteNumber] = noteNode
    }
    }
    
    
    func RemoveNote(noteNumber:Int){
        
        if let noteNode = self.notedOnPorte[noteNumber] {
            animateNote(note: noteNode)
            self.notedOnPorte.removeValue(forKey: noteNumber)
        }
    }
    
    func animateNote(note:SKShapeNode){
        
        let moveToRight = SKAction.moveBy(x: -800, y: 0, duration: 4)
        var actions = Array<SKAction>()
        actions.append(moveToRight)
        actions.append(SKAction.fadeOut(withDuration: 2))
        let MoveAndFade = SKAction.group(actions)

        note.run(SKAction.sequence([
                                    //SKAction.wait(forDuration: 0.5),
                                    MoveAndFade,
                                    SKAction.removeFromParent()]))
    }
    
    
    /// EXPECTED NOTES
    
    
    func createExpectedNote(noteNumber:Int){
        let keyExists = self.ExpectednoteOnPorte[noteNumber] != nil
        if !keyExists {

        let section : Int = Piano.findSection(key: Int(noteNumber))
        let note : String = Piano.findNote(key: Int(noteNumber))
        
        let noteNode = SKShapeNode(circleOfRadius: CGFloat(self.up))
        noteNode.name="NSUCCESS"
        noteNode.strokeColor = Constants.getExpectedNotesColor()
        noteNode.fillColor = Constants.getExpectedNotesColor()
        noteNode.alpha = 0.8
        let yPos : Int = self.startPosition + (section * 7 * self.up) + (Piano.notePlace[note]! * self.up)
        noteNode.position = CGPoint(x:0, y: yPos)
        
        if Piano.withDiese(note: note){
        
            let diese = SKSpriteNode(imageNamed: Constants.getdieseTheme())
            diese.size = CGSize(width: 1.5 * Double(self.up), height: 1.5 * Double(self.up))
            diese.position = CGPoint(x: 1.4 * Double(self.up), y: 0.8 * Double(self.up))
            noteNode.addChild(diese)
            
        }
        
        self.currentScene.addChild(noteNode)
        self.ExpectednoteOnPorte[noteNumber] = noteNode
    }
    }
    
    func RemoveExpectedNote(noteNumber:Int){
        if let noteNode = self.ExpectednoteOnPorte[noteNumber] {
            if noteNode.name == "SUCCESS"{
            animateExpectedNote(note: noteNode)
            self.ExpectednoteOnPorte.removeValue(forKey: noteNumber)
            }
        }
    }
    
    func CancelAllExpectedNotes(){
        for (notenumber, notenode) in self.ExpectednoteOnPorte {
            self.ExpectednoteOnPorte.removeValue(forKey: notenumber)
            notenode.removeFromParent()
        }
    }
    
    func RemoveAllExpectedNotes(){
        for (notenumber, notenode) in self.ExpectednoteOnPorte {
        animateExpectedNote(note: notenode)
        self.ExpectednoteOnPorte.removeValue(forKey: notenumber)
        }
    }
    
    func SuccessForExpectedNote(noteNumber:Int){
        if let noteNode = self.ExpectednoteOnPorte[noteNumber] {
            noteNode.name="SUCCESS"
            noteNode.strokeColor = Constants.getExpectedNotesSuccessColor()
            noteNode.fillColor = Constants.getExpectedNotesSuccessColor()
        }
    }
    
    func NoSuccessForExpectedNote(noteNumber:Int){
        if let noteNode = self.ExpectednoteOnPorte[noteNumber] {
            noteNode.name="NSUCCESS"
            noteNode.strokeColor = Constants.getExpectedNotesColor()
            noteNode.fillColor = Constants.getExpectedNotesColor()
        }
    }
    
    func isEspected(noteNumber:Int) -> Bool{
        return self.ExpectednoteOnPorte[noteNumber] != nil
    }
    func isSuccess(noteNumber:Int) -> Bool{
        return self.ExpectednoteOnPorte[noteNumber]?.name == "SUCCESS"
    }
    
    func isAllSuccessfull() -> Bool {
        for (_,value) in self.ExpectednoteOnPorte {
            if value.name == "NSUCCESS" {
                return false
            }
        }
        return true
    }
    
    func animateExpectedNote(note:SKShapeNode){
        
        let moveToRight = SKAction.moveBy(x: -800, y: 0, duration: 4)
        var actions = Array<SKAction>()
        actions.append(moveToRight)
        actions.append(SKAction.fadeOut(withDuration: 2))
        let MoveAndFade = SKAction.group(actions)

        note.run(SKAction.sequence([
                                    //SKAction.wait(forDuration: 0.5),
                                    MoveAndFade,
                                    SKAction.removeFromParent()]))
    }
    
}
