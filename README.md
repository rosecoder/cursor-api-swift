# Cursor API for Swift

A Swift implementation for interacting with the [Cursor API](https://docs.cursor.com/en/background-agent/api/overview), designed as a server-first solution. This package provides a high-level, type-safe way to interact with Cursor API while maintaining excellent performance.

The vision of this package is to provide a high-level, but still performant, way to interact with Cursor API from Swift. Feel free to contrinubte with either creating an issue or a pull request.

## Features

- List agents, models and repositories
- Get agent conversation
- Launch agents and add follow-ups
- Delete agents
- Get API key info

## Usage

### Manage agents

```swift
try await withCursorAPI(authorization: .apiKey("<#your api key#>")) { api in

    // Get list of agents
    let agents = try await api.getAgents()

    // Get a specific agent
    let agent = try await api.getAgent(id: "<#agent id#>")

    // Delete an agent
    try await api.deleteAgent(id: "<#agent id#>")

    // Create an agent
    let agent = try await api.createAgent(
        prompt: "<#prompt#>",
        source: .init(
            repository: "<#repository#>",
            ref: "<#ref#>"
        )
    )
}
```

## License

MIT License. See [LICENSE](./LICENSE) for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
