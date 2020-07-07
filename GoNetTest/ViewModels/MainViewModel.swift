//
//  MainViewModel.swift
//  GoNetTest
//
//  Created by José Dávalos Rosas on 05/07/20.
//  Copyright © 2020 José Dávalos Rosas. All rights reserved.
//

import Foundation

struct MainViewModel {
    
    private let titles = ["Bravo", "Melon Ball", "Sierra", "Aquaris", "Full Swing", "Triangle", "Kilo", "Bump", "Mountain Lion"]
    
    private let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Mi quis hendrerit dolor magna. Ac tincidunt vitae semper quis lectus nulla. Id aliquet lectus proin nibh. Scelerisque felis imperdiet proin fermentum leo vel orci porta non. Dictumst quisque sagittis purus sit. Libero enim sed faucibus turpis in eu mi bibendum. Arcu odio ut sem nulla pharetra diam. Enim nec dui nunc mattis enim ut tellus elementum. Turpis nunc eget lorem dolor sed viverra ipsum nunc. Mauris pellentesque pulvinar pellentesque habitant morbi tristique senectus et. Nascetur ridiculus mus mauris vitae ultricies leo integer malesuada. Facilisis mauris sit amet massa vitae tortor condimentum lacinia. In hac habitasse platea dictumst quisque sagittis purus. Varius quam quisque id diam vel. Iaculis urna id volutpat lacus laoreet non. Vel pretium lectus quam id leo in vitae turpis. Pellentesque elit ullamcorper dignissim cras tincidunt lobortis feugiat vivamus at. Aliquam faucibus purus in massa tempor nec feugiat nisl. Eget nunc lobortis mattis aliquam faucibus purus in massa."
    
    func getDummyData(with rowNumber: Int) -> [DummyData] {
        var description = [DummyData]()
        for index in 0...rowNumber {
            description.append(DummyData(image: Images.placeholder, title: getTitle(with: index), description: getLoremIpsumText(with: index)))
        }
        return description
    }
    
    private func getTitle(with index: Int) -> String {
        var title: [String] = []
        if index < 1 {
            return titles[index]
        }
        for number in 0...index {
            title.append(String(titles[number]))
        }
        return title.joined(separator: " ")
    }
    
    private func getLoremIpsumText(with rowNumber: Int) -> String {
        let numberOfRows = (rowNumber > 0 && rowNumber < 4) ? 1 + rowNumber : 4
        let numberOfWords = 6 * numberOfRows
        let words = loremIpsum.split(separator: " ")
        var selectedWords:[String] = []
        
        for index in 0...numberOfWords {
            selectedWords.append(String(words[index]))
        }
        return selectedWords.joined(separator: " ")
    }
    
}
