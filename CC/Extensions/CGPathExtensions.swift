import CoreGraphics

public extension CGPath {
  private func _forEach(body: @escaping @convention(block) (CGPathElement) -> Void) {
    typealias Body = @convention(block) (CGPathElement) -> Void
    let callback: @convention(c) (UnsafeMutableRawPointer, UnsafePointer<CGPathElement>) -> Void = { (info, element) in
      let body = unsafeBitCast(info, to: Body.self)
      body(element.pointee)
    }
    let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
    self.apply(info: unsafeBody, function: unsafeBitCast(callback, to: CGPathApplierFunction.self))
  }

  enum PathElement {
    case moveTo(CGPoint)
    case lineTo(CGPoint)
    case quadCurveTo(p: CGPoint, a: CGPoint)
    case cubicCurveTo(p: CGPoint, a1: CGPoint, a2: CGPoint)
    case close
  }

  func forEach(body: (PathElement) -> Void) {
    applyWithBlock { elm in
      let elm = elm.pointee
      switch elm.type {
      case .moveToPoint:
        body(.moveTo(elm.points[0]))
      case .addLineToPoint:
        body(.lineTo(elm.points[0]))
      case .addQuadCurveToPoint:
        body(.quadCurveTo(p: elm.points[1], a: elm.points[0]))
      case .addCurveToPoint:
        body(.cubicCurveTo(p: elm.points[2], a1: elm.points[0], a2: elm.points[1]))
      case .closeSubpath:
        body(.close)
      @unknown default:
        break
      }
    }
  }

  func map(body: (PathElement) -> PathElement) -> CGPath {
    let mutablePath = CGMutablePath()
    forEach { elm in
      mutablePath.apply(body(elm))
    }
    return mutablePath
  }
}

public extension CGMutablePath {
  func apply(_ element: CGPath.PathElement) {
    let mutablePath = self
    switch element {
    case .close:
      mutablePath.closeSubpath()
    case let .lineTo(p):
      mutablePath.addLine(to: p)
    case let .moveTo(p):
      mutablePath.move(to: p)
    case let .quadCurveTo(p, a):
      mutablePath.addQuadCurve(to: p, control: a)
    case let .cubicCurveTo(p, a1, a2):
      mutablePath.addCurve(to: p, control1: a1, control2: a2)
    }
  }
}
