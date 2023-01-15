/// Wojciech Kosikowsi
/// January 2023
///
///
import Foundation

public class Tile: Equatable {
    public var visited = false
    public var neighbourTilesVisited = 0
    public var posX: Int
    public var posY: Int
    public var upNode: Tile?
    public var rightNode: Tile?
    public var downNode: Tile?
    public var leftNode: Tile?

    public init(y: Int, x: Int) {
        posX = x
        posY = y
    }

    public func getNeighbours(tile _: Tile) -> Tile? {
        let next = [upNode, rightNode, downNode, leftNode].compactMap { $0 }.filter { $0.visited }.first
        next?.visited = false
        return next
    }

    public static func == (lhs: Tile, rhs: Tile) -> Bool {
        return lhs.posX == rhs.posX && lhs.posY == rhs.posY
    }

    private func linkedTo() -> String {
        return "\(upNode == nil ? "" : "u")\(downNode == nil ? "" : "d")\(leftNode == nil ? "" : "l")\(rightNode == nil ? "" : "r")"
    }
}

extension Tile: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "(\(posX), \(posY))" + linkedTo()
    }
}
