//
//  HomeTableViewCell.swift
//  DigihuntingApp
//
//  Created by Daniel Cano Platero on 12/5/22.
//

import UIKit
import SwiftUI

final class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "homeTableViewCell"
    
    private let cityImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Style.Fonts.titleFont
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = Style.Fonts.subtitleFont
        return label
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupView() {
        contentView.addAutolayoutView([cityImageView, stackView])
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(addressLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cityImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Style.Spacing.spacingS),
            cityImageView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -Style.Spacing.spacingS),
            cityImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityImageView.heightAnchor.constraint(equalToConstant: 40),
            cityImageView.widthAnchor.constraint(equalToConstant: 40),
            
            stackView.centerYAnchor.constraint(equalTo: cityImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: Style.Spacing.spacingM),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Style.Spacing.spacingL),
        ])
    }
    
    func configCell(with city: CityModel) {
        titleLabel.text = city.name
        addressLabel.text = city.address
        
        guard let imageURL = city.cover else {
            self.cityImageView.image = UIImage(named: "kite")
            return
        }
        
        cityImageView.loadImage(url: imageURL)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
}
