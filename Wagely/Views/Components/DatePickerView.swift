//
//  DatePickerView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import SwiftUI

private struct DatePickerViewRepresentable: UIViewRepresentable {
    @Binding var selection: Date
    
    func makeUIView(context: Context) -> UIDatePicker {
        let picker = UIDatePicker(frame: .zero)
        picker.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        picker.datePickerMode = .yearAndMonth
        picker.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.valueChanged),
            for: .valueChanged
        )
        return picker
    }
    
    func updateUIView(_ datePicker: UIDatePicker, context: Context) {
        datePicker.setDate(selection, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        .init(selection: $selection)
    }
}

private extension DatePickerViewRepresentable {
    final class Coordinator: NSObject {
        var selection: Binding<Date>
        
        init(selection: Binding<Date>) {
            self.selection = selection
        }
        
        @objc func valueChanged(sender: UIDatePicker, event: UIControl.Event) {
            selection.wrappedValue = sender.date
        }
    }
}

struct DatePickerView: View {
    @Binding var selection: Date
    
    var body: some View {
        DatePickerViewRepresentable(selection: $selection)
    }
}

#Preview {
    struct Preview: View {
        @State private var date = Date()
        
        var body: some View {
            VStack {
                DatePickerView(selection: $date)
                Text(date, format: .dateTime.month().year())
                Button("Reset") { date = .now }
            }
        }
    }
    
    return Preview()
}
