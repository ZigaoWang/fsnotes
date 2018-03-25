//
//  FontViewController.swift
//  FSNotes iOS
//
//  Created by Oleksandr Glushchenko on 3/16/18.
//  Copyright © 2018 Oleksandr Glushchenko. All rights reserved.
//

import UIKit
import NightNight

class FontViewController: UITableViewController {
    private var fontFamilyNames: [String]? = []
    
    override func viewDidLoad() {
        view.mixedBackgroundColor = MixedColor(normal: 0xffffff, night: 0x000000)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FontViewController.cancel))
        
        self.title = "Font Family"
        
        let names = UIFont.familyNames
        for familyName in names {
            fontFamilyNames?.append(familyName)
            fontFamilyNames = fontFamilyNames?.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        }
        
        navigationController?.navigationBar.mixedTitleTextAttributes = [NNForegroundColorAttributeName: MixedColor(normal: 0x000000, night: 0xfafafa)]
        navigationController?.navigationBar.mixedTintColor = MixedColor(normal: 0x0000ff, night: 0xfafafa)
        navigationController?.navigationBar.mixedBarTintColor = MixedColor(normal: 0xffffff, night: 0x222222)
        navigationController?.navigationBar.mixedBarStyle = MixedBarStyle(normal: .default, night: .black)
        
        super.viewDidLoad()
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.mixedBackgroundColor = MixedColor(normal: 0xffffff, night: 0x000000)
        cell.textLabel?.mixedTextColor = MixedColor(normal: 0x000000, night: 0xffffff)
        
        let fontFamily = UserDefaultsManagement.noteFont.familyName
        
        if let f = fontFamilyNames {
            if f[indexPath.row] == fontFamily {
                cell.accessoryType = .checkmark
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath), let label = cell.textLabel, let fontFamily = label.text {
            UserDefaultsManagement.noteFont = UIFont(name: fontFamily, size: CGFloat(UserDefaultsManagement.fontSize))
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if let f = fontFamilyNames {
            cell.textLabel?.text = f[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let f = fontFamilyNames {
            return f.count
        }
        
        return 0
    }
}

