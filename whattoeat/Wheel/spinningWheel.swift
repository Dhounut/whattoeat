//
//  spinningWheel.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/28/26.
//  manages spinnign the wheel
import SwiftUI
struct spinningWheel: View {
    let entries: [String]
    let rotation: Double
    let highlightedIndex: Int?
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            ZStack {
                ZStack {
                    ForEach(Array(entries.enumerated()), id: \.offset) { index, entry in
                        wheelSection(
                            index: index,
                            total: entries.count,
                            label: entry,
                            isHighlighted: highlightedIndex == index,
                            size: size
                        )
                    }
                    Circle()
                        .fill(colors.accent)
                        .frame(width: size * 0.12, height: size * 0.12)
                }
                .rotationEffect(.degrees(rotation))
                .animation(.timingCurve(0.2, 0.8, 0.4, 1.0, duration: constants.spinDuration),
                           value: rotation)
                Triangle()
                    .fill(colors.accentSecondary)
                    .frame(width: 24, height: 28)
                    .offset(y: -size / 2 + 4)
            }
            .frame(width: size, height: size)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
private struct wheelSection: View {
    let index: Int
    let total: Int
    let label: String
    let isHighlighted: Bool
    let size: CGFloat
    var body: some View {
        let radius = size / 2
        let sectorAngle = 360.0 / Double(total)
        let midAngle = Double(index) * sectorAngle + sectorAngle / 2
        let startDeg = Double(index) * sectorAngle - 90
        let endDeg = Double(index + 1) * sectorAngle - 90
        let labelRadius = radius * 0.62
        let fontSize = max(11, min(20, size / CGFloat(total) / 2.2))
        let fillColor: Color = isHighlighted
            ? colors.accentSecondary
            : sectionColor(for: index)
        return ZStack {
            Path { path in
                let center = CGPoint(x: radius, y: radius)
                path.move(to: center)
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: .degrees(startDeg),
                    endAngle: .degrees(endDeg),
                    clockwise: false
                )
                path.closeSubpath()
            }
            .fill(fillColor)
            Text(label)
                .font(.system(size: fontSize, weight: .semibold))
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(width: radius * 0.7)
                .offset(y: -labelRadius)
                .rotationEffect(.degrees(midAngle))
        }
        .frame(width: size, height: size)
    }
    private func sectionColor(for index: Int) -> Color {
        switch index % 3 {
        case 0: return colors.accent
        case 1: return colors.accent.opacity(0.75)
        default: return colors.accent.opacity(0.5)
        }
    }
}
private struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            p.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            p.closeSubpath()
        }
    }
}
