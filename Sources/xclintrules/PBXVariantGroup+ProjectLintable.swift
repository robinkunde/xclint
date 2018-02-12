import Foundation
import xcproj

extension PBXVariantGroup: ProjectLintable {
    
    // MARK: - Public
    
    public func lint(project: PBXProj, reference: String) -> [LintError] {
        var errors: [LintError] = []
        errors.append(contentsOf: lintChildren(project: project, reference: reference))
        return errors
    }
    
    // MARK: - Fileprivate
    
    fileprivate func lintChildren(project: PBXProj, reference: String) -> [LintError] {
        return children
            .flatMap { (childReference) -> LintError? in
                let groupExists = project.objects.groups.contains(reference: childReference)
                let variantGroupExists = project.objects.variantGroups.contains(reference: childReference)
                let fileReferenceExists = project.objects.fileReferences.contains(reference: childReference)
                if groupExists || variantGroupExists || fileReferenceExists { return nil }
                return LintError.missingReference(objectType: String(describing: type(of: self)),
                                                  objectReference: reference,
                                                  missingReference: "PBXFileReference/PBXGroup/PBXVariantGroup<\(childReference)>")
        }
    }
    
}

