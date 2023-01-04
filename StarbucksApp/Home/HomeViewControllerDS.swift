//
//  HomeViewControllerDS.swift
//  StarbucksApp
//
//  Created by Kaan Yalçınkaya on 7.09.2022.
//

import UIKit


extension HomeViewController: UIScrollViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Scroll yapıldığında y mesafesini yazdır.
//        let y = scrollView.contentOffset.y
//
//        print(y)
        
        let y = scrollView.contentOffset.y
        let swipingDown = y <= 0
        let shouldSnap = y > 30
        let labelHeight = headerView.greeting.frame.height + 16 // label + spacer (102)
        
        UIView.animate(withDuration: 0.3) {
            self.headerView.greeting.alpha = swipingDown ? 1.0 : 0.0
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            self.headerViewTopConstraint?.constant = shouldSnap ? -labelHeight : 0
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: HomeHeaderViewDelegate

extension HomeViewController: HomeHeaderViewDelegate {
    func didTapHistoryButton(_ sender: HomeHeaderView) {
        let navController = UINavigationController(rootViewController: HistoryViewController())
        present(navController, animated: true)
    }
    
    
}
