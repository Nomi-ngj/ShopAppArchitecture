
import Foundation

public final class Debouncer {
    private var work: DispatchWorkItem?
    public init() {}
    public func run(after delay: TimeInterval, action: @escaping () -> Void) {
        work?.cancel()
        let item = DispatchWorkItem(block: action)
        work = item
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: item)
    }
}
