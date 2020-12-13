//
//  StringExtensions.swift
//  TMApp
//
//  Created by Jeet Kapadia on 13/12/20.
//

import Foundation

extension String {
    
    func getDisplayableDateFormat(_ withString: String) -> String{
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: withString)!
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
