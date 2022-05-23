//
//  MainScene.swift
//  notes
//
//  Created by Kadir Uraz Alacali on 14/05/2022.
//

import Foundation
import SpriteKit


class MainScene: SKScene {

    override func didMove(to view: SKView) {
        createActivities()
    }

    
    func createActivities(){
        let height = self.view!.frame.size.height / Constants.GetMainLogosDivision()
        let width = self.view!.frame.size.height / Constants.GetMainLogosDivision()
        let playButton = TouchableNode(imagenamed: "play"){
            self.changeScene(scenename: "SongScene")
        }
        playButton.position = CGPoint(x: 0 , y: 0)
        playButton.size = CGSize(width: width, height: height)
        self.addChild(playButton)
        
        let practiceButton = TouchableNode(imagenamed: "practice"){
            self.changeScene(scenename: "AssistanceScene")
        }
        practiceButton.position = CGPoint(x: 1.5*width , y: 0 )
        practiceButton.size = CGSize(width: width, height: height)
        self.addChild(practiceButton)
        
        let readButton = TouchableNode(imagenamed: "read"){
            self.changeScene(scenename: "NoteScene")
        }
        readButton.position = CGPoint(x: -1.5*width , y: 0)
        readButton.size = CGSize(width: width, height: height)
        self.addChild(readButton)
        
    }
    
    
    func changeScene(scenename:String){
        let reveal = SKTransition.reveal(with: .down,
                                                 duration: 1)
 
        if let NoteScene = SKScene(fileNamed: scenename) {
     
            // Present the scene
            scene?.view!.presentScene(NoteScene,transition: reveal)
        }
    }
    
}

