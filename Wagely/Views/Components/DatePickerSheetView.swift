//
//  DatePickerSheetView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import SwiftUI

struct DatePickerSheetView: View {
    @Binding var selection: Date
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationStack {
            DatePickerView(selection: $selection)
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Done") { presentationMode.wrappedValue.dismiss() }
                    }
                }
        }
    }
}

#Preview {
    struct Preview: View {
        @State private var date = Date()
        
        var body: some View {
            NavigationStack {
                DatePickerSheetView(selection: $date)
            }
        }
    }
    
    return Preview()
}
