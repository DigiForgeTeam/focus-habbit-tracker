import Foundation

class Session {
    var serviceA: ServiceA?

    deinit {
        print("Session удалён из памяти")
    }
}

class ServiceA {
    var session: Session?
    deinit {
        print("ServiceA удалён из памяти")
    }
}

var session: Session? = Session()
var serviceA: ServiceA? = ServiceA()
session?.serviceA = serviceA
serviceA?.session = session

// Позже:
session = nil
serviceA = nil
