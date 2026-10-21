//
//  whattoeatApp.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/1/26.
//
import SwiftUI

@main
struct whattoeatapp: App {
    @State private var locations = location()
    @State private var favorite = favorites()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(locations)
                .environment(favorite)
        }
    }
}
