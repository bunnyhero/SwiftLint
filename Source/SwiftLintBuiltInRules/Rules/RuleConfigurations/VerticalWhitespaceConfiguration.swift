import SwiftLintCore

struct VerticalWhitespaceConfiguration: SeverityBasedRuleConfiguration, Equatable {
    typealias Parent = VerticalWhitespaceRule

    @ConfigurationElement(key: "severity")
    private(set) var severityConfiguration = SeverityConfiguration<Parent>(.warning)
    @ConfigurationElement(key: "max_empty_lines")
    private(set) var maxEmptyLines = 1

    mutating func apply(configuration: Any) throws {
        guard let configuration = configuration as? [String: Any] else {
            throw Issue.unknownConfiguration(ruleID: Parent.identifier)
        }

        if let maxEmptyLines = configuration[$maxEmptyLines] as? Int {
            self.maxEmptyLines = maxEmptyLines
        }

        if let severityString = configuration[$severityConfiguration] as? String {
            try severityConfiguration.apply(configuration: severityString)
        }
    }
}
