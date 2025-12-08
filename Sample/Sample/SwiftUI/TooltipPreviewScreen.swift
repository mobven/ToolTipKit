//
//  TooltipPreviewScreen.swift
//  TooltipKitUI
//
//  Created by Akin Ozcan on 4.12.2025.
//

import SwiftUI
import TooltipKitUI

struct TooltipPreviewScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showTooltip = false
    
    // Text Content
    @State private var tooltipTitle = "Tooltip Title"
    @State private var tooltipDescription = "This is the tooltip description text. You can test all features from here."
    
    // Colors
    @State private var titleColor = Color.black
    @State private var descriptionColor = Color.gray
    @State private var backgroundColor = Color.white
    
    // Typography
    @State private var titleFontSize: CGFloat = 12
    @State private var titleFontWeight: Font.Weight = .regular
    @State private var descriptionFontSize: CGFloat = 12
    @State private var descriptionFontWeight: Font.Weight = .regular
    
    // Layout
    @State private var tooltipWidth: CGFloat = 350
    @State private var spacing: CGFloat = 16

    var body: some View {
        NavigationView {
            TooltipContainer {
                GeometryReader { proxy in
                    ZStack {
                        Color(.systemBackground)
                            .ignoresSafeArea()
                        
                        VStack(spacing: 0) {
                            // Test Button
                            testButton
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            // Control Panel
                            controlPanel
                                .frame(height: proxy.size.height * 0.5)
                        }
                    }
                }
            }
            .navigationTitle("Tooltip Customization")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    private var testButton: some View {
        Button {
            withAnimation {
                showTooltip.toggle()
            }
        } label: {
            VStack(spacing: 8) {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 40))
                Text("Show Tooltip")
                    .font(.headline)
            }
            .foregroundColor(.blue)
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(12)
        }
        .tooltip(
            isPresented: $showTooltip,
            title: tooltipTitle,
            description: tooltipDescription,
            titleFont: .system(size: titleFontSize, weight: titleFontWeight),
            descriptionFont: .system(size: descriptionFontSize, weight: descriptionFontWeight),
            titleColor: titleColor,
            descriptionColor: descriptionColor,
            tooltipWidth: tooltipWidth,
            spacing: spacing,
            backgroundColor: backgroundColor
        )
    }
    
    private var controlPanel: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Text Content Section
                sectionHeader("Text Content")
                textContentSection
                
                // Colors Section
                sectionHeader("Colors")
                colorsSection
                
                // Typography Section
                sectionHeader("Typography")
                typographySection
                
                // Layout Section
                sectionHeader("Layout")
                layoutSection
                
                Spacer(minLength: 20)
            }
            .padding()
        }
        .background(.ultraThinMaterial)
    }
    
    private func sectionHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
    
    private var textContentSection: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Title")
                    .font(.caption)
                TextField("Title", text: $tooltipTitle)
                    .textFieldStyle(.roundedBorder)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Description")
                    .font(.caption)
                TextField("Description", text: $tooltipDescription, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...6)
            }
        }
    }
    
    private var colorsSection: some View {
        VStack(spacing: 12) {
            colorPicker("Title Color", selection: $titleColor)
            colorPicker("Description Color", selection: $descriptionColor)
            colorPicker("Background Color", selection: $backgroundColor)
        }
    }
    
    private func colorPicker(_ label: String, selection: Binding<Color>) -> some View {
        HStack {
            Text(label)
                .font(.subheadline)
            Spacer()
            ColorPicker("", selection: selection)
                .labelsHidden()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
    }
    
    private var typographySection: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Title Font Size: \(Int(titleFontSize))")
                    .font(.caption)
                Slider(value: $titleFontSize, in: 8...24, step: 1)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Title Font Weight")
                    .font(.caption)
                Picker("", selection: $titleFontWeight) {
                    Text("Regular").tag(Font.Weight.regular)
                    Text("Medium").tag(Font.Weight.medium)
                    Text("Semibold").tag(Font.Weight.semibold)
                    Text("Bold").tag(Font.Weight.bold)
                }
                .pickerStyle(.segmented)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Description Font Size: \(Int(descriptionFontSize))")
                    .font(.caption)
                Slider(value: $descriptionFontSize, in: 8...20, step: 1)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Description Font Weight")
                    .font(.caption)
                Picker("", selection: $descriptionFontWeight) {
                    Text("Regular").tag(Font.Weight.regular)
                    Text("Medium").tag(Font.Weight.medium)
                    Text("Semibold").tag(Font.Weight.semibold)
                    Text("Bold").tag(Font.Weight.bold)
                }
                .pickerStyle(.segmented)
            }
        }
    }
    
    private var layoutSection: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Tooltip Width: \(Int(tooltipWidth))")
                    .font(.caption)
                Slider(value: $tooltipWidth, in: 200...500, step: 10)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Title-Description Spacing: \(Int(spacing))")
                    .font(.caption)
                Slider(value: $spacing, in: 0...32, step: 2)
            }
        }
    }
}

#Preview {
    TooltipPreviewScreen()
}


