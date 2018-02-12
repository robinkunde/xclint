import Foundation
import xcproj

extension PBXContainerItemProxy: ProjectLintable {
    
    // MARK: - Public
    
    public func lint(project: PBXProj, reference: String) -> [LintError] {
        var errors: [LintError] = []
        if let remoteGlobalIDStringError = lintRemoteGlobalIDString(project: project, reference: reference) {
            errors.append(remoteGlobalIDStringError)
        }
        if let containerPortalError = lintContainerPortal(project: project, reference: reference) {
            errors.append(containerPortalError)
        }
        return errors
    }
    
    // MARK: - Fileprivate
    
    fileprivate func lintRemoteGlobalIDString(project: PBXProj, reference: String) -> LintError? {
        guard let remoteGlobalIDString = self.remoteGlobalIDString else { return nil }
        let exists = project.objects.nativeTargets.contains(reference: remoteGlobalIDString)
        if exists { return nil }
        return LintError.missingReference(objectType: String(describing: type(of: self)),
                                          objectReference: reference,
                                          missingReference: "PBXFileReference<\(remoteGlobalIDString)>")
    }
    
    fileprivate func lintContainerPortal(project: PBXProj, reference: String) -> LintError? {
        let exists = project.objects.projects.contains(reference: containerPortal)
        if exists { return nil }
        return LintError.missingReference(objectType: String(describing: type(of: self)),
                                          objectReference: reference,
                                          missingReference: "PBXProject<\(containerPortal)>")
    }
    
}

