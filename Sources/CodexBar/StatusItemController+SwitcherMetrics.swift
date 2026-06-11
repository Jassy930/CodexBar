import CodexBarCore

extension StatusItemController {
    func switcherWeeklyRemaining(for provider: UsageProvider) -> Double? {
        Self.switcherWeeklyMetricPercent(
            for: provider,
            snapshot: self.store.snapshot(for: provider),
            showUsed: self.settings.usageBarsShowUsed)
    }

    nonisolated static func switcherWeeklyMetricPercent(
        for provider: UsageProvider,
        snapshot: UsageSnapshot?,
        showUsed: Bool) -> Double?
    {
        let window = snapshot?.switcherWeeklyWindow(for: provider, showUsed: showUsed)
        guard let window else { return nil }
        return showUsed ? window.usedPercent : window.remainingPercent
    }
}
