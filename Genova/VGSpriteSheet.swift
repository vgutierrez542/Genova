//
//  VGSpriteSheet.swift
//  Genova
//
//  Created by Victor Gutierrez on 2/14/18.
//  Copyright © 2018 Victor Gutierrez. All rights reserved.
//

import Foundation
import SpriteKit

class VGSpriteSheet {
   private let frame: SKTexture
   private let rows: Int
   private let columns: Int
   private var margin: CGFloat = 0
   private var spacing: CGFloat = 0
   private var frameSize: CGSize {
        return CGSize(width: (self.frame.size().width-(self.margin*2 + self.spacing*CGFloat(self.columns-1)))/CGFloat(self.columns), height: (self.frame.size().height-(self.margin*2 + self.spacing*CGFloat(self.rows - 1)))/CGFloat(self.rows))
    }
    
    init(frame: SKTexture, rows: Int, columns: Int, spacing: CGFloat, margin: CGFloat) {
        self.frame = frame
        self.rows = rows
        self.columns = columns
        self.spacing = spacing
        self.margin = margin
    }
    
    convenience init(frame: SKTexture, rows: Int, columns: Int) {
        self.init(frame: frame, rows: rows, columns: columns, spacing: 0, margin: 0)
    }
    
    func textureForColumn(column: Int, row: Int) -> SKTexture? {
        
        // x and y are the size of the image
        // that the sprite will be in
        var x = self.margin + CGFloat(column) * (self.frameSize.width + self.spacing) - self.spacing;
        var y = self.margin + CGFloat(row) * (self.frameSize.width + self.spacing) - self.spacing;
        
        var width = self.frameSize.width;
        var height = self.frameSize.height;
        
        if !(0...self.rows ~= row && 0...self.columns ~= column) {
            // location is out of bounds
            return nil
        }
        
        var textureRect = CGRect(x: x , y: y, width: width, height: height)
       
        x = textureRect.origin.x / self.frame.size().width;
        y = textureRect.origin.y / self.frame.size().height;
        width = textureRect.size.width/self.frame.size().width;
        height = textureRect.size.height/self.frame.size().height;
        
        textureRect = CGRect(x: x, y: y, width: width, height: height)
        return SKTexture(rect: textureRect, in: self.frame)
    }
    
    func getColumns() -> Int {
        return columns
    }
    
    func getRows() -> Int {
        return rows 
    }
    
}
