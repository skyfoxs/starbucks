//
//  CardController.swift
//  Starbucks
//
//  Created by Supakit Thanadittagorn on 19/12/19.
//  Copyright © 2019 pop. All rights reserved.
//

import UIKit

struct StarbucksCard {
    let number: String
    let amount: String
    let image: UIImage?
}

class CardController: UIViewController {

    var screenTitleLabel: UILabel = {
        let v = UILabel()
        v.text = "Starbucks cards"
        v.font = .systemFont(ofSize: 34, weight: .bold)
        v.textColor = #colorLiteral(red: 0.03921568627, green: 0.3411764706, blue: 0.2352941176, alpha: 1)
        return v
    }()
    var tableView = UITableView()

    var cards = [
        StarbucksCard(
            number: "2423983764824166",
            amount: "฿1220.00",
            image: UIImage(named: "232")
        ),
        StarbucksCard(
            number: "1354201763981205",
            amount: "฿1020.00",
            image: UIImage(named: "Seattle")
        )
    ]
    var selectedIndexPath: IndexPath?

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if tableView.superview == nil {
            setupView()
        }
    }

    var topbarHeight: CGFloat {
        return view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
    }

    private func setupView() {
        view.addSubview(screenTitleLabel)
        view.addSubview(tableView)

        screenTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            screenTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            screenTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            tableView.topAnchor.constraint(equalTo: screenTitleLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        navigationController?.navigationBar.isHidden = true
        navigationController?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 190
        tableView.separatorStyle = .none
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: "cardCell")
    }

    func selectedView() -> CardTableViewCell? {
        selectedIndexPath.flatMap { tableView.cellForRow(at: $0) as? CardTableViewCell }
    }
}

extension CardController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardTableViewCell
        cell.updateView(card: cards[indexPath.row])
        return cell
    }
}

extension CardController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let card = cards[indexPath.row]
        selectedIndexPath = indexPath

        let detailViewController = CardDetailViewController()
        detailViewController.card = card
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension CardController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        operation == .push ? CardAnimator() : nil
    }
}
