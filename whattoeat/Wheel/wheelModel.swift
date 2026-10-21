//
//  wheelModel.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/28/26.
//
import Foundation
import Observation

@Observable
final class wheelModel {
    var entries: [String] = []
    var newEntry: String = ""
    var isSpinning = false
    var selectedIndex: Int?
    var rotation: Double = 0
    var canSpin: Bool {
        entries.count >= 2 && !isSpinning
    }
    func addEntry() {
        let trimmed = newEntry.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        entries.append(trimmed)
        newEntry = ""
    }
    func removeEntry(at index: Int) {
        entries.remove(at: index)
        selectedIndex = nil
    }
    func spin() {
        guard canSpin else { return }
        isSpinning = true
        selectedIndex = nil
        let target = Int.random(in: 0..<entries.count)
        let sectorAngle = 360.0 / Double(entries.count)
        let targetMidOffset = sectorAngle * Double(target) + sectorAngle / 2
        let baseRotation = 360.0 - targetMidOffset
        rotation += 360 * 6 + baseRotation
        Task {
            try? await Task.sleep(for: .seconds(constants.spinDuration))
            isSpinning = false
            selectedIndex = target
        }
    }
}
