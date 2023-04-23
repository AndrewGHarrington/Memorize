//
//  DataService.swift
//  Memorize
//
//  Created by Andrew Harrington on 4/22/23.
//

import Foundation

struct DataService<CardContent> {
    static func getThemeData() -> [Theme<CardContent>]? {
        // get path from bundle
        let pathString = Bundle.main.path(forResource: "themeData", ofType: "json")
        
        guard pathString != nil else {
            return nil
        }
        
        // convert path to url
        let url = URL(fileURLWithPath: "pathString")
        
        do {
            // make data object from url
            let data = try Data(contentsOf: url)
            
            // make decoder
            let decoder = JSONDecoder()
            
            do {
                // decode json
                let themeData = try decoder.decode([Theme<CardContent>], from: data)
                
                // return array of themes
                return themeData
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
