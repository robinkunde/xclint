import Foundation
import xcproj

extension XCConfigurationList: ProjectLintable {
    
    // MARK: - Public
    
    public func lint(project: PBXProj, reference: String) -> [LintError] {
        var errors: [LintError] = []
        errors.append(contentsOf: lintBuildConfigurations(project: project, reference: reference))
        return errors
    }
    
    // MARK: - Fileprivate
    
    fileprivate func lintBuildConfigurations(project: PBXProj, reference: String) -> [LintError] {
       return buildConfigurations
        .flatMap { (buildConfigurationReference) -> LintError? in
            let exists = project.objects.buildConfigurations.contains(reference: buildConfigurationReference)
            if exists { return nil }
            return LintError.missingReference(objectType: String(describing: type(of: self)),
                                              objectReference: reference,
                                              missingReference: "XCBuildConfiguration<\(buildConfigurationReference)>")
            
        }
    }
    
}
