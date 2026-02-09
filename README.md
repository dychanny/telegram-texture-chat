# telegram-texture-chat

Telegram-like real-time chat UI foundation using **Texture (AsyncDisplayKit)**.

## Included

- Chat list (ASTableNode)
- Composer/input bar (growing text + send button)
- Message models + delivery status
- Theme tokens (light/dark-ready structure)
- ViewModel + socket service protocol + in-memory store

## Stack

- Swift 5.9+
- iOS 15+
- Texture (AsyncDisplayKit)

## Install Texture

### Option A: Swift Package Manager

Add package:

- URL: `https://github.com/TextureGroup/Texture.git`
- Product: `Texture`

### Option B: CocoaPods

```ruby
platform :ios, '15.0'
use_frameworks!

target 'YourAppTarget' do
  pod 'Texture'
end
```

## Suggested integration

1. Create iOS app target in Xcode.
2. Add these source folders into your app target.
3. Set initial root VC to `ChatViewController`.
4. Wire your websocket transport in `ChatSocketService` implementation.

## Notes

This project intentionally provides a clean **foundation** (not a full Telegram clone).
Bring your own assets/branding and backend contract.
