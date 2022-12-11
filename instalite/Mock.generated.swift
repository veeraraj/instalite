// Generated using Sourcery 1.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.2.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
import Foundation
@testable import instalite


// MARK: - AccountRepositoryProtocol

open class AccountRepositoryProtocolMock: AccountRepositoryProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func fetchAccountInfo() throws -> AccountInfo {
        addInvocation(.m_fetchAccountInfo)
		let perform = methodPerformValue(.m_fetchAccountInfo) as? () -> Void
		perform?()
		var __value: AccountInfo
		do {
		    __value = try methodReturnValue(.m_fetchAccountInfo).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for fetchAccountInfo(). Use given")
			Failure("Stub return value not specified for fetchAccountInfo(). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_fetchAccountInfo

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_fetchAccountInfo, .m_fetchAccountInfo): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_fetchAccountInfo: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_fetchAccountInfo: return ".fetchAccountInfo()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func fetchAccountInfo(willReturn: AccountInfo...) -> MethodStub {
            return Given(method: .m_fetchAccountInfo, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchAccountInfo(willThrow: Error...) -> MethodStub {
            return Given(method: .m_fetchAccountInfo, products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func fetchAccountInfo(willProduce: (StubberThrows<AccountInfo>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_fetchAccountInfo, products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (AccountInfo).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func fetchAccountInfo() -> Verify { return Verify(method: .m_fetchAccountInfo)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func fetchAccountInfo(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_fetchAccountInfo, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - MediaRepositoryProtocol

open class MediaRepositoryProtocolMock: MediaRepositoryProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func fetchMediaInfo() throws -> MediaInfo {
        addInvocation(.m_fetchMediaInfo)
		let perform = methodPerformValue(.m_fetchMediaInfo) as? () -> Void
		perform?()
		var __value: MediaInfo
		do {
		    __value = try methodReturnValue(.m_fetchMediaInfo).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for fetchMediaInfo(). Use given")
			Failure("Stub return value not specified for fetchMediaInfo(). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func fetchAlbumInfo(for albumId: String) throws -> AlbumInfo {
        addInvocation(.m_fetchAlbumInfo__for_albumId(Parameter<String>.value(`albumId`)))
		let perform = methodPerformValue(.m_fetchAlbumInfo__for_albumId(Parameter<String>.value(`albumId`))) as? (String) -> Void
		perform?(`albumId`)
		var __value: AlbumInfo
		do {
		    __value = try methodReturnValue(.m_fetchAlbumInfo__for_albumId(Parameter<String>.value(`albumId`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for fetchAlbumInfo(for albumId: String). Use given")
			Failure("Stub return value not specified for fetchAlbumInfo(for albumId: String). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_fetchMediaInfo
        case m_fetchAlbumInfo__for_albumId(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_fetchMediaInfo, .m_fetchMediaInfo): return .match

            case (.m_fetchAlbumInfo__for_albumId(let lhsAlbumid), .m_fetchAlbumInfo__for_albumId(let rhsAlbumid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAlbumid, rhs: rhsAlbumid, with: matcher), lhsAlbumid, rhsAlbumid, "for albumId"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_fetchMediaInfo: return 0
            case let .m_fetchAlbumInfo__for_albumId(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_fetchMediaInfo: return ".fetchMediaInfo()"
            case .m_fetchAlbumInfo__for_albumId: return ".fetchAlbumInfo(for:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func fetchMediaInfo(willReturn: MediaInfo...) -> MethodStub {
            return Given(method: .m_fetchMediaInfo, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchAlbumInfo(for albumId: Parameter<String>, willReturn: AlbumInfo...) -> MethodStub {
            return Given(method: .m_fetchAlbumInfo__for_albumId(`albumId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchMediaInfo(willThrow: Error...) -> MethodStub {
            return Given(method: .m_fetchMediaInfo, products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func fetchMediaInfo(willProduce: (StubberThrows<MediaInfo>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_fetchMediaInfo, products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (MediaInfo).self)
			willProduce(stubber)
			return given
        }
        public static func fetchAlbumInfo(for albumId: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_fetchAlbumInfo__for_albumId(`albumId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func fetchAlbumInfo(for albumId: Parameter<String>, willProduce: (StubberThrows<AlbumInfo>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_fetchAlbumInfo__for_albumId(`albumId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (AlbumInfo).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func fetchMediaInfo() -> Verify { return Verify(method: .m_fetchMediaInfo)}
        public static func fetchAlbumInfo(for albumId: Parameter<String>) -> Verify { return Verify(method: .m_fetchAlbumInfo__for_albumId(`albumId`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func fetchMediaInfo(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_fetchMediaInfo, performs: perform)
        }
        public static func fetchAlbumInfo(for albumId: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_fetchAlbumInfo__for_albumId(`albumId`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

