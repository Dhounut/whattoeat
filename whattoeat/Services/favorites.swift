//
//  favorites.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 5/1/26.
//  used to manage favorites
import Foundation
import Observation

@Observable
final class favorites{
    private(set) var favorites: [Restaurant] = [] {
        didSet { save() }
    }
    init() {
        load()
    }
    func contains(_ restaurant: Restaurant) -> Bool {
        favorites.contains { $0.matches(restaurant) }
    }
    func toggle(_ restaurant: Restaurant) {
        if let index = favorites.firstIndex(where: { $0.matches(restaurant) }) {
            favorites.remove(at: index)
        } else {
            favorites.append(restaurant)
        }
    }
    func remove(at index: Int) {
        favorites.remove(at: index)
    }
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storage.favorites) else { return }
        favorites = (try? JSONDecoder().decode([Restaurant].self, from: data)) ?? []
    }
    private func save() {
        guard let data = try? JSONEncoder().encode(favorites) else { return }
        UserDefaults.standard.set(data, forKey: storage.favorites)
    }
}
private extension Restaurant {
    func matches(_ other: Restaurant) -> Bool {
        name == other.name
    }
}
