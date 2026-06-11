import CodexBarCore

extension StatusItemController {
    func tokenSnapshotForCostHistorySubmenu(provider: UsageProvider) -> CostUsageTokenSnapshot? {
        let projected = self.store.tokenSnapshot(
            fromProviderSnapshot: self.store.snapshot(for: provider),
            provider: provider)
        if UsageStore.tokenCostRequiresProviderSnapshot(provider) {
            return projected
        }
        return projected ?? self.store.tokenSnapshot(for: provider)
    }

    static var costMenuTitle: String {
        L("Cost")
    }

    static func costMenuVisibleDetailLines(tokenUsage: UsageMenuCardView.Model.TokenUsageSection?) -> [String] {
        let primaryLines = [
            tokenUsage?.sessionLine,
            tokenUsage?.monthLine,
            tokenUsage?.errorLine,
        ]
            .compactMap(\.self)
            .filter { !$0.isEmpty }
        guard primaryLines.isEmpty else { return primaryLines }
        return [tokenUsage?.hintLine]
            .compactMap(\.self)
            .filter { !$0.isEmpty }
    }
}
