import CoreGraphics

public extension CGSize {
  static func *(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
  }
  static func *(lhs: CGSize, rhs: CGVector) -> CGSize {
    return CGSize(width: lhs.width * rhs.dx,
                  height: lhs.height * rhs.dy)
  }
  static func *=(lhs: inout CGSize, rhs: CGVector)  {
    lhs = lhs * rhs
  }
  static func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
  }
  static func *=(lhs: inout CGSize, rhs: CGFloat) {
    lhs = lhs * rhs
  }
  static func *(lhs: CGFloat, rhs: CGSize) -> CGSize {
    return CGSize(width: rhs.width * lhs, height: rhs.height * lhs)
  }
  static func /(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width / rhs.width, height: lhs.height / rhs.height)
  }
  static func /(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
  }
  static func /=(lhs: inout CGSize, rhs: CGFloat) {
    lhs = lhs / rhs
  }
}

public extension CGSize {
  @inlinable static func random(inWidth widthRange: Range<CGFloat>, height heightRange: Range<CGFloat>) -> CGSize {
    return CGSize(width: CGFloat.random(in: widthRange),
                  height: CGFloat.random(in: heightRange))
  }

  @inlinable static func random(inWidth widthRange: ClosedRange<CGFloat>, height heightRange: ClosedRange<CGFloat>) -> CGSize {
    return CGSize(width: CGFloat.random(in: widthRange),
                  height: CGFloat.random(in: heightRange))
  }
}

public extension CGSize {
  static var a3: CGSize {
    return CGSize(width: 297, height: 420)
  }

  static var a4: CGSize {
    return CGSize(width: 210, height: 297)
  }
}

public extension CGSize {
  func flipped() -> CGSize {
    return CGSize(width: height, height: width)
  }

  mutating func flip() {
    self = self.flipped()
  }
}
