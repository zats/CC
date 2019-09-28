import CoreGraphics

public struct Ray {
  public let origin: CGPoint
  public let direction: CGFloat

  public init(origin: CGPoint, direction: CGFloat) {
    self.origin = origin
    self.direction = direction
  }

  public init(origin: CGPoint, ref: CGPoint) {
    self.init(origin: origin, direction: ref.polarAngle(reference: origin))
  }

  public func intersection(with line: Line) -> CGPoint? {
    let directionUnit = CGPoint(angle: self.direction, distance: 1, from: self.origin)

    let p1 = line.a
    let p2 = line.b
    let p3 = origin
    let p4 = directionUnit

    let div = (p1.x - p2.x) * (p3.y - p4.y) - (p1.y - p2.y) * (p3.x - p4.x)
    if div == 0 {
      return nil
    }
    let t = ((p1.x - p3.x) * (p3.y - p4.y) - (p1.y - p3.y) * (p3.x - p4.x)) / div
    let u = -((p1.x - p2.x) * (p1.y - p3.y) - (p1.y - p2.y) * (p1.x - p3.x)) / div
    if (0...1).contains(t) && u > 0 {
      return p1.interpolated(to: p2, t: t)
    } else {
      return nil
    }
  }

  func clipped(to rect: CGRect) -> Line? {
    let lines = Polygon(rect: rect).edges

    let intersections = CGPoint.filterOutSimilar(lines.compactMap {
      self.intersection(with: $0)
    })

    if (intersections.count < 1) {
      return nil
    } else if (intersections.count == 1) {
      if origin.equal(to: intersections[0], precision: 2) {
        return nil
      }
      return Line(a: origin, b: intersections[0])
    } else if intersections.count == 2 {
      return Line(a: intersections[0], b: intersections[1])
    } else {
      fatalError("Failed: \(intersections)")
      return nil
    }
  }
}

public extension CGContext {
  func addRay(_ ray: Ray, in bounds: CGRect) {
    if bounds.contains(ray.origin) {
      self.addCircle(Circle(center: ray.origin, radius: 2))
    }
    if let clipped = ray.clipped(to: bounds) {
      self.addLine(clipped)
    }
  }
}

extension InfiniteLine {
  init(ray: Ray) {
    self.init(a: ray.origin, angle: ray.direction)
  }
}
