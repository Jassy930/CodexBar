import AppKit

extension StatusItemController {
    func prepareForAppShutdown() {
        guard !self.hasPreparedForAppShutdown else { return }
        self.hasPreparedForAppShutdown = true
        #if DEBUG
        self.isReleasedForTesting = true
        #endif

        self.cancelShutdownTasks()
        self.removeShutdownStatusItems()
        self.creditsPurchaseWindow?.close()
        self.creditsPurchaseWindow = nil
    }

    private func cancelShutdownTasks() {
        self.blinkTask?.cancel()
        self.blinkTask = nil
        self.loginTask?.cancel()
        self.loginTask = nil
        self.screenChangeVisibilityTask?.cancel()
        self.screenChangeVisibilityTask = nil
        self.pendingScreenChangePreviousCount = nil
        self.animationDriver?.stop()
        self.animationDriver = nil
        self.animationPhase = 0
        self.blinkForceUntil = nil
        self.blinkStates.removeAll(keepingCapacity: false)
        self.blinkAmounts.removeAll(keepingCapacity: false)
        self.wiggleAmounts.removeAll(keepingCapacity: false)
        self.tiltAmounts.removeAll(keepingCapacity: false)
        self.quotaWarningFlashUntil.removeAll(keepingCapacity: false)
        for task in self.quotaWarningFlashTasks.values {
            task.cancel()
        }
        self.quotaWarningFlashTasks.removeAll(keepingCapacity: false)
        self.providerSelectionUIRefreshTask?.cancel()
        self.providerSelectionUIRefreshTask = nil
    }

    private func removeShutdownStatusItems() {
        self.statusItem.menu = nil
        self.statusBar.removeStatusItem(self.statusItem)

        for item in self.statusItems.values {
            item.menu = nil
            self.statusBar.removeStatusItem(item)
        }
        self.statusItems.removeAll(keepingCapacity: false)
        self.lastAppliedProviderIconRenderSignatures.removeAll(keepingCapacity: false)
    }

    #if DEBUG
    func releaseStatusItemsForTesting() {
        self.prepareForAppShutdown()
    }
    #endif
}
