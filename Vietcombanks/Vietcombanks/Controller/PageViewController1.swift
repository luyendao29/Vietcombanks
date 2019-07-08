//
//  PageViewController1.swift
//  Vietcombanks
//
//  Created by Boss on 7/9/19.
//  Copyright © 2019 LuyệnĐào. All rights reserved.
//

import UIKit
class PageViewController1: UIPageViewController, UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    var index: Int = 0
    // MARK: - lay tung man hinh
    var subviewcontroller: [UIViewController] = [UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "man2") as! ViewController2 ,
                                                 UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "man6")as! ViewController6 ,
                                                 UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "man4") as! ViewController4,
                                                 UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "man5") as! ViewController5 ,
                                                 UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "man3")as! ViewController3 ,
                                                 UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "man1") as! ViewController1]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefault()
        self.delegate = self
        self.dataSource = self
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private func setupDefault()  {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .getIndexOfMenu, object: nil)
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let selectedIndex = notification.userInfo?["index"] as? Int {
            let index = subviewcontroller.index(after: selectedIndex - 1)
            print(index)
            //xét số index menu băng sô index của pageview
            setViewControllers([subviewcontroller[index]], direction: .forward, animated: false, completion: nil)
        }
    }
    // MARK: - kieu vuot qua
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    // MARK: - dem man hinh
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subviewcontroller.count
    }
    // MARK: - lui man hinh
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = subviewcontroller.index(of: viewController) ?? 0
        let indexs:[AnyHashable: Any] = ["indexs": currentIndex]
        //    xét số index pageview băng sô index của Menu
        NotificationCenter.default.post(name: .getIndexOfPageView, object: nil, userInfo: indexs )
        if currentIndex <= 0{
            return subviewcontroller[currentIndex + 5]
        }
        return subviewcontroller[currentIndex-1]
    }
    //MARK: - tien man hinh
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var currentIndex = subviewcontroller.index(of: viewController) ?? 0
        let indexs:[AnyHashable: Any] = ["indexs": currentIndex]
        NotificationCenter.default.post(name: .getIndexOfPageView, object: nil, userInfo: indexs )
        if currentIndex >= subviewcontroller.count - 1 {
            return subviewcontroller[currentIndex - 5]
        }
        return subviewcontroller[currentIndex + 1]
    }
}
