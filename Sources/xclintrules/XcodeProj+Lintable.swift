import xcproj

extension XcodeProj: Lintable {
    
    // MARK: - Public
    
    public func lint() -> [LintError] {
        var errors: [LintError] = []

        errors.append(contentsOf: pbxproj.objects.buildFiles.flatMap({ $1.lint(project: pbxproj, reference: $0) }))
        errors.append(contentsOf: pbxproj.objects.aggregateTargets.flatMap({ $1.lint(project: pbxproj, reference: $0) }))
        errors.append(contentsOf: pbxproj.objects.nativeTargets.flatMap({ $1.lint(project: pbxproj, reference: $0) }))
        errors.append(contentsOf: pbxproj.objects.containerItemProxies.flatMap({ $1.lint(project: pbxproj, reference: $0) }))
        errors.append(contentsOf: pbxproj.objects.groups.flatMap({ $1.lint(project: pbxproj, reference: $0) }))
        errors.append(contentsOf: pbxproj.objects.configurationLists.flatMap({ $1.lint(project: pbxproj, reference: $0) }))
        errors.append(contentsOf: pbxproj.objects.variantGroups.flatMap({ $1.lint(project: pbxproj, reference: $0) }))
        errors.append(contentsOf: pbxproj.objects.targetDependencies.flatMap({ $1.lint(project: pbxproj, reference: $0) }))
        errors.append(contentsOf: pbxproj.objects.projects.flatMap({ $1.lint(project: pbxproj, reference: $0) }))
        return errors
    }
}
