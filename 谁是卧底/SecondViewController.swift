//
//  SecondViewController.swift
//  谁是卧底
//
//  Created by 刘炳辰 on 15/1/7.
//  Copyright (c) 2015年 刘炳辰. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITabBarDelegate {
    //@property(strong,nonatomic) UIViewController *vc
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var fiv:UIViewController!
    
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    //220
    let textLabel = UILabel(frame:CGRectMake(50, 250, 230, 100))
    
    func swipeRight(){
        //self.tabBarController?.presentViewController(fiv, animated: true, completion: {})
        //self.tabBarController?.tabBar.hidden = false
        //self.presentViewController(fiv, animated: true, completion: {})
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func swippedView(sender:UIGestureRecognizer){
        self.tabBarController?.tabBar.hidden = true
    }
    
    func swippedDown(){
        //self.tabBarController?.tabBar.hidden = false
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        print(item)
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.hidden = true
        textLabel.center = CGPointMake(self.view.frame.width/2, self.view.frame.height/2.5)
        
        textLabel.backgroundColor = UIColor.blueColor()
        
        textLabel.alpha = 0.8
        textLabel.textColor = UIColor.yellowColor()
        textLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(textLabel)
        //self.tabBarController?.tabBar.delegate = self
        fiv = storyBoard.instantiateViewControllerWithIdentifier("first") 
        
        swipeUpRec.direction = UISwipeGestureRecognizerDirection.Up
        swipeDownRec.direction = UISwipeGestureRecognizerDirection.Down
        swipeLeftRec.direction = UISwipeGestureRecognizerDirection.Left
        swipeRightRec.direction = UISwipeGestureRecognizerDirection.Right
        
        swipeRightRec.addTarget(self, action: "swipeRight")
        swipeUpRec.addTarget(self,action:"swippedView:")
        swipeDownRec.addTarget(self,action:"swippedDown")
        swipeLeftRec.addTarget(self,action:"swippedView:")
        
        self.view.addGestureRecognizer(swipeRightRec)
        self.view.addGestureRecognizer(swipeLeftRec)
        self.view.addGestureRecognizer(swipeUpRec)
        self.view.addGestureRecognizer(swipeDownRec)
        self.view.alpha = 1.0
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        //println(self.view.bounds)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


