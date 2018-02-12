import Foundation
import xcproj

extension PBXTarget: ProjectLintable {
    
    // MARK: - Public
    
    public func lint(project: PBXProj, reference: String) -> [LintError] {
        var errors: [LintError] = []
        if let buildConfigurationListError = lintConfigurationList(project: project, reference: reference) {
            errors.append(buildConfigurationListError)
        }
        errors.append(contentsOf: lintBuildPhases(project: project, reference: reference))
        errors.append(contentsOf: lintDependencies(project: project, reference: reference))
        if let productReferenceError = lintProductReference(project: project, reference: reference) {
            errors.append(productReferenceError)
        }
        return errors
    }
    
    // MARK: - Fileprivate
    
    fileprivate func lintConfigurationList(project: PBXProj, reference: String) -> LintError? {
        if let buildConfigurationList = buildConfigurationList {
            let exists = project.objects.configurationLists.contains(reference: buildConfigurationList)
            if exists { return nil }
            return LintError.missingReference(objectType: String(describing: type(of: self)),
                                              objectReference: reference,
                                              missingReference: "XCConfigurationList<\(buildConfigurationList)>")
            
        } else {
            return LintError.missingAttribute(objectType: String(describing: type(of: self)),
                                              objectReference: reference,
                                              missingAttribute: "buildConfigurationList")
        }
    }
    
    fileprivate func lintBuildPhases(project: PBXProj, reference: String) -> [LintError] {
        var errors: [LintError] = []
        buildPhases.forEach { (buildPhaseReference) in
            let exists = project.objects.buildPhases.contains(reference: buildPhaseReference)
            if exists { return }
            errors.append(LintError.missingReference(objectType: String(describing: type(of: self)),
                                                     objectReference: reference,
                                                     missingReference: "PBXBuildPhase<\(buildPhaseReference)>"))
        }
        return errors
    }
    
    fileprivate func lintDependencies(project: PBXProj, reference: String) -> [LintError] {
        var errors: [LintError] = []
        dependencies.forEach { (dependencyReference) in
            let exists = project.objects.targetDependencies.contains(reference: dependencyReference)
            if exists { return }
            errors.append(LintError.missingReference(objectType: String(describing: type(of: self)),
                                                     objectReference: reference,
                                                     missingReference: "PBXTargetDependency<\(dependencyReference)>"))
        }
        return errors
    }
    
    fileprivate func lintProductReference(project: PBXProj, reference: String) -> LintError? {
        guard let productReference = self.productReference else { return nil }
        let exists = project.objects.fileReferences.contains(reference: productReference)
        if exists { return nil }
        return LintError.missingReference(objectType: String(describing: type(of: self)),
                                          objectReference: reference,
                                          missingReference: "PBXFileReference<\(productReference)>")
    }
    
}
