//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Dipti Yadav on 6/28/23.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}
