//
//  GameScene.swift
//  SupaplexLikeChat4
//
//  Created by Sergii Miroshnichenko on 08.09.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var grid: [[GameElement]] = []
    var gridNode = SKNode()

    override func didMove(to view: SKView) {
        setupGrid()
        
        backgroundColor = .cyan
    }

    func setupGrid() {
        for _ in 0..<numRows {
            var row: [GameElement] = []
            for _ in 0..<numColumns {
                row.append(.empty)
            }
            grid.append(row)
        }

        // Sample game elements for demonstration
        grid[4][4] = .player
        grid[5][5] = .rock
        grid[6][6] = .enemy
        
        grid[0][0] = .rock
        grid[9][9] = .rock
        grid[0][9] = .rock
        grid[9][0] = .rock

        drawGrid()
        
        gridNode.position = CGPoint(
            x: size.width/2 - CGFloat(numColumns) * cellSize/2,
            y: size.height/2 - CGFloat(numRows) * cellSize/2
        )
        addChild(gridNode)
    }

    func drawGrid() {
        for rowIndex in 0..<numRows {
            for colIndex in 0..<numColumns {
                
                let cellNode = SKSpriteNode(
                    color: grid[rowIndex][colIndex].color,
                    size: CGSize(
                        width: cellSize,
                        height: cellSize
                    )
                )
                
                cellNode.position = CGPoint(
                    x: CGFloat(colIndex) * cellSize + cellSize / 2,
                    y: CGFloat(rowIndex) * cellSize + cellSize / 2
                )
                gridNode.addChild(cellNode)
            }
        }
    }
}

