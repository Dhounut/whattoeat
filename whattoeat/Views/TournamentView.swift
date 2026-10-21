//
//  TournamentView.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/1/26.
// 
import SwiftUI

struct TournamentView: View {
    @State private var vm = tournamentModel()
    var body: some View {
        @Bindable var vm = vm
        
        NavigationStack {
            Group {
                switch vm.phase {
                case .setup: setup
                case .match: match
                case .complete: winner
                }
            }
            .navigationTitle("Tournament")
        }
    }
    private var setup: some View {
        VStack(spacing: spacing.md) {
            Spacer()
            Image(systemName: AppIcon.tournament)
                .font(.system(size: 60))
                .foregroundStyle(colors.secondaryText)
            Spacer()
            HStack {
                TextField("Add an option…", text: $vm.newEntry)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit { vm.addEntry() }
                
                Button {
                    vm.addEntry()
                } label: {
                    Image(systemName: "plus.circle.fill").font(.title2)
                }
            }
            .padding(.horizontal, spacing.md)
            if !vm.entries.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: spacing.xs) {
                        ForEach(Array(vm.entries.enumerated()), id: \.offset) { index, entry in
                            itemEntry(entry: entry) {
                                vm.removeEntry(at: index)
                            }
                        }
                    }
                    .padding(.horizontal, spacing.md)
                }
            }
            Spacer()
            Button {
                vm.start()
            } label: {
                Label("Start Tournament", systemImage: AppIcon.tournament)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, spacing.xs)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(colors.accent)
            .disabled(!vm.canStart)
            .padding([.horizontal, .bottom], spacing.md)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    private var match: some View {
        VStack(spacing: spacing.lg) {
            Text("Match \(vm.challengerIndex) of \(vm.contenders.count - 1)")
                .font(.subheadline)
                .foregroundStyle(colors.secondaryText)
                .padding(.top, spacing.md)
            
            Spacer()
            
            contenderCard(name: vm.champion, color: colors.accent) {
                vm.pickChampion()
            }
            
            Text("VS")
                .font(.system(size: 28, weight: .heavy, design: .rounded))
                .foregroundStyle(colors.accentSecondary)
            
            if let c = vm.challenger {
                contenderCard(name: c, color: colors.accent.opacity(0.7)) {
                    vm.pickChallenger()
                }
            }
            
            Spacer()
            
            Button("Cancel", role: .destructive) { vm.reset() }
                .padding(.bottom, spacing.md)
        }
        .padding(.horizontal, spacing.md)
    }
    private func contenderCard(name: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(name)
                .font(.title.weight(.bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, spacing.lg)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: radius.large))
        }
        .buttonStyle(.plain)
    }
    private var winner: some View {
        VStack(spacing: spacing.lg) {
            Spacer()
            
            Image(systemName: AppIcon.winner)
                .font(.system(size: 80))
                .foregroundStyle(colors.accentSecondary)
                .symbolEffect(.bounce, value: vm.winner)
            
            Text(vm.winner ?? "")
                .font(.system(size: 44, weight: .heavy, design: .rounded))
                .foregroundStyle(colors.accent)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button {
                vm.reset()
            } label: {
                Text("Start Over")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, spacing.xs)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(colors.accent)
            .padding([.horizontal, .bottom], spacing.md)
        }
    }
}

#Preview {
    TournamentView()
}
