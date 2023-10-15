// The Swift Programming Language
// https://docs.swift.org/swift-book

@_exported import Dependencies

@freestanding(declaration)
public macro DependencyExtension<T>(body: () -> T) = #externalMacro(module: "DependencyExtensionMacros", type: "DependencyExtensionMacro")
