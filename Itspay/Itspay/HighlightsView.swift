//
//  HighlightsView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/20/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class HighlightsView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighlightsCellIdentifier", for: indexPath)
        
        if let viewLeft = cell.viewWithTag(1) {
            if let label = viewLeft.viewWithTag(1) as? UILabel {
                label.text = ""
            }
            if let imageView = viewLeft.viewWithTag(2) as? UIImageView {
                
            }
            if let label = viewLeft.viewWithTag(3) as? UILabel {
                label.text = ""
            }
            if let label = viewLeft.viewWithTag(4) as? UILabel {
                label.text = ""
            }
            if let label = viewLeft.viewWithTag(5) as? UILabel {
                label.text = ""
            }
        }
        
        if let viewRight = cell.viewWithTag(2) {
            if let label = viewRight.viewWithTag(1) as? UILabel {
                label.text = ""
            }
            if let imageView = viewRight.viewWithTag(2) as? UIImageView {
                
            }
            if let label = viewRight.viewWithTag(3) as? UILabel {
                label.text = ""
            }
            if let label = viewRight.viewWithTag(4) as? UILabel {
                label.text = ""
            }
            if let label = viewRight.viewWithTag(5) as? UILabel {
                label.text = ""
            }
        }

        return cell
    }
}
