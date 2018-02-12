import Foundation
import xcproj

extension PBXTargetDependency: ProjectLintable {
    
    public func lint(project: PBXProj, reference: String) -> [LintError] {
        var errors: [LintError] = []
        if let targetProxyError = lintTargetProxy(project: project, reference: reference) {
            errors.append(targetProxyError)
        }
        if let targetError = lintTarget(project: project, reference: reference) {
            errors.append(targetError)
        }
        return errors
    }
    
    fileprivate func lintTargetProxy(project: PBXProj, reference: String) -> LintError? {
        guard let targetProxy = self.targetProxy else { return nil }
        let exists = project.objects.containerItemProxies.contains(reference: targetProxy)
        if exists { return nil }
        return LintError.missingReference(objectType: String(describing: type(of: self)),
                                          objectReference: reference,
                                          missingReference: "PBXContainerItemProxy<\(targetProxy)>")
    }
    
    fileprivate func lintTarget(project: PBXProj, reference: String) -> LintError? {
        guard let target = self.target else { return nil }
        let nativeTargetExists = project.objects.nativeTargets.contains(reference: target)
        let aggregateTargetExists = project.objects.aggregateTargets.contains(reference: target)
        if nativeTargetExists || aggregateTargetExists { return nil }
        return LintError.missingReference(objectType: String(describing: type(of: self)),
                                          objectReference: reference,
                                          missingReference: "PBXNativeTarget/PBXAggregateTarget<\(target)>")
    }
    
}
