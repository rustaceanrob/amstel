//
//  SettingsView.swift
//  amstel
//
//  Created by Robert Netzke on 7/8/25.
//
import SwiftUI

struct SettingsView: View {
    @Binding var isPresented: Bool
    @AppStorage("numConns") private var numConns: Int = 3
    @AppStorage("useProxy") private var useProxy: Bool = false

    private func openDataDirectory() {
        let fileManager = FileManager.default
        if let containerURL = fileManager.urls(for: .libraryDirectory, in: .userDomainMask).first {
            let appSupportURL = containerURL.deletingLastPathComponent()
            NSWorkspace.shared.open(appSupportURL)
        }
    }

    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        Stepper(value: $numConns, in: 1...10) {
                            Text("")
                        }
                        .labelsHidden()
                        Text("Connections \(numConns)")
                    }
                    VStack(alignment: .leading) {
                        Toggle("Tor proxy", isOn: $useProxy)
                        Text("Route connections through a Tor proxy hosted at 127.0.0.1:9050")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        
                    }
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                    Button(action: openDataDirectory) {
                        HStack {
                            Image(systemName: "folder")
                            Text("Open Data Directory")
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Dismiss") {
                    isPresented = false
                }
            }
        }
        .padding()
        .frame(width: 300)
        .navigationTitle("Settings")
    }
}

#Preview {
    @Previewable @State var isPresented = true
    SettingsView(isPresented: $isPresented)
}

