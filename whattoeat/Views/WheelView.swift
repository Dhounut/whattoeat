//
//  WheelView.swift
//  whattoeat
//
//  Created by Deven Weeden (RIT Student) on 4/1/26.
//
import SwiftUI

struct WheelView: View {
    @State private var viewModel = wheelModel()
    var body: some View {
        @Bindable var vm = viewModel
        VStack(spacing: spacing.md) {
            Spacer()
            
            if viewModel.entries.isEmpty {
                Image(systemName: AppIcon.wheel)
                    .font(.system(size: 60))
                    .foregroundStyle(colors.secondaryText)
            } else {
                spinningWheel(
                    entries: viewModel.entries,
                    rotation: viewModel.rotation,
                    highlightedIndex: viewModel.selectedIndex
                )
                .padding(.horizontal, spacing.md)
                
                if let index = viewModel.selectedIndex, !viewModel.isSpinning {
                    Text(viewModel.entries[index])
                        .font(.system(size: 36, weight: .heavy, design: .rounded))
                        .foregroundStyle(colors.accent)
                }
            }
            Spacer()
            
            HStack {
                TextField("Add an option…", text: $vm.newEntry)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit { viewModel.addEntry() }
                Button {
                    viewModel.addEntry()
                } label: {
                    Image(systemName: "plus.circle.fill").font(.title2)
                }
            }
            .padding(.horizontal, spacing.md)
            if !viewModel.entries.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: spacing.xs) {
                        ForEach(Array(viewModel.entries.enumerated()), id: \.offset) { index, entry in
                            itemEntry(entry: entry) {
                                viewModel.removeEntry(at: index)
                            }
                        }
                    }
                    .padding(.horizontal, spacing.md)
                }
            }
            Spacer()
            Button {
                viewModel.spin()
            } label: {
                Label("Spin", systemImage: "arrow.triangle.2.circlepath")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, spacing.xs)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(colors.accent)
            .disabled(!viewModel.canSpin)
            .padding(.horizontal, spacing.md)
            .padding(.bottom, spacing.md)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationTitle("Wheel")
    }
}

#Preview {
    NavigationStack {
        WheelView()
    }
}
