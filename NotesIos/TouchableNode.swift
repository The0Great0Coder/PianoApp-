//
//  TouchableNode.swift
//  NotesIos
//
//  Created by Kadir Uraz Alacali on 15/05/2022.
//

import Foundation
import SpriteKit

class TouchableNode :SKSpriteNode{
    
    var action : () -> Void
    
    init( imagenamed:String , actionButtonClosure: @escaping () -> Void) {
        self.action = actionButtonClosure
        let texture = SKTexture(imageNamed: imagenamed)
        super.init(texture: texture, color: .clear, size: texture.size())
        self.isUserInteractionEnabled = true

}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clickFunctionNotSet(){
        print("Click function not set")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        action()
    }
    
    
}
