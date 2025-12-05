//
//  CalendarMonth.swift
//  ZakFit
//
//  Created by Emma on 04/12/2025.
//

import SwiftUI

struct CalendarMonth: View {
    @Binding var month: Date
    @State var selectedDate: Date = Date.now
    @Environment(\.calendar) private var calendar
    @Environment(\.locale) private var locale
    @Environment(MealViewModel.self) var mealVM
    
    private var daysGrid: [Date?] {
        let cal = calendar
        let startOfMonth = cal.date(from: cal.dateComponents([.year, .month], from: month))!
        let range = cal.range(of: .day, in: .month, for: startOfMonth)!
        let firstWeekdayIndex = cal.component(.weekday, from: startOfMonth) - cal.firstWeekday
        let leading = (firstWeekdayIndex + 7) % 7
        
        var result: [Date?] = Array(repeating: nil, count: leading)
        for day in range {
            result.append(cal.date(byAdding: .day, value: day - 1, to: startOfMonth)!)
        }
        return result
    }
    
    private var monthTitle: String {
        let f = DateFormatter()
        f.calendar = calendar
        f.locale = Locale(identifier: "fr_FR")
        f.dateFormat = "LLLL"
        return f.string(from: month).capitalized
    }
    
    private var yearTitle: String {
        let f = DateFormatter()
        f.calendar = calendar
        f.locale = locale
        f.dateFormat = "yyyy"
        return f.string(from: month)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            //MARK: - Header
            HStack {
                Button { shiftMonth(-1) } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                }
                Spacer()
                VStack {
                    Text(monthTitle)
                        .font(.system(size: 22, weight: .semibold))
                    Text(yearTitle)
                        .font(.system(size: 22, weight: .semibold))
                }
                Spacer()
                Button { shiftMonth(+1) } label: {
                    Image(systemName: "chevron.right")
                        .font(.headline)
                }
            }
            .foregroundStyle(.text)
            .padding(.horizontal)
            
            //MARK: - Weekday row
            HStack {
                ForEach(weekdaySymbols(), id: \.self) { s in
                    Text(s)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            
            //MARK: - Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7), spacing: 20) {
                ForEach(daysGrid.indices, id: \.self) { i in
                    if let date = daysGrid[i] {
                        DayCell(
                            date: date,
                            isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
                            onSelect: { selectedDate = date
                            month = date
                            }
                        )
                        .frame(height: 40)
                    } else {
                        Color.clear.frame(height: 40)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
    
    private func shiftMonth(_ delta: Int) {
        if let new = calendar.date(byAdding: .month, value: delta, to: month) {
            month = new
        }
    }
    
    private func weekdaySymbols() -> [String] {
        let sym = calendar.shortWeekdaySymbols
        let start = calendar.firstWeekday - 1
        return Array(sym[start...] + sym[..<start]).map { $0.uppercased() }
    }
}

// MARK: - DayCell
private struct DayCell: View {
    let date: Date
    let isSelected: Bool
    let onSelect: () -> Void
    
    @Environment(\.calendar) private var calendar
    
    private var isToday: Bool {
        calendar.isDateInToday(date)
    }
    
    var body: some View {
        Button(action: onSelect) {
            ZStack {
                Circle()
                    .fill(isSelected ? Color.greenApp : Color.greenApp.opacity(0.2))
                
                if isToday && !isSelected {
                    Circle()
                        .inset(by: -3)
                        .strokeBorder(.greenApp, lineWidth: 2)
                }
                
                Text(String(calendar.component(.day, from: date)))
                    .font(.system(size: 16))
                    .bold()
                    .foregroundStyle(isSelected ? .white : .text)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CalendarMonth(month: .constant(Date()))
        .environment(MealViewModel())
}
