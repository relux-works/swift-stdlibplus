import Foundation
import Network
import Combine

public typealias NetworkStatus = (connected: Bool, expensive: Bool, wasChanged: Bool)

public protocol INetworkService {
    var status: NetworkStatus { get }
    func start()
    var networkPub: AnyPublisher<NetworkStatus, Never> { get }
}

public class NetworkService: INetworkService {
    private let monitor = NWPathMonitor()

    private let queue = DispatchQueue(label: "NetworkMonitor", qos: .userInitiated)
    private(set) public var status: NetworkStatus = (connected: false, expensive: false, wasChanged: false)
    private let networkSub = PassthroughSubject<NetworkStatus, Never>()
    public var networkPub: AnyPublisher<NetworkStatus, Never> { networkSub.eraseToAnyPublisher() }

    public init () {
    }

    public func start() {
        startWatchNetworkCondition()
    }

    private func startWatchNetworkCondition() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let strongSelf = self else {
                return
            }

            let prevStatus = strongSelf.status
            let nextStatus = strongSelf.buildStatus(path: path, prevStatus: prevStatus)

            strongSelf.status = nextStatus

            self?.networkSub.send(nextStatus)
        }

        monitor.start(queue: queue)
    }

    private func buildStatus(path: NWPath, prevStatus: NetworkStatus) -> NetworkStatus {
        let isExpensive = path.isExpensive
        let isConnected = path.status == .satisfied
        let wasChanged = prevStatus.connected != isConnected

        return (
                connected: isConnected,
                expensive: isExpensive,
                wasChanged: wasChanged
        )
    }
}
