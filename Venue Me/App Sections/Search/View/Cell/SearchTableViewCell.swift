//
//  SearchTableViewCell.swift
//  Venue Me
//
//  Created by Tiago Oliveira on 15/01/19.
//  Copyright © 2019 Tiago Oliveira. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var venueDistance: UILabel!
    @IBOutlet weak var venueAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func render(_ venue: Venue) {
        self.venueName.text = venue.name
        self.venueDistance.text = String(venue.location.distance)
        self.venueAddress.text = venue.bindAddress()
    }
}

extension Venue {
    func bindAddress() -> String {
        var boundAddress: String = ""
        boundAddress.append("\(self.location.address) (\(self.location.crossStreet))\n")
        boundAddress.append("\(self.location.city), \(self.location.state)\n")
        boundAddress.append("\(self.location.country)")
        
        return boundAddress
    }
}
