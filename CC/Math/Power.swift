import Foundation

precedencegroup PowPrecedence {
  lowerThan: BitwiseShiftPrecedence
  higherThan: MultiplicationPrecedence
  associativity: left
  assignment: false
}

infix operator ^ : PowPrecedence

public extension CGFloat {
  static func ^(lhs: CGFloat, rhs: CGFloat) -> CGFloat {
    return pow(lhs, rhs)
  }
}

