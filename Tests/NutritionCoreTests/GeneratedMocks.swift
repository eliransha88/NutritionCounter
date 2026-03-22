// MARK: - Mocks generated from file: 'Modules/Core/Sources/AppGroup.swift'

import Cuckoo
import Foundation
@testable import NutritionCore



// MARK: - Mocks generated from file: 'Modules/Core/Sources/DailyGoals.swift'

import Cuckoo
import Foundation
@testable import NutritionCore



// MARK: - Mocks generated from file: 'Modules/Core/Sources/DailyLog.swift'

import Cuckoo
import Foundation
@testable import NutritionCore



// MARK: - Mocks generated from file: 'Modules/Core/Sources/NutrientType.swift'

import Cuckoo
import SwiftUI
@testable import NutritionCore



// MARK: - Mocks generated from file: 'Modules/Core/Sources/NutritionStoreProtocol.swift'

import Cuckoo
import Foundation
import Observation
@testable import NutritionCore

public class MockNutritionStoreProtocol: NutritionStoreProtocol, Cuckoo.ProtocolMock, @unchecked Sendable {
    public typealias MocksType = any NutritionStoreProtocol
    public typealias Stubbing = __StubbingProxy_NutritionStoreProtocol
    public typealias Verification = __VerificationProxy_NutritionStoreProtocol

