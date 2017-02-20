# Guide

These are guidelines on how to develop the project.

## Errors

Prevent everything.

If one operation may raise an error, handle it isolated.

If one operation may raise more than one possibility of error, split it into separate operations.

Example:

**BAD**

```
func presentShareDialog() {
    guard let instagramURL = URL(string: "instagram://app"),
        UIApplication.shared.canOpenURL(instagramURL) else {
            // Handle error on UI
            // e.g. "Please install Instagram."
            return
    }
}
```

**Bad because** maybe the user has Instagram installed but the error is a typo in the URL, so the UI feedback is misleading.

**GOOD**

```
func presentShareDialog() {
    guard let instagramURL = URL(string: "instagram://app") else {
        // Handle error on UI
        // e.g. "We are sorry, something unexpected happened."
        // Track with error tracking e.g. New Relic, Sentry etc.
        return
    }
    guard UIApplication.shared.canOpenURL(instagramURL) else {
        // Handle error on UI
        // e.g. "To do this, you need to install Instagram."
        return
    }
    // Continue...
}
```

**Good because** if there is a typo in the URL, the error is handled with correct UI feedback and tracked with some integrated service so the team can be notified to fix it.
