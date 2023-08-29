//
//  ContentView.swift
//  Drawing
//
//  Created by Dev Patel on 6/16/23.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arc: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
         var path = Path()
        
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Flower: Shape {
    var petalOffset = -20.0
    var petalWidth = 100.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct ColorCyclingView: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(colors: [
                            color(for: value, brightness: 1),
                            color(for: value, brightness: 0.5)
                        ], startPoint: .top, endPoint: .bottom)
                        , lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Trapezoid: Shape {
    var insetAmount: Double
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}

struct Arrow: Shape {
    var arrowBody: Double = 25
    //var thicknessFactor: Double
    
    var animatableData: Double {
        get { arrowBody }
        set { arrowBody = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Draws the arrowhead (a triangle)
        path.move(to: CGPoint(x: rect.width / 5 - (arrowBody - 25), y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width / 2, y: 0))
        path.addLine(to: CGPoint(x: rect.width / 5 * 4 + (arrowBody - 25), y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width / 5 - (arrowBody - 25), y: rect.height / 2))

        
        // Draws the arrow body (rectangle)
        path.move(to: CGPoint(x: rect.width / 2 - arrowBody, y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width / 2 - arrowBody, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width / 2 + arrowBody, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width / 2 + arrowBody, y: rect.height / 2))
        
        return path
    }
}

struct ColorCyclingRectangleView: View {
    var amount = 0.0
    var steps = 149
    
    var gradientStartX = 0.5
    var gradientStartY = 0.0
    
    var gradientEndX = 0.5
    var gradientEndY = 1.0
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(colors: [
                            color(for: value, brightness: 1),
                            color(for: value, brightness: 0.5)
                        ], startPoint: UnitPoint(x: gradientStartX, y: gradientStartY), endPoint: UnitPoint(x: gradientEndX, y: gradientEndY))
                        , lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    @State private var colorCycle = 0.0
    
    @State private var amount = 0.0
    
    @State private var insetAmount = 50.0
    
    @State private var rows = 4
    @State private var columns = 4
    
    @State private var arrowBody = 25.0
    
    @State private var gradientStartX = 0.5
    @State private var gradientStartY = 0.0
    
    @State private var gradientEndX = 0.5
    @State private var gradientEndY = 1.0
    
    var body: some View {
        
        VStack {
            ColorCyclingRectangleView(amount: colorCycle, gradientStartX: gradientStartX, gradientEndX: gradientEndX, gradientEndY: gradientEndY)
                .frame(width: 300, height: 400)
            
            HStack {
                Text("End Y")
                Slider(value: $colorCycle)
            }
            
            HStack {
                Text("Color")
                Slider(value: $gradientStartX)
            }
            
            HStack {
                Text("Start X")
                Slider(value: $gradientStartY)
            }
            
            HStack {
                Text("Start Y")
                Slider(value: $gradientEndX)
            }
            
            HStack {
                Text("End X")
                Slider(value: $gradientEndY)
            }

        }
        
//         Animate an arrow as it changes (either by tap or slider)

//        VStack {
//            Arrow(arrowBody: arrowBody)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    withAnimation {
//                        arrowBody = Double.random(in: 10...60)
//                    }
//                }
//
//            Slider(value: $arrowBody, in: 10...60) // Must be less than width / 5
//        }
        
        // Checkerboard that animates on being tapped (animation with animatablePair)
        
//        Checkerboard(rows: rows, columns: columns)
//            .onTapGesture {
//                withAnimation(.linear(duration: 3)) {
//                    rows = 8
//                    columns = 16
//                }
//            }
        
        // Animate a trapezoid shape as it changes
        
//        Trapezoid(insetAmount: insetAmount)
//            .frame(width: 200, height: 100)
//            .onTapGesture {
//                withAnimation {
//                    insetAmount = Double.random(in: 10...90)
//                }
//            }
        
        // Color tri diaggram with slider (blend colors using screen effect)
        
//        VStack {
//            ZStack {
//                Circle()
//                    .fill(Color(red: 1, green: 0, blue: 0))
//                    .frame(width: amount * 200)
//                    .offset(x: -50, y: -80)
//                    .blendMode(.screen)
//                Circle()
//                    .fill(Color(red: 0, green: 1, blue: 0))
//                    .frame(width: amount * 200)
//                    .offset(x: 50, y: -80)
//                    .blendMode(.screen)
//                Circle()
//                    .fill(Color(red: 0, green: 0, blue: 1))
//                    .frame(width: amount * 200)
//                    .blendMode(.screen)
//            }
//            .frame(width: 300, height: 300)
//
//            Slider(value: $amount)
//                .padding()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.black)
//        .ignoresSafeArea()
        
//        ZStack {
//            Image("Rock")
//
//            Rectangle()
//                .colorMultiply(.red)
//        }
        
        // Create circles that form a gradient of hues
        
//        VStack {
//            ColorCyclingView(amount: colorCycle)
//                .frame(width: 300, height: 300)
//
//            Slider(value: $colorCycle)
//        }
        
        
        // Create an image border with ImagePaint
        
//        Capsule()
//            .strokeBorder(ImagePaint(image: Image("Rock"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.75), scale: 0.03), lineWidth: 20)
//            .frame(width: 300, height: 200)

        
        // Creates a flower with ellipse petals rotated 360 degrees (even odd fill)
        
//        VStack {
//            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                .fill(.red, style: FillStyle(eoFill: true))
//            Text("Petal Offset")
//            Slider(value: $petalOffset, in: -40...40)
//                .padding([.horizontal, .bottom])
//
//            Text("Petal Width")
//            Slider(value: $petalWidth, in: 0...100)
//                .padding(.horizontal)
//
//        }
        
        // Creates a basic path to draw a fixed triangle
        
//        Path { path in
//            path.move(to: CGPoint(x: 200, y: 100))
//            path.addLine(to: CGPoint(x: 100, y: 300))
//            path.addLine(to: CGPoint(x: 300, y: 300))
//            path.addLine(to: CGPoint(x: 200, y: 100))
//            path.closeSubpath()
//        }
//        .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        
        
//        Triangle()
//            .fill(.red)
//            .frame(width: 300, height: 300)
        
        
//        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
//            .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round))
//            .frame(width: 300, height: 300)
        
//        Arc(startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)  //Circle()
//            .strokeBorder(.blue, lineWidth: 40)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
