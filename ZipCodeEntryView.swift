//
//  ZipCodeEntryView.swift
//  Civics Help
//
//  Created by Kamilla Urunbaeva on 2/11/25.
//
import SwiftUI

struct ZipCodeEntryView: View {
    @State private var zipCode: String = ""
    @State private var showRepresentativeView = false
    
    var isValidZipCode: Bool {
        let trimmed = zipCode.trimmingCharacters(in: .whitespaces)
        return trimmed.count == 5 && Int(trimmed) != nil
    }
    
    
    var body: some View {
        VStack {
            Text("Enter Your Zip Code")
                .font(.title)
                .padding()

            TextField("Zip Code", text: $zipCode)
                .keyboardType(.numberPad)
                .padding()
                .frame(height: 50)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()

            Button(action: {
                if isValidZipCode {
                    showRepresentativeView = true
                } else {
                    print("Invalid zip code")
                }
            }) {
                Text("Find My Representatives")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.cyan)
                    .cornerRadius(10)
            }
            .disabled(!isValidZipCode)
            .padding()
        }
        .padding()
        .navigationDestination(isPresented: $showRepresentativeView) {
                    RepresentativeListView(zipCode: zipCode.trimmingCharacters(in: .whitespaces))
        }
    }
}

#Preview {
    ZipCodeEntryView()
}
