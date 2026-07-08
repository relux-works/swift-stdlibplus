# swift-stdlibplus

SwiftPlus: a small standard-library companion used across Relux Works projects.
Async utilities (`AsyncLock`, actor reentrancy management), higher-order functions
for `AsyncSequence` and collections, converters, optional-friendly string
interpolation, and other extensions that keep app code short.

## Installation (Swift Package Manager)

```swift
.package(url: "https://github.com/relux-works/swift-stdlibplus.git", from: "1.0.0")
```

```swift
.product(name: "SwiftPlus", package: "swift-stdlibplus")
```

## Usage

```swift
import SwiftPlus
```

Import and use the extensions directly; the package has no configuration and no
third-party dependencies.

<!-- relux-ecosystem:start -->

## About Relux Works

This project is part of the open-source ecosystem of
[Relux Works](https://relux.works), an AI-native software development studio.
We build fixed-price MVPs, rescue vibe-coded apps, run local AI inference, and
train teams to work with coding agents. Much of the infrastructure behind that
work is open source.

- Full catalog: [relux.works/en/open-source](https://relux.works/en/open-source/)
- Agentic enablement: [agent harnesses & team training](https://relux.works/en/agentic-enablement/)
- Hire us the agent-native way: point your assistant at `https://api.relux.works/mcp`
- Contact: ivan@relux.works

<!-- relux-ecosystem:end -->

## License

See [LICENSE](LICENSE).
