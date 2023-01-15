/// Wojciech Kosikowsi
/// January 2023
///
import Foundation

public class Maze {
    public var height: Int
    public var width: Int
    public let startX = 0
    public let startY = 0
    public var maze: [[Tile]] = []
    public var path: [Tile] = []

    public init(height: Int, width: Int) {
        self.height = height
        self.width = width
        generate()
    }

    public func getUnvisitedNeighbour(node: Tile) -> Tile? {
        var randList: [Tile] = []
        if node.posX > 0, !maze[node.posY][node.posX - 1].visited {
            randList.append(maze[node.posY][node.posX - 1])
        }
        if node.posY > 0, !maze[node.posY - 1][node.posX].visited {
            randList.append(maze[node.posY - 1][node.posX])
        }
        if node.posX < width - 1, !maze[node.posY][node.posX + 1].visited {
            randList.append(maze[node.posY][node.posX + 1])
        }
        if node.posY < height - 1, !maze[node.posY + 1][node.posX].visited {
            randList.append(maze[node.posY + 1][node.posX])
        }

        if randList.count == 1 {
            return randList[0]
        } else if randList.count > 1 {
            let randNum = Int.random(in: 0 ... randList.count - 1)
            return randList[randNum]
        } else {
            return nil
        }
    }

    public func link(nextNode: Tile, originNode: Tile) {
        if originNode.posX == nextNode.posX {
            if originNode.posY < nextNode.posY {
                originNode.downNode = nextNode
                nextNode.upNode = originNode
            } else if originNode.posY > nextNode.posY {
                originNode.upNode = nextNode
                nextNode.downNode = originNode
            }
        } else if originNode.posY == originNode.posY {
            if originNode.posX < nextNode.posX {
                originNode.rightNode = nextNode
                nextNode.leftNode = originNode
            } else if originNode.posX > nextNode.posX {
                originNode.leftNode = nextNode
                nextNode.rightNode = originNode
            }
        }
    }

    public func reset() {
        maze = []
        path = []
        for y in 0 ... height - 1 {
            var row: [Tile] = []
            for x in 0 ... width - 1 {
                row.append(Tile(y: y, x: x))
            }
            maze.append(row)
        }
    }

    public func generate() {
        reset()

        path.append(maze[startY][startX])
        var i = 0
        while !path.isEmpty {
            guard let current = path.last else {
                break
            }

            current.visited = true

            i += 1
            let nextNode = getUnvisitedNeighbour(node: current)
            if let nextNode = nextNode {
                link(nextNode: nextNode, originNode: current)
                path.append(nextNode)
            } else {
                path.removeAll { $0 == current }
            }
        }
        findPath(findX: width - 1, findY: height - 1)
    }

    public func findPath(findX: Int, findY: Int) {
        var current = maze[startY][startX]
        var pastNodes = [maze[startY][startX]]
        while current.posX != findX || current.posY != findY {
            let nextNode = current.getNeighbours(tile: current)
            if let nextNode = nextNode {
                pastNodes.append(nextNode)
                current = nextNode
            } else {
                pastNodes.removeAll { $0 == current }
                current = pastNodes[pastNodes.count - 1]
            }
        }
        path = pastNodes
    }
}

extension Maze: CustomDebugStringConvertible {
    public var debugDescription: String {
        var text = "Maze [ \n"

        for y in 0 ... height - 1 {
            text += "\t ["
            for x in 0 ... width - 1 {
                text = text + " \(maze[y][x]) "
            }
            text += "] \n"
        }
        text += "]"

        return text
    }
}
