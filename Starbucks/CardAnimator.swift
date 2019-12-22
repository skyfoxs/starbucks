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
        3
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
        containerView.addSubview(cardTitleSnapshot)
        containerView.addSubview(cardSubTitleSnapshot)

        let toView: UIView = toVC.view
        toView.layoutIfNeeded()

        let gradientSnapshot = toVC.gradientView.snapshotView(afterScreenUpdates: true)!
        let sheetViewSnapshot = toVC.contentBackgroundView.snapshotView(afterScreenUpdates: true)!
        sheetViewSnapshot.frame = CGRect(
            origin: CGPoint(x: 0, y: fromVC.view.frame.size.height),
            size: toVC.contentBackgroundView.frame.size
        )
        toView.alpha = 0
        gradientSnapshot.alpha = 0
        containerView.addSubview(toView)
        containerView.addSubview(gradientSnapshot)
        containerView.addSubview(sheetViewSnapshot)

        UIView.animate(withDuration: 3, animations: {

            cardBackgroundSnapshot.frame = self.frame(for: cardBackgroundSnapshot, scaleTo: toVC.backgroundImageView)
            cardTitleSnapshot.frame = self.frame(for: cardTitleSnapshot, usingPositionFrom: toVC.numberLabel)
            cardSubTitleSnapshot.frame = self.frame(for: cardSubTitleSnapshot, usingPositionFrom: toVC.amountLabel)
            sheetViewSnapshot.frame = toVC.contentBackgroundView.frame
            fromViewSnapshot.alpha = 0
            gradientSnapshot.alpha = 1
        }, completion: { _ in
            toView.alpha = 1
            cardView.alpha = 1
            fromViewSnapshot.removeFromSuperview()
            cardBackgroundSnapshot.removeFromSuperview()
            cardTitleSnapshot.removeFromSuperview()
            cardSubTitleSnapshot.removeFromSuperview()
            sheetViewSnapshot.removeFromSuperview()
            gradientSnapshot.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }

    func frame(for l: UIView, usingPositionFrom r: UIView) -> CGRect {
        CGRect(
            origin: CGPoint(x: r.frame.origin.x, y: r.frame.origin.y + statusBarFrameHeightFromWindow(for: l)),
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

extension UIView {
    /// Replacement of `snapshotView` on iOS 10. Fixes the issue of `snapshotView` returning a blank white screen.
    func snapshotImageView() -> UIImageView? {
        UIGraphicsBeginImageContext(bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        layer.render(in: context)

        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return UIImageView(image: viewImage, highlightedImage: viewImage)
    }
}
