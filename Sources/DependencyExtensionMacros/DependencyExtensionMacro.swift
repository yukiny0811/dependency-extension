import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct DependencyExtensionMacro: DeclarationMacro {
    public static func expansion(of node: some SwiftSyntax.FreestandingMacroExpansionSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        guard let str = node
            .trailingClosure?
            .statements
            .first?
            .item
            .as(FunctionCallExprSyntax.self)?
            .as(DeclReferenceExprSyntax.self)?
            .description else {
            return []
        }
        
        let resultString = 
"""
extension \(str): DependencyKey {
    static let liveValue: \(str) = .init()
}

extension DependencyValues {
    var \(str)V: \(str) {
        get { self[\(str).self] }
        set { self[\(str).self] = newValue }
    }
}
"""
        return [DeclSyntax(stringLiteral: resultString)]
    }
}

@main
struct DependencyExtensionPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DependencyExtensionMacro.self,
    ]
}
