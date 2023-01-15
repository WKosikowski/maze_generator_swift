import PlaygroundSupport
import SwiftUI
/// Wojciech Kosikowsi
/// January 2023
///
import UIKit

struct MazeView: View {
    let offset: Int = 30
    let tileSize: Int = 25
    var maze = Maze(height: 15, width: 20)

    var body: some View {
        let frameHeight = CGFloat(offset * 2 + maze.height * tileSize)
        let frameWidth = CGFloat(offset * 2 + maze.width * tileSize)
        ZStack {
            Path { path in

                path.move(to: CGPoint(x: offset, y: offset))
                path.addLine(to: CGPoint(x: offset + maze.width * tileSize, y: offset))
                path.addLine(to: CGPoint(x: offset + maze.width * tileSize, y: offset + maze.height * tileSize))
                path.addLine(to: CGPoint(x: offset, y: offset + maze.height * tileSize))
                path.addLine(to: CGPoint(x: offset, y: offset))
            }
            .stroke(.blue, lineWidth: 2.0)
            .frame(width: frameWidth, height: frameHeight, alignment: .center)
            Path { path in
                for y in 0 ... maze.height - 1 {
                    for x in 0 ... maze.width - 1 {
                        if maze.maze[y][x].rightNode != nil {
                        } else {
                            var wallPosX = offset + tileSize * (x + 1)
                            var wallPosY = offset + tileSize * (y + 1)

                            path.move(to: CGPoint(x: wallPosX, y: wallPosY))
                            path.addLine(to: CGPoint(x: wallPosX, y: wallPosY - tileSize))
                        }
                        if maze.maze[y][x].downNode != nil {
                        } else {
                            var wallPosX = offset + tileSize * (x + 1)
                            var wallPosY = offset + tileSize * (y + 1)

                            path.move(to: CGPoint(x: wallPosX, y: wallPosY))
                            path.addLine(to: CGPoint(x: wallPosX - tileSize, y: wallPosY))
                        }
                    }
                }
            }
            .stroke(.blue, lineWidth: 2.0)
            .frame(width: frameWidth, height: frameHeight, alignment: .center)

            Path { path in
                let startDrawPosX = CGFloat(offset + tileSize / 2)
                let startDrawPosY = CGFloat(offset + tileSize / 2)
                path.move(to: CGPoint(x: startDrawPosX, y: startDrawPosY))
                //  maze.findPath(findX: maze.width - 1, findY: maze.height - 1)
                for i in maze.path {
                    let nextDrawPosX = startDrawPosX + CGFloat(i.posX * tileSize)
                    let nextDrawPosY = startDrawPosY + CGFloat(i.posY * tileSize)
                    path.addLine(to: CGPoint(x: nextDrawPosX, y: nextDrawPosY))
                }
            }
            .stroke(.red, lineWidth: 2.0)
            .frame(width: frameWidth, height: frameHeight, alignment: .center)
        }
    }
}

PlaygroundPage.current.setLiveView(MazeView())
