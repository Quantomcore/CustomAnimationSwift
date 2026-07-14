# CustomAnimationSwift

**Summary of Custom Transitions**
* Protocol Choice: Use the modern Transition protocol for iOS 17+ or the ViewModifier protocol for legacy apps.
* Core Concept: Define the active state (hidden or entering layout attributes) versus the identity state (on-screen properties).
* Properties Animated: Manipulate scaleEffect(), rotationEffect(), rotation3DEffect(), offset(), or blur() to morph the view.
* Compiler Rules: Extend Transition where Self == YourType or AnyTransition to enable clean dot-notation access.
* Trigger Requirement: Toggle states inside a withAnimation block, or attach a default animation directly to the transition configuration.

