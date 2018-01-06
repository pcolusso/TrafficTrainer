//Lifted from https://stackoverflow.com/questions/18398796/uipageviewcontroller-and-storyboard
//Courtesy of https://stackoverflow.com/users/294884/fattie

import UIKit

class IntroPages: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        let p1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "page1")
        let p2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "page2")
        let p3: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "page3")
        
        // etc ...
        
        pages.append(p1)
        pages.append(p2)
        pages.append(p3)
        
        // etc ...
        
        setViewControllers([p1], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController)-> UIViewController? {
        
        let cur = pages.index(of: viewController)!
        
        // if you prefer to NOT scroll circularly, simply add here:
         if cur == 0 { return nil }
        
        let prev = abs((cur - 1) % pages.count)
        return pages[prev]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController)-> UIViewController? {
        
        let cur = pages.index(of: viewController)!
        
        // if you prefer to NOT scroll circularly, simply add here:
         if cur == (pages.count - 1) { return nil }
        
        let nxt = abs((cur + 1) % pages.count)
        return pages[nxt]
    }
    
    func presentationIndex(for pageViewController: UIPageViewController)-> Int {
        return pages.count
    }
}
