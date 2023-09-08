//
//  GameScene.swift
//  SupaplexLikeChat4
//
//  Created by Sergii Miroshnichenko on 08.09.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gridNode = SKNode()
    var grid: [[GameElement]] = []
    var playerPosition = (row: 4, col: 4)

    override func didMove(to view: SKView) {
        setupGrid()
        
        backgroundColor = .cyan
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    override func willMove(from view: SKView) {
        for recognizer in view.gestureRecognizers ?? [] {
            view.removeGestureRecognizer(recognizer)
        }
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
    
    func movePlayer(to newPosition: (row: Int, col: Int)) {
        // Check if the new position is within the grid bounds
        guard newPosition.row >= 0, newPosition.row < numRows,
              newPosition.col >= 0, newPosition.col < numColumns,
              grid[newPosition.row][newPosition.col] == .empty else {
            return
        }

        // Update the grid values
        grid[playerPosition.row][playerPosition.col] = .empty
        grid[newPosition.row][newPosition.col] = .player

        // Update the player's position
        playerPosition = newPosition

        // Redraw the grid
        gridNode.removeAllChildren()
        drawGrid()
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: self.inputView)

        // Convert tap location to grid coordinates
        let column = Int((tapLocation.x - gridNode.position.x) / cellSize)
        let row = numRows - 1 - Int((tapLocation.y - gridNode.position.y) / cellSize)

        // Determine movement direction
        if column > playerPosition.col {
            movePlayer(to: (playerPosition.row, playerPosition.col + 1))
        } else if column < playerPosition.col {
            movePlayer(to: (playerPosition.row, playerPosition.col - 1))
        } else if row > playerPosition.row {
            movePlayer(to: (playerPosition.row + 1, playerPosition.col))
        } else if row < playerPosition.row {
            movePlayer(to: (playerPosition.row - 1, playerPosition.col))
        }
    }

}

