import xcproj

extension XcodeProj: Lintable {
    
    // MARK: - Public
    
    public func lint() -> [LintError] {
        var errors: [LintError] = []
        errors.append(contentsOf: pbxproj.objects.buildFiles.values.flatMap({ $0.lint(project: pbxproj) }))
        errors.append(contentsOf: pbxproj.objects.aggregateTargets.values.flatMap({ $0.lint(project: pbxproj) }))
        errors.append(contentsOf: pbxproj.objects.nativeTargets.values.flatMap({ $0.lint(project: pbxproj) }))
        errors.append(contentsOf: pbxproj.objects.containerItemProxies.values.flatMap({ $0.lint(project: pbxproj) }))
        errors.append(contentsOf: pbxproj.objects.groups.values.flatMap({ $0.lint(project: pbxproj) }))
        errors.append(contentsOf: pbxproj.objects.configurationLists.values.flatMap({ $0.lint(project: pbxproj) }))
        errors.append(contentsOf: pbxproj.objects.variantGroups.values.flatMap({ $0.lint(project: pbxproj) }))
        errors.append(contentsOf: pbxproj.objects.targetDependencies.values.flatMap({ $0.lint(project: pbxproj) }))
        errors.append(contentsOf: pbxproj.objects.projects.values.flatMap({ $0.lint(project: pbxproj) }))
        return errors
    }
}
