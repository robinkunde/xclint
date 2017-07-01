import Foundation
import Commander

/// Command that prints all the available rules.
public let RulesCommand = command { () in
    print("These are all the rules available:\n")
    print(allRules
        .map { $0.name }
        .map { "  - \($0)" }
        .joined(separator: "\n"))
}
