//
//  ViewController.swift
//  Vietcombanks
//
//  Created by Boss on 7/9/19.
//  Copyright © 2019 LuyệnĐào. All rights reserved.
//

import UIKit
import InfiniteLayout

extension Notification.Name {
    static let getIndexOfMenu = Notification.Name("GetIndexOfMenu")
    static let getIndexOfPageView = Notification.Name("getIndexOfPageView")
}

class ViewController: UIViewController {
    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet weak var hederCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var menuCollectionView: InfiniteCollectionView!
    @IBOutlet weak var headerCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var menuCollectionViewFlowLayout: InfiniteLayout!
    @IBOutlet weak var backMenu: UIButton!
    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var leadingViewMenu: NSLayoutConstraint!
    
    @IBOutlet weak var menuBackgroundColor: UIView!
    var showing = false {
        didSet{
            UIView.animate(withDuration: 0.35, animations: {
                self.leadingViewMenu.constant = self.showing ? 0 : -self.viewMenu.bounds.width
                self.backMenu.alpha = self.showing ? 1 : 0
                self.view.layoutIfNeeded()
            })
        }
    }
    private let menuCollectionViewCell = "MenuCollectionViewCell"
    private let seguePageViewController = "SeguePageViewController"
    var currentIndex = 0
    var timer: Timer?
    var menuIconList: [UIImage] = [#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "totalSales"),#imageLiteral(resourceName: "menu"),#imageLiteral(resourceName: "settings"),#imageLiteral(resourceName: "search"),#imageLiteral(resourceName: "letter")]
    let maximumDisplayMenuItem: CGFloat = 5
    let headerDatasoure = HeaderDatasoure()
    override func viewDidLoad() {
        super.viewDidLoad()
        headerCollectionView.dataSource = headerDatasoure
        headerCollectionView.delegate = self
        setupMenuCollectionView()
        setupDefaults()
        setupHederView()
        leadingViewMenu.constant = -viewMenu.bounds.width
        view.layoutIfNeeded()
        showing = false
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @IBAction func menuSlide(_ sender: Any) {
        showing = true
    }
    @IBAction func backMenuSlide(_ sender: Any) {
        showing = !showing
    }
    private func setupHederView(){
        let WIDTH_SCREEN = UIScreen.main.bounds.width
        // so item
        let numberOfItems: CGFloat = 1
        // khoang cach giua cac item
        let padding: CGFloat = 0
        let itemSize = (WIDTH_SCREEN - padding * 2 - padding * (numberOfItems - 1)) / numberOfItems
        let flowlayout = headerCollectionView.collectionViewLayout as!UICollectionViewFlowLayout
        flowlayout.itemSize = CGSize(width: itemSize, height: itemSize)
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: 0, bottom: padding, right: 0)
        flowlayout.minimumInteritemSpacing = padding
        flowlayout.minimumLineSpacing = padding
        pageControl.numberOfPages = mybank.count
        startTimer()
        
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @objc func timerAction() {
        let desiredScrollPosition = (currentIndex < mybank.count - 1) ? currentIndex  + 1 : 0
        headerCollectionView.scrollToItem(at: IndexPath(item: desiredScrollPosition, section: 0 ), at: .centeredHorizontally, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = currentIndex
    }
    private func setupDefaults()  {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .getIndexOfPageView, object: nil)
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let selectedIndex = notification.userInfo?["indexs"] as? Int {
            var index = menuIconList.index(after: selectedIndex - 1)
            print(index)
            //        gán số index
            self.menuCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    // Setup menu collectionnView
    private func setupMenuCollectionView() {
        menuCollectionView.register(UINib(nibName: menuCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: menuCollectionViewCell)
        menuCollectionView.dataSource = self
        self.menuCollectionView.isItemPagingEnabled = true
        self.menuCollectionView.infiniteDelegate = self
        self.menuCollectionView.preferredCenteredIndexPath = IndexPath(row: 2, section: 0)
        // Setup layout
        let spacing: CGFloat = 2
        let menuItemSize = (UIScreen.main.bounds.width - spacing * 4) / maximumDisplayMenuItem
        menuCollectionViewFlowLayout.itemSize = CGSize(width: menuItemSize, height: menuCollectionView.bounds.height)
        menuCollectionViewFlowLayout.minimumInteritemSpacing = spacing
        // Set gradient color
        menuBackgroundColor.setGradientBackground(colorTop: .black, colorBottom: .green)
    }
}
// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuIconList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCollectionViewCell , for: indexPath) as? MenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        let index = menuCollectionView.indexPath(from: indexPath)
        cell.imageView.image = menuIconList[index.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
}
extension ViewController: InfiniteCollectionViewDelegate {
    func infiniteCollectionView(_ infiniteCollectionView: InfiniteCollectionView, didChangeCenteredIndexPath centeredIndexPath: IndexPath?) {
        guard let centerIndexPath = centeredIndexPath else { return }
        let indexPath = self.menuCollectionView.indexPath(from: centerIndexPath)
        let userInfo: [AnyHashable: Any] = ["index": indexPath.row]
        NotificationCenter.default.post(name: .getIndexOfMenu, object: nil, userInfo: userInfo)
        
    }
}
var mybank: [Bank] = [
    Bank(image: UIImage(named: "image3-2")!),
    Bank(image: UIImage(named: "image3-2")!),
    Bank(image: UIImage(named: "image3-2")!)
]
class HeaderDatasoure: NSObject, UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mybank.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HeaderCollectionViewCell
        cell.images.image = mybank[indexPath.row].image
        return cell
    }
}
extension UIView {
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}

