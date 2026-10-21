//
//  tournamentModel.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/28/26.
// functions for use for the tournament
import Foundation
import Observation

@Observable
final class tournamentModel {
    enum Phase { case setup, match, complete }
    var phase: Phase = .setup
    var entries: [String] = []
    var newEntry: String = ""
    var contenders: [String] = []
    var champion: String = ""
    var challengerIndex: Int = 0
    var winner: String?
    var canStart: Bool { entries.count >= 2 }
    var challenger: String? {
        contenders.indices.contains(challengerIndex) ? contenders[challengerIndex] : nil
    }
    func addEntry() {
        let trimmed = newEntry.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        entries.append(trimmed)
        newEntry = ""
    }
    func removeEntry(at index: Int) {
        entries.remove(at: index)
    }
    func start() {
        contenders = entries.shuffled()
        champion = contenders[0]
        challengerIndex = 1
        winner = nil
        phase = .match
    }
    func pickChampion() { advance() }
    func pickChallenger() {
        if let c = challenger { champion = c }
        advance()
    }
    private func advance() {
        challengerIndex += 1
        if challengerIndex >= contenders.count {
            winner = champion
            phase = .complete
        }
    }
    func reset() {
        phase = .setup
        winner = nil
    }
}
