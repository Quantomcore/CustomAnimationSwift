//: A UIKit based Playground for presenting user interface
  
//
//  CustomTransitionDemo.swift
//
//  Created by Sidhant Agnihotri on 14/07/26.
//

import SwiftUI
import PlaygroundSupport

//1.  build a standard modifier that uses parameters to skew, rotate, or reposition a view. SwiftUI will automatically animate these numerical properties over time.
struct GeometricRotationModifier: ViewModifier {
    let rotationAngle: Double
    let scale: CGFloat
    let yOffset: CGFloat

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .rotationEffect(.degrees(rotationAngle))
            .offset(y: yOffset)
            // Optional: Keeps the fading effect smooth during structural changes
            .opacity(scale == 0 ? 0 : 1)
    }
}

// iOS 17+ Modern Layout Alternative
struct SlideAndScaleTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            // phase.isIdentity tells us if the view is on screen or moving away
            .scaleEffect(phase.isIdentity ? 1.0 : 0.0)
            .rotation3DEffect(
                .degrees(phase.isIdentity ? 0 : 45),
                axis: (x: 1, y: 0, z: 0)
            )
    }
}
extension Transition where Self == SlideAndScaleTransition{
    static var slideAndScale: SlideAndScaleTransition {
        SlideAndScaleTransition()
    }
}


// Usage in iOS 17+:
// .transition(SlideAndScaleTransition())



extension AnyTransition {
    static var pivotAndDrop: AnyTransition {
        .modifier(
            // How it looks when completely hidden (Active)
            active: GeometricRotationModifier(rotationAngle: -90, scale: 0.1, yOffset:300),
            // How it looks when fully visible (Identity)
            identity: GeometricRotationModifier(rotationAngle: 0, scale: 1.0, yOffset: 0)
        )
    }
}

struct CustomTransitionDemo: View {
    @State private var isCardShowing = false

    var body: some View {
        Spacer()
        VStack(spacing: 30) {
           

            if isCardShowing {
                // Your custom view layout
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 250, height: 500)
                    .overlay(
                        Text("Custom Pivot")
                            .font(.title).bold().foregroundColor(.white)
                    )
                    // 👈 Apply your custom transition here
                    .transition(.pivotAndDrop)
                  // .transition(.slideAndScale)
                
            }
            
            Button("Animate Card") {
                withAnimation(.interpolatingSpring(stiffness: 70, damping: 10)) {
                    isCardShowing.toggle()
                }
            }.padding(.bottom)
        }
    }
}



PlaygroundPage.current.setLiveView(CustomTransitionDemo().frame(width: 300, height: 600))


