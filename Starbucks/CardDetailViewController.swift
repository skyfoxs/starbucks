//
//  CardDetailViewController.swift
//  Starbucks
//
//  Created by Supakit Thanadittagorn on 19/12/19.
//  Copyright © 2019 pop. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {

    // MARK: - Views
    let backgroundImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFill
        v.backgroundColor = .darkGray
        return v
    }()

    let gradientView: UIView = {
        let v = UIView()
        v.layer.masksToBounds = true
        return v
    }()

    let numberLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .bold)
        l.textColor = .white
        return l
    }()

    let amountLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = .white
        return l
    }()

    let contentBackgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return v
    }()

    let rewardsLabel: UILabel = {
        let l = UILabel()
        l.text = "Rewards and Benefits"
        l.font = .systemFont(ofSize: 20, weight: .light)
        l.textColor = .black
        return l
    }()

    let giftView: GiftView = {
        let v = GiftView()
        v.updateView(title: "10% OFF", description: "Enjoy 10% OFF on any Starbucks product", expire: "Expires June 20, 2020")
        return v
    }()

    let payLabel: UILabel = {
        let l = UILabel()
        l.text = "Pay in store"
        l.font = .systemFont(ofSize: 20, weight: .light)
        l.textColor = .black
        return l
    }()

    let barcodeImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()

    // MARK: - Data Model
    var card: StarbucksCard?

    // MARK: - Setup View
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupHeaderViewIfNeed()
        setupContentViewIfNeed()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupGradientViewIfNeed()
    }

    private func setupHeaderViewIfNeed() {
        guard backgroundImageView.superview == nil else { return }
        view.addSubview(backgroundImageView)
        view.addSubview(gradientView)
        view.addSubview(numberLabel)
        view.addSubview(amountLabel)

        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 250),
            gradientView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            numberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            numberLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            amountLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10),
            amountLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
        ])
    }

    private func setupGradientViewIfNeed() {
        guard gradientView.layer.sublayers == nil else { return }
        let g = CAGradientLayer()
        g.colors = [
            UIColor(white: 0, alpha: 0.7).cgColor,
            UIColor(white: 0, alpha: 0.7).cgColor,
        ]
        g.locations = [0.0, 1.0]
        g.startPoint = CGPoint(x: 0, y: 0)
        g.endPoint = CGPoint(x: 0, y: 1)
        g.frame = gradientView.bounds
        gradientView.layer.addSublayer(g)
    }

    private func setupContentViewIfNeed() {
        guard contentBackgroundView.superview == nil else { return }
        view.addSubview(contentBackgroundView)
        view.addSubview(rewardsLabel)
        view.addSubview(giftView)
        view.addSubview(payLabel)
        view.addSubview(barcodeImageView)

        contentBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        rewardsLabel.translatesAutoresizingMaskIntoConstraints = false
        giftView.translatesAutoresizingMaskIntoConstraints = false
        payLabel.translatesAutoresizingMaskIntoConstraints = false
        barcodeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentBackgroundView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -20),
            contentBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rewardsLabel.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 25),
            rewardsLabel.topAnchor.constraint(equalTo: contentBackgroundView.topAnchor, constant: 35),
            giftView.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 25),
            giftView.topAnchor.constraint(equalTo: rewardsLabel.bottomAnchor, constant: 15),
            giftView.trailingAnchor.constraint(equalTo: contentBackgroundView.trailingAnchor, constant: -25),
            payLabel.topAnchor.constraint(equalTo: giftView.bottomAnchor, constant: 50),
            payLabel.leadingAnchor.constraint(equalTo: contentBackgroundView.leadingAnchor, constant: 25),
            barcodeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            barcodeImageView.topAnchor.constraint(equalTo: payLabel.bottomAnchor, constant: 5),
            barcodeImageView.widthAnchor.constraint(equalToConstant: 300),
            barcodeImageView.heightAnchor.constraint(equalToConstant: 100)
        ])

    }

    // MARK: - Display Data
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    private func updateView() {
        guard let card = card else { return }
        numberLabel.text = card.number
        amountLabel.text = card.amount
        backgroundImageView.image = card.image
        barcodeImageView.image = card.number.pdf417Barcode
    }
}
