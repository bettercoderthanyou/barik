import Foundation

enum BarikCLI {
    static func handleIfNeeded() {
        var arguments = CommandLine.arguments.dropFirst()
        guard !arguments.isEmpty else { return }

        var focusedSpaceId: String?
        var focusedWindowId: String?

        while let arg = arguments.first {
            arguments = arguments.dropFirst()
            switch arg {
            case "--reload-spaces":
                sendReloadSpacesSignal(
                    focusedSpaceId: focusedSpaceId,
                    focusedWindowId: focusedWindowId)
                exit(EXIT_SUCCESS)
            case "--focused-space":
                if let value = arguments.first {
                    focusedSpaceId = value
                    arguments = arguments.dropFirst()
                }
            case "--focused-window":
                if let value = arguments.first {
                    focusedWindowId = value
                    arguments = arguments.dropFirst()
                }
            default:
                break
            }
        }
    }

    private static func sendReloadSpacesSignal(
        focusedSpaceId: String?, focusedWindowId: String?
    ) {
        var info: [String: String] = [:]
        if let focusedSpaceId { info["focusedSpaceId"] = focusedSpaceId }
        if let focusedWindowId { info["focusedWindowId"] = focusedWindowId }
        DistributedNotificationCenter.default().postNotificationName(
            .barikReloadSpaces,
            object: nil,
            userInfo: info.isEmpty ? nil : info,
            deliverImmediately: true)
    }
}
