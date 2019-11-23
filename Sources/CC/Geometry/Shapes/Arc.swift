import CoreGraphics

public struct Arc {
  public var start: CGFloat
  public var end: CGFloat
  public var center: CGPoint
  public var radius: CGFloat

  public var clockwise: Bool = true

  public init(center: CGPoint, radius: CGFloat, start: CGFloat, end: CGFloat, clockwise: Bool = false) {
    self.center = center
    self.radius = radius
    self.start = start
    self.end = end
    self.clockwise = clockwise
  }
}

public extension CGContext {
  func addArc(_ arc: Arc) {
    self.addArc(center: arc.center, radius: arc.radius, startAngle: arc.start, endAngle: arc.end, clockwise: arc.clockwise)
  }
}
