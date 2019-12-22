//
//  CardAnimator.swift
//  Starbucks
//
//  Created by Supakit Thanadittagorn on 22/12/19.
//  Copyright © 2019 pop. All rights reserved.
//

import UIKit

class CardAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.7
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let fromVC = transitionContext.viewController(forKey: .from) as? CardController,
            let toVC = transitionContext.viewController(forKey: .to) as? CardDetailViewController,
            let cardView = fromVC.selectedView() else { return }

        cardView.alpha = 0

        let fromViewSnapshot = fromVC.view.snapshotView(afterScreenUpdates: true)!
        let cardBackgroundSnapshot = cardView.backgroundImageView.snapshotView(afterScreenUpdates: false)!
        let cardTitleSnapshot = cardView.titleLabel.snapshotView(afterScreenUpdates: false)!
        let cardSubTitleSnapshot = cardView.subTitleLabel.snapshotView(afterScreenUpdates: false)!

        cardBackgroundSnapshot.frame = cardView.convert(cardView.backgroundImageView.frame, to: fromVC.view)
        cardTitleSnapshot.frame = cardView.convert(cardView.titleLabel.frame, to: fromVC.view)
        cardSubTitleSnapshot.frame = cardView.convert(cardView.subTitleLabel.frame, to: fromVC.view)

        containerView.addSubview(fromViewSnapshot)
        containerView.addSubview(cardBackgroundSnapshot)

        let toView: UIView = toVC.view
        toView.layoutIfNeeded()
        toView.alpha = 0
        containerView.addSubview(toView) // Do not forget to add this into containerView before making snapshot

        let gradientSnapshot = toVC.gradientView.snapshotView(afterScreenUpdates: true)!
        gradientSnapshot.frame = fromVC.view.frame
        gradientSnapshot.alpha = 0

        let sheetViewSnapshot = toVC.contentBackgroundView.snapshotView(afterScreenUpdates: true)!
        sheetViewSnapshot.frame = CGRect(
            origin: CGPoint(x: 0, y: fromVC.view.frame.size.height),
            size: toVC.contentBackgroundView.frame.size
        )

        containerView.addSubview(gradientSnapshot)
        containerView.addSubview(cardTitleSnapshot)
        containerView.addSubview(cardSubTitleSnapshot)
        containerView.addSubview(sheetViewSnapshot)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            cardBackgroundSnapshot.frame = toVC.backgroundImageView.frame
            cardTitleSnapshot.frame = self.frame(for: cardTitleSnapshot, usingPositionFrom: toVC.numberLabel)
            cardSubTitleSnapshot.frame = self.frame(for: cardSubTitleSnapshot, usingPositionFrom: toVC.amountLabel)
            sheetViewSnapshot.frame = toVC.contentBackgroundView.frame
            fromViewSnapshot.alpha = 0
            gradientSnapshot.alpha = 1
        }, completion: { _ in
            toView.alpha = 1
            cardView.alpha = 1 // Reset cardView alpha in the fromViewController
            fromViewSnapshot.removeFromSuperview()
            cardBackgroundSnapshot.removeFromSuperview()
            gradientSnapshot.removeFromSuperview()
            cardTitleSnapshot.removeFromSuperview()
            cardSubTitleSnapshot.removeFromSuperview()
            sheetViewSnapshot.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }

    func frame(for l: UIView, usingPositionFrom r: UIView) -> CGRect {
        CGRect(
            origin: CGPoint(
                x: r.frame.origin.x + (r.frame.size.width - l.frame.size.width),
                y: r.frame.origin.y + statusBarFrameHeightFromWindow(for: l)
            ),
            size: l.frame.size
        )
    }

    func frame(for l: UIView, scaleTo r: UIView) -> CGRect {
        let h = r.frame.size.width / l.frame.size.width * l.frame.size.height
        return CGRect(
            origin: CGPoint(x: 0, y: 250 - h),
            size: CGSize(width: r.frame.size.width, height: h)
        )
    }

    func statusBarFrameHeightFromWindow(for view: UIView) -> CGFloat {
        view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
    }
}
