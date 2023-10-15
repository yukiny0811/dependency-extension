
# DependencyExtension

Macro for convenient use of https://github.com/pointfreeco/swift-dependencies

```.swift
import DependencyExtension

public struct Something {}

#DependencyExtension {
    Something()
}
```

expands in to this

```.swift
public extension Something: DependencyKey {
    public static let liveValue: Something = .init()
}

public extension DependencyValues {
    public var Something: Something {
        get { self[Something.self] }
        set { self[Something.self] = newValue }
    }
}
```
