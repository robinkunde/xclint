import Foundation
import xcproj

extension PBXProject: ProjectLintable {
    
    public func lint(project: PBXProj, reference: String) -> [LintError] {
        var errors: [LintError] = []
        if let buildConfigurationError = lintBuildConfigurationList(project: project, reference: reference) {
            errors.append(buildConfigurationError)
        }
        if let mainGroupError = lintMainGroup(project: project, reference: reference) {
            errors.append(mainGroupError)
        }
        if let productRefGroupError = lintProductRefGroup(project: project, reference: reference) {
            errors.append(productRefGroupError)
        }
        errors.append(contentsOf: lintTargets(project: project, reference: reference))
        return errors
    }
    
    fileprivate func lintBuildConfigurationList(project: PBXProj, reference: String) -> LintError? {
        let exists = project.objects.configurationLists.contains(reference: buildConfigurationList)
        if exists { return nil }
        return LintError.missingReference(objectType: String(describing: type(of: self)),
                                          objectReference: reference,
                                          missingReference: "XCConfigurationList<\(buildConfigurationList)>")
    }
    
    fileprivate func lintMainGroup(project: PBXProj, reference: String) -> LintError? {
        let exists = project.objects.groups.contains(reference: mainGroup)
        if exists { return nil }
        return LintError.missingReference(objectType: String(describing: type(of: self)),
                                          objectReference: reference,
                                          missingReference: "PBXGroup<\(mainGroup)>")
    }
    
    fileprivate func lintProductRefGroup(project: PBXProj, reference: String) -> LintError? {
        guard let productRefGroup = self.productRefGroup else { return nil }
        let exists = project.objects.groups.contains(reference: productRefGroup)
        if exists { return nil }
        return LintError.missingReference(objectType: String(describing: type(of: self)),
                                          objectReference: reference,
                                          missingReference: "PBXGroup<\(productRefGroup)>")
    }
    
    fileprivate func lintTargets(project: PBXProj, reference: String) -> [LintError] {
        return targets
            .flatMap { targetReference in
                let nativeTargetExists = project.objects.nativeTargets.contains(reference: targetReference)
                let aggregateTargetExists = project.objects.aggregateTargets.contains(reference: targetReference)
                if nativeTargetExists || aggregateTargetExists { return nil }
                return LintError.missingReference(objectType: String(describing: type(of: self)),
                                                  objectReference: reference,
                                                  missingReference: "PBXNativeTarget/PBXAggregateTarget<\(targetReference)>")
            }
    }
    
}


// targets

