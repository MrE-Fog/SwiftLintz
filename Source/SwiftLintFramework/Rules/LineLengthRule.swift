//
//  LineLengthRule.swift
//  SwiftLint
//
//  Created by JP Simard on 2015-05-16.
//  Copyright (c) 2015 Realm. All rights reserved.
//

import SourceKittenFramework

public struct LineLengthRule: ParameterizedRule {
    public init() {}

    public let identifier = "line_length"

    public let parameters = [
        RuleParameter(severity: .Warning, value: 110),
    ]

    public func validateFile(var file: File) -> [StyleViolation] {
        return file.lines.flatMap { line in
            for parameter in self.parameters.reverse() {
                if line.content.characters.count > parameter.value {
                    return StyleViolation(type: .Length,
                        location: Location(file: file.path, line: line.index),
                        severity: parameter.severity,
                        reason: "Line should be 110 characters or less: currently " +
                        "\(line.content.characters.count) characters")
                }
            }
            return nil
        }
    }

    public let example = RuleExample(
        ruleName: "Line Length Rule",
        ruleDescription: "Lines should be less than 110 characters.",
        nonTriggeringExamples: [],
        triggeringExamples: [],
        showExamples: false
    )
}
