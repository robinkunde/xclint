import Foundation
import xcodeproj

/// Lint configuration.
struct LintConfig {

    // MARK: - Attributes
    
    /// Linting rules.
    let rules: [LintRule]
    
    /// Linting rules that are excluded.
    let excludedRules: [LintRule]
    
    /// Project to be linted.
    let project: XcodeProj
    
    // MARK: - Init
    
    /// Default LintConfig constructor.
    ///
    /// - Parameters:
    ///   - project: project to be linted.
    ///   - rules: linting rules.
    ///   - excludedRules: excluded linting rules.
    init(project: XcodeProj,
         rules: [LintRule] = allRules,
         excludedRules: [LintRule] = []) {
        self.project = project
        self.rules = rules
        self.excludedRules = excludedRules
    }
    
}