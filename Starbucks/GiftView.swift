//
//  GiftView.swift
//  Starbucks
//
//  Created by Odds on 20/12/19.
//  Copyright © 2019 pop. All rights reserved.
//

import UIKit

class GiftView: UIView {

    let giftImageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "gift")
        v.contentMode = .scaleAspectFit
        return v
    }()

    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 17, weight: .bold)
        l.textColor = .white
        return l
    }()

    let descriptionLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 17, weight: .light)
        l.numberOfLines = 0
        l.textColor = .white
        return l
    }()

    let expireDateLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .light)
        l.textColor = .white
        return l
    }()

    let lightBackgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9239661829, green: 0.9616181095, blue: 0.927525643, alpha: 1)
        return v
    }()

    let darkBackgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(lightBackgroundView)
        addSubview(darkBackgroundView)
        addSubview(giftImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(expireDateLabel)

        lightBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        darkBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        giftImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        expireDateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            lightBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lightBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            lightBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lightBackgroundView.trailingAnchor.constraint(equalTo: giftImageView.trailingAnchor, constant: 7.5),
            darkBackgroundView.leadingAnchor.constraint(equalTo: lightBackgroundView.trailingAnchor),
            darkBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            darkBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            darkBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            giftImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            giftImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            giftImageView.widthAnchor.constraint(equalToConstant: 100),
            giftImageView.heightAnchor.constraint(equalTo: giftImageView.widthAnchor, multiplier: 304.0/392.0),
            titleLabel.leadingAnchor.constraint(equalTo: darkBackgroundView.leadingAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: darkBackgroundView.leadingAnchor, constant: 15),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 15),
            expireDateLabel.leadingAnchor.constraint(equalTo: darkBackgroundView.leadingAnchor, constant: 15),
            expireDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            expireDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 15),
            expireDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])

        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        clipsToBounds = true
    }

    func updateView(title: String, description: String, expire: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        expireDateLabel.text = expire
    }
}
