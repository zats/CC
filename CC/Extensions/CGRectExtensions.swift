import CoreGraphics

public extension CGRect {
  init(center: CGPoint = .zero, size: CGSize) {
    self.init(origin: CGPoint(x: center.x - size.width * 0.5,
                              y: center.y - size.height * 0.5),
              size: size)
  }

  init(center: CGPoint = .zero, edges: CGFloat) {
    self.init(center: center, size: CGSize(width: edges, height: edges))
  }

  var center: CGPoint {
    return CGPoint(x: midX, y: midY)
  }
  
  var precscribedCircleRadius: CGFloat {
    return min(width, height) * 0.5
  }
}

public extension CGRect {
  /**
   Breakes current rectange into `stepsX` horizontal and `stepsY` vertical rectanges
   */
  func split(in stepsX: Int, _ stepsY: Int) -> [CGRect] {
    let width = self.width / CGFloat(stepsX)
    let height = self.height / CGFloat(stepsY)

    var splitted: [CGRect] = []
    for x in 0..<stepsX {
      for y in 0..<stepsY {
        let currentRect = CGRect(x: CGFloat(x) * width + minX,
                                 y: CGFloat(y) * height + minY,
                                 width: width,
                                 height: height)
        splitted.append(currentRect)
      }
    }
    return splitted
  }

  mutating func setSizeMaintainingCenter(_ size: CGSize) {
    self.origin += CGPoint(x: (self.width - size.width) * 0.5,
                           y: (self.height - size.height) * 0.5)
    self.size = size
  }

  func settingSizeMaintainingCenter(_ size: CGSize) -> CGRect {
    var rect = self
    rect.setSizeMaintainingCenter(size)
    return rect
  }
}
