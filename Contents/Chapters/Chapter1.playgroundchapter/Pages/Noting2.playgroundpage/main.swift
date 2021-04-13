//#-hidden-code

import SwiftUI
import UIKit
import PlaygroundSupport

var count = 0

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
            VStack {
                image
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 700)
                
                Text("Tap on the thoughts to note them and give your mind some space")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .light))
                    .lineSpacing(10)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 150)
            }
        }
    }
}

struct ProgressBar: View {
    @State var value: CGFloat = 0.0
    private var percentage: CGFloat = 0.0
    
    init(value: CGFloat) {
        self.value = value
        self.percentage = value/8
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    
                    Rectangle()
                        .frame(width: CGFloat(geometry.size.width*percentage), height: geometry.size.height)
                        .foregroundColor(Color(hex: 0x15CDCA))
                        .animation(.linear)

                }.cornerRadius(45.0)
                Text("Current mind space: \(Int(self.percentage*100))%")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .light))
                    .lineSpacing(10)
            }
        }
    }
}


struct Thought: View {
    @State private var opacity: Double = 1
    var x: CGFloat
    var y: CGFloat
    var completion: () -> Void
    
    var body: some View {
        ZStack {
            Image(systemName: "cloud.fill")
                .resizable()
                .frame(width:150, height: 100)
                .foregroundColor(Color(hex: 0x15CDCA))
                
            Text("Thought")
                .foregroundColor(.white)
                .font(.system(size: 25, weight: .light))

        }
        .opacity(opacity)
        .offset(x: x, y: y)
        .frame(height: 120)
        .onTapGesture {
            withAnimation(Animation.linear(duration: 0.5)) {
                self.opacity = 0
                self.completion()
            }
        }
    }
}

struct ThoughtsView: View {
    @State private var count: Int = 0
    @State private var showCongratulations: Bool = false
    
    var coord: [CGPoint] = [CGPoint(x: CGFloat(150), y: CGFloat(150)), CGPoint(x: CGFloat(150), y: CGFloat(0)), CGPoint(x: CGFloat(-250), y: CGFloat(100)), CGPoint(x: CGFloat(-220), y: CGFloat(-100)), CGPoint(x: CGFloat(-50), y: CGFloat(20)), CGPoint(x: CGFloat(0), y: CGFloat(-150)), CGPoint(x: CGFloat(250), y: CGFloat(-120)), CGPoint(x: CGFloat(350), y: CGFloat(50))]
    
    var body: some View {
        ZStack {
            BackgroundView(hex: 0x3E54D3)
            VStack {
                ProgressBar(value: CGFloat(self.count))
                    .frame(height: 20)
                Spacer()
                ZStack {
                    ForEach(coord.indices, id: \.self) { i in
                        Thought(x: coord[i].x, y: coord[i].y ) {
                            self.count += 1
                            if self.count == 8 {
                                withAnimation(Animation.linear(duration: 2)) {
                                    self.showCongratulations = true
                                }
                            }
                        }
                    }
                    if showCongratulations {
                        Text("Congratulations! You noted your thoughts successfully")
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .light))
                            .lineSpacing(10)
                    }
                }
                Spacer()
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        ThoughtsView()
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(ContentView())

//#-end-hidden-code


/*:
 # Noting
 ## Learning how to deal with anxiety, you can't get rid of it
 
 Noting is not a meditation exercise, is more of a technique for handling moments where you feel a bit unconfortable due to anxiety.
 
 In order to apply the technique, when the feeling of disconfort arises, just acknowledge it, note the nature of the feeling and go back to your previous action or thought. It's rather simple but really effective.
 
 ## Just like the game on the right, gently tap your thoughts, don't fight them
 
 [Next Page](@next)
 
*/
