//
//  RandomUserTableViewCell.swift
//  Combine_Test
//
//  Created by 정지훈 on 2022/06/28.
//

import UIKit
import SDWebImage

class RandomUserTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.borderColor = UIColor.clear.cgColor
            profileImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindRandomUser(randomUser: RandomUser) {
        nameLabel.text = randomUser.name.first
        emailLabel.text = randomUser.email
        profileImageView.sd_setImage(with: URL(string: randomUser.photo.medium)!, completed: nil)
    }
    
}
