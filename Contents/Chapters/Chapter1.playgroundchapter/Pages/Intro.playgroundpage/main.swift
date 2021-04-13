//#-hidden-code


import SwiftUI
import UIKit
import PlaygroundSupport

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct BackgroundView: View {
    private var img: UIImage
    private var image: Image
    var hex: UInt
    init(hex: UInt) {
        self.img = UIImage(named: "lotusreal.png")!
        self.image = Image(uiImage: img)
        self.hex = hex
    }
    var body: some View {
        ZStack {
            Color(hex: hex)
                .edgesIgnoringSafeArea(.all)
            image
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.white)
                .frame(width: 200, height: 200)
                .padding(.bottom, 700)
            Image(uiImage: #imageLiteral(resourceName: "title.png"))
                .resizable()
                .frame(width: 600, height: 140)
        }
    }
}

struct ContentView: View {
    var body: some View {
        BackgroundView(hex: 0x3E54D3)
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(ContentView())


//#-end-hidden-code

/*:
 
 # Anxiety
 
 ## A silent enemy that can hurt a lot
 
 Anxiety is present in most homes nowadays, and it's no surprise that this affected me a lot during my life as well.
 
 Everyone that suffered and suffers from this disorder knows the pain that it can causes to you. But during the hard parts of it, I found some tricks to help fight it.
 
 In the next pages I will share with you these tricks, and explain how to apply them. Almost all of them are used for meditation purposes, but can be helpful in other moments.
 
 ## If you want more information, you can go to the Headspace app
 
 [Next Page](@next)
 
 */
