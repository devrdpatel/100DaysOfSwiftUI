//
//  FormatStyle-LocalCurrency.swift
//  iExpense
//
//  Created by Dev Patel on 7/25/23.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.identifier ?? "USD")
    }
}