    // Original typealiases

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any NutritionStoreProtocol)?

    public func enableDefaultImplementation(_ stub: any NutritionStoreProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    public var dailyGoals: DailyGoals {
        get {
            return cuckoo_manager.getter(
                "dailyGoals",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.dailyGoals
            )
        }
        set {
            cuckoo_manager.setter(
                "dailyGoals",
                value: newValue,
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.dailyGoals = newValue
            )
        }
    }

    public var weeklyLogs: [DailyLog] {
        get {
            return cuckoo_manager.getter(
                "weeklyLogs",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.weeklyLogs
            )
        }
        set {
            cuckoo_manager.setter(
                "weeklyLogs",
                value: newValue,
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.weeklyLogs = newValue
            )
        }
    }


    public func loadData() {
        return cuckoo_manager.call(
            "loadData()",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.loadData()
        )
    }

    public func saveData() {
        return cuckoo_manager.call(
            "saveData()",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.saveData()
        )
    }

    public func initializeWeekIfNeeded() {
        return cuckoo_manager.call(
            "initializeWeekIfNeeded()",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.initializeWeekIfNeeded()
        )
    }

    public func updateNutrient(for p0: Date, type p1: NutrientType, value p2: Double) {
        return cuckoo_manager.call(
            "updateNutrient(for p0: Date, type p1: NutrientType, value p2: Double)",
            parameters: (p0, p1, p2),
            escapingParameters: (p0, p1, p2),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.updateNutrient(for: p0, type: p1, value: p2)
        )
    }

    public func getCurrentDayLog() -> DailyLog? {
        return cuckoo_manager.call(
            "getCurrentDayLog() -> DailyLog?",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.getCurrentDayLog()
        )
    }

    public func checkAndCreateNewDayIfNeeded() {
        return cuckoo_manager.call(
            "checkAndCreateNewDayIfNeeded()",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.checkAndCreateNewDayIfNeeded()
        )
    }

    public func handleAppBecameActive() {
        return cuckoo_manager.call(
            "handleAppBecameActive()",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.handleAppBecameActive()
        )
    }

    public struct __StubbingProxy_NutritionStoreProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var dailyGoals: Cuckoo.ProtocolToBeStubbedProperty<MockNutritionStoreProtocol,DailyGoals> {
            return .init(manager: cuckoo_manager, name: "dailyGoals")
        }
        
        var weeklyLogs: Cuckoo.ProtocolToBeStubbedProperty<MockNutritionStoreProtocol,[DailyLog]> {
            return .init(manager: cuckoo_manager, name: "weeklyLogs")
        }
        
        func loadData() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockNutritionStoreProtocol.self,
                method: "loadData()",
                parameterMatchers: matchers
            ))
        }
        
        func saveData() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockNutritionStoreProtocol.self,
                method: "saveData()",
                parameterMatchers: matchers
            ))
        }
        
        func initializeWeekIfNeeded() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockNutritionStoreProtocol.self,
                method: "initializeWeekIfNeeded()",
                parameterMatchers: matchers
            ))
        }
        
        func updateNutrient<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(for p0: M1, type p1: M2, value p2: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(Date, NutrientType, Double)> where M1.MatchedType == Date, M2.MatchedType == NutrientType, M3.MatchedType == Double {
            let matchers: [Cuckoo.ParameterMatcher<(Date, NutrientType, Double)>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }, wrap(matchable: p2) { $0.2 }]
            return .init(stub: cuckoo_manager.createStub(for: MockNutritionStoreProtocol.self,
                method: "updateNutrient(for p0: Date, type p1: NutrientType, value p2: Double)",
                parameterMatchers: matchers
            ))
        }
        
        func getCurrentDayLog() -> Cuckoo.ProtocolStubFunction<(), DailyLog?> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockNutritionStoreProtocol.self,
                method: "getCurrentDayLog() -> DailyLog?",
                parameterMatchers: matchers
            ))
        }
        
        func checkAndCreateNewDayIfNeeded() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockNutritionStoreProtocol.self,
                method: "checkAndCreateNewDayIfNeeded()",
                parameterMatchers: matchers
            ))
        }
        
        func handleAppBecameActive() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockNutritionStoreProtocol.self,
                method: "handleAppBecameActive()",
                parameterMatchers: matchers
            ))
        }
    }

    public struct __VerificationProxy_NutritionStoreProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        var dailyGoals: Cuckoo.VerifyProperty<DailyGoals> {
            return .init(manager: cuckoo_manager, name: "dailyGoals", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var weeklyLogs: Cuckoo.VerifyProperty<[DailyLog]> {
            return .init(manager: cuckoo_manager, name: "weeklyLogs", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        @discardableResult
        func loadData() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "loadData()",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func saveData() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "saveData()",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func initializeWeekIfNeeded() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "initializeWeekIfNeeded()",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func updateNutrient<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(for p0: M1, type p1: M2, value p2: M3) -> Cuckoo.__DoNotUse<(Date, NutrientType, Double), Void> where M1.MatchedType == Date, M2.MatchedType == NutrientType, M3.MatchedType == Double {
            let matchers: [Cuckoo.ParameterMatcher<(Date, NutrientType, Double)>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }, wrap(matchable: p2) { $0.2 }]
            return cuckoo_manager.verify(
                "updateNutrient(for p0: Date, type p1: NutrientType, value p2: Double)",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func getCurrentDayLog() -> Cuckoo.__DoNotUse<(), DailyLog?> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "getCurrentDayLog() -> DailyLog?",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func checkAndCreateNewDayIfNeeded() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "checkAndCreateNewDayIfNeeded()",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func handleAppBecameActive() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "handleAppBecameActive()",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

public class NutritionStoreProtocolStub:NutritionStoreProtocol, @unchecked Sendable {
    
    public var dailyGoals: DailyGoals {
        get {
            return DefaultValueRegistry.defaultValue(for: (DailyGoals).self)
        }
        set {}
    }
    
    public var weeklyLogs: [DailyLog] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([DailyLog]).self)
        }
        set {}
    }


    
    public func loadData() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func saveData() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func initializeWeekIfNeeded() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func updateNutrient(for p0: Date, type p1: NutrientType, value p2: Double) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func getCurrentDayLog() -> DailyLog? {
        return DefaultValueRegistry.defaultValue(for: (DailyLog?).self)
    }
    
    public func checkAndCreateNewDayIfNeeded() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func handleAppBecameActive() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
}




// MARK: - Mocks generated from file: 'Modules/Core/Sources/WidgetReloaderProtocol.swift'

import Cuckoo
import WidgetKit
@testable import NutritionCore

public class MockWidgetReloaderProtocol: WidgetReloaderProtocol, Cuckoo.ProtocolMock, @unchecked Sendable {
    public typealias MocksType = any WidgetReloaderProtocol
    public typealias Stubbing = __StubbingProxy_WidgetReloaderProtocol
    public typealias Verification = __VerificationProxy_WidgetReloaderProtocol

    // Original typealiases

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any WidgetReloaderProtocol)?

    public func enableDefaultImplementation(_ stub: any WidgetReloaderProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }


    public func reloadTimelines(ofKind p0: String) {
        return cuckoo_manager.call(
            "reloadTimelines(ofKind p0: String)",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.reloadTimelines(ofKind: p0)
        )
    }

    public struct __StubbingProxy_WidgetReloaderProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        func reloadTimelines<M1: Cuckoo.Matchable>(ofKind p0: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockWidgetReloaderProtocol.self,
                method: "reloadTimelines(ofKind p0: String)",
                parameterMatchers: matchers
            ))
        }
    }

    public struct __VerificationProxy_WidgetReloaderProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        
        @discardableResult
        func reloadTimelines<M1: Cuckoo.Matchable>(ofKind p0: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "reloadTimelines(ofKind p0: String)",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

public class WidgetReloaderProtocolStub:WidgetReloaderProtocol, @unchecked Sendable {


    
    public func reloadTimelines(ofKind p0: String) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
}


