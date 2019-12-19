//
//  CardTableViewCell.swift
//  Starbucks
//
//  Created by Supakit Thanadittagorn on 19/12/19.
//  Copyright © 2019 pop. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    let shadowView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = false
        v.layer.shadowRadius = 6
        v.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        v.layer.shadowOpacity = 0.75
        return v
    }()

    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.backgroundColor = .darkGray
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.darkGray.cgColor
        return iv
    }()

    let gradientView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        return v
    }()

    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .bold)
        l.textColor = .white
        return l
    }()

    let subTitleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = .white
        return l
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradientViewIfNeed()
        optimizeShadowViewIfNeed()
    }

    private func setupGradientViewIfNeed() {
        guard gradientView.layer.sublayers == nil else { return }
        let g = CAGradientLayer()
        g.colors = [
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        g.locations = [0.0, 0.7, 1.0]
        g.startPoint = CGPoint(x: 0, y: 0)
        g.endPoint = CGPoint(x: 0, y: 1)
        g.frame = gradientView.bounds
        gradientView.layer.addSublayer(g)
    }

    private func optimizeShadowViewIfNeed() {
        guard shadowView.layer.shadowPath == nil else { return }
        shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
        shadowView.layer.shouldRasterize = true
        shadowView.layer.rasterizationScale = UIScreen.main.scale
    }

    func updateView(card: StarbucksCard) {
        titleLabel.text = String(card.number.suffix(4))
        subTitleLabel.text = card.amount
        backgroundImageView.image = card.image
    }

    private func setupView() {
        addSubview(shadowView)
        addSubview(backgroundImageView)
        addSubview(gradientView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)

        shadowView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: 15),
            bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 20),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 20),
            backgroundImageView.bottomAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 20),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 250),
            shadowView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            gradientView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor)
        ])
    }

}
