//
//  OnBoardingViewController.swift
//  Dodo
//
//  Created by Galih Asmarandaru on 30/08/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//


import UIKit

class OnBoardingViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }

    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides:[Slide] = [];
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createSlides() -> [Slide] {
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "First Onboarding")
        slide1.descriptionView.textColor = .black
        slide1.descriptionView.text = "ReCall is an app that aims to delay memory loss through brain and physcial exercises. Each day, you will be given a random brain exercise and a physical exercise."
        
        
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "Anjing Timbangan")
        slide2.descriptionView.text = "ReCall keeps your mind active through brain exercises that focus on 3 main aspects: memory, speed, and attention."
        slide2.descriptionView.textColor = .black
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "Blood Hero")
        slide3.descriptionView.text = "ReCall keeps your body active through physical exercises that you can simply follow along."
        slide3.descriptionView.textColor = .black
        
        return [slide1, slide2, slide3]
        
//        if slide1.isHidden && slide2.isHidden {
//            buttonView.isHidden = false
//        }
    }
    
    func setupSlideScrollView(slides: [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x:view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            slides[i].backgroundColor = .white
            scrollView.addSubview(slides[i])
            
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        /*
         * below code changes the background color of view on paging the scrollview
         */
        //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        
        
        /*
         * below code scales the imageview on paging the scrollview
         */
        
        
//        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
//
//        if(percentOffset.x > 0 && percentOffset.x <= 0.66) {
//
//            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.66-percentOffset.x)/0.33, y: (0.66-percentOffset.x)/0.33)
//            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.66, y: percentOffset.x/0.66)
//
//        } else if(percentOffset.x > 0.66 && percentOffset.x <= 1) {
//            slides[1].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.33, y: (1-percentOffset.x)/0.33)
//            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
//
//        }
        
//        else if(percentOffset.x > 0.66 && percentOffset.x <= 1) {
//            slides[2].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.33, y: (1-percentOffset.x)/0.33)
//            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
//
//
//        }
        
    }
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if(pageControl.currentPage == 0) {
            //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
            //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
            //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1
            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.pageIndicatorTintColor = pageUnselectedColor
            
            
            let bgColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            //                fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            slides[pageControl.currentPage].backgroundColor = bgColor
            
            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.currentPageIndicatorTintColor = pageSelectedColor
        }
    }
    
    
    func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {
        
        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
        
        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    
}

