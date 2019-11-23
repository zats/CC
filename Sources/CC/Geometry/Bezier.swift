import CoreGraphics

public struct CubicBezier {

  public var p1: CGPoint
  public var p2: CGPoint
  public var c1: CGPoint
  public var c2: CGPoint

  public init(p1: CGPoint, p2: CGPoint, c1: CGPoint, c2: CGPoint) {
    self.p1 = p1
    self.p2 = p2
    self.c1 = c1
    self.c2 = c2
  }

  public init(p1: CGPoint, p2: CGPoint, smoothing: CGFloat) {
    let p2p1 = p2 - p1
    let p3p2 = p1 - p2
    let p2p1Angle = p2p1.angle - CGFloat.pi / 6
    let p3p2Angle = p3p2.angle + CGFloat.pi / 6
    let c1 = CGPoint(angle: p2p1Angle,
                    distance: p2p1.length * smoothing,
                    from: p1)
    let c2 = CGPoint(angle: p3p2Angle,
                     distance: p3p2.length * smoothing,
                     from: p2)
    self.init(p1: p1, p2: p2, c1: c1, c2: c2)
  }

  public func point(at t: CGFloat) -> CGPoint {
    return pow(1 - t, 3) * p1
      + 3 * pow(1 - t, 2) * t * c1
      + 3 * (1 - t) * t * t * c2
      + t * t * t * p2
  }

  public func angle(at t: CGFloat) -> CGFloat {
    // following expression broken down into components to help compiler
    let _p0: CGPoint = -3 * ((1-t)^2) * p1
    let _p1: CGPoint = 3 * ((1-t)^2) * c1 - 6 * t * (1-t) * c1
    let _p2: CGPoint = 3 * (t^2) * c2 + 6 * t * (1 - t) * c2
    let _p3: CGPoint = 3 * (t^2) * p2
    let der: CGPoint = _p0 + _p1 - _p2 + _p3
    return atan2(der.y, der.x)
  }

  public func simplified(n: Int) -> [Line] {
    let points = stride(from: CGFloat(0), through: 1, by: 1/CGFloat(n))
      .map {
        self.point(at: $0)
      }
    return points
      .enumerate(by: 2, step: 1)
      .dropLast()
      .map { Line(a: $0[0], b: $0[1] )}
  }

  public func length(simplification: Int = 10) -> CGFloat {
    return simplified(n: simplification).reduce(0, { $0 + $1.length })
  }

  public func intersection(with ray: Ray, simplification: Int = 10) -> CGPoint? {
    return simplified(n: simplification)
      .compactMap({
        ray.intersection(with: $0)
      }).sorted(by: {
        ray.origin.distance(to: $0) < ray.origin.distance(to: $1)
      }).first
  }

  public func split(at t: CGFloat) -> (left: CubicBezier?, right: CubicBezier?) {
    let q = hull(at: t).vertices
    let left = CubicBezier(p1: q[0], p2: q[9], c1: q[4], c2: q[7])
    let right = CubicBezier(p1: q[9], p2: q[3], c1: q[8], c2: q[6])
    if t == 0 {
      return (left: nil, right: right)
    } else if t == 1 {
      return (left: left, right: nil)
    } else {
      return (left: left, right: right)
    }
  }

  public func hull(at t: CGFloat) -> Polygon {
    var p = [self.p1, self.c1, self.c2, self.p2]
    var q = p
    while p.count > 1 {
      var _p: [CGPoint] = []
      let l = p.count - 1
      for i in 0..<l {
        let pt = p[i].interpolated(to: p[i+1], t: t)
        q.append(pt);
        _p.append(pt);
      }
      p = _p;
    }
    return Polygon(vertices: q)
  }
}


public extension CGContext {
  func addCubicBeizer(_ curve: CubicBezier) {
    self.move(to: curve.p1)
    self.addCurve(to: curve.p2, control1: curve.c1, control2: curve.c2)
  }
}

