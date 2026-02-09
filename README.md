# telegram-texture-chat

Telegram-like real-time chat UI foundation using **Texture (AsyncDisplayKit)**.

## ✅ What’s included

- Chat list screen (`ASTableNode`) with Telegram-style rows (avatar/title/preview/time/unread)
- Chat detail screen + composer/input bar
- Message/user models + delivery states
- Theme tokens
- ViewModel + realtime service protocol + in-memory store
- iOS app scaffold (`TelegramTextureChatApp`) with mock socket
- Xcode project generator spec (`project.yml`)

## Texture dependency (custom SPM)

This repo uses your custom package:

- `https://github.com/dychanny/texture-SPM`

## Generate `.xcodeproj`

Use **XcodeGen** on your Mac:

```bash
brew install xcodegen
cd telegram-texture-chat
xcodegen generate
open TelegramTextureChat.xcodeproj
```

Then run scheme: `TelegramTextureChat`.

## Swift Package usage (optional)

`Package.swift` also points to your custom Texture package, so you can import this as a package if needed.
