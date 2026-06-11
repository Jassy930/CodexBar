import AppKit

enum StatusItemMenuProviderNavigationDirection: Equatable {
    case previous
    case next
}

protocol StatusItemMenuPersistentActionDelegate: AnyObject {
    func performPersistentRefreshAction()
    func performPersistentSettingsAction()
    func performPersistentQuitAction()
    func performProviderNavigation(_ direction: StatusItemMenuProviderNavigationDirection)
}
