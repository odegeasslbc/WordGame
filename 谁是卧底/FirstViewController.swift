//
//  FirstViewController.swift
//  谁是卧底
//
//  Created by 刘炳辰 on 15/1/7.
//  Copyright (c) 2015年 刘炳辰. All rights reserved.
//

import UIKit
import QuartzCore

class FirstViewController: UIViewController {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var sec:SecondViewController! = SecondViewController()
    //let startButton = UILabel(frame:CGRectMake(110, 250, 200, 100))
    var arrayLength:Int!
    var array:[Int]!
    var randomCount:Int!
    var restNbr:Int!
    var restDNbr:Int!
    var index:UInt32!
    var restPeopleLabel:UILabel!
    var restDifferent: UILabel!
    //var checkedLabel:UILabel!
    var checkedText = "已死玩家："
    var checkedArray:[Int]!
    //let backgroundImg = UIImageView()
    var whiteOne = 100
    var start = false
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var newbu: UIButton!
    
    @IBAction func newbutton(sender: AnyObject) {
        
    }
    
    
    @IBAction func whiteBlank(sender: AnyObject) {
        let alert = SCLAlertView()

        if start == true{
            alert.showWarning("no way", subTitle: "the game has been started", closeButtonTitle: "OK")
        }else if whiteOne == 100{
            alert.addButton("YES"){
                var tmp = arc4random()%UInt32(self.arrayLength)
                var t = Int(tmp)
                
                if self.array[t] == 0{
                    tmp += 1
                }
                self.whiteOne = Int(tmp)
                println(self.whiteOne)
            }
            alert.showError("sure?", subTitle: "you are going to add a white guy", closeButtonTitle: "NO", duration: 2)
        }else{
            alert.showWarning("no way", subTitle: "there has been a white guy", closeButtonTitle: "OK")
        }
    }
    
    @IBAction func restart(sender: AnyObject) {
        let alert = SCLAlertView()
        alert.addButton("Yes"){UIView.animateWithDuration(0.5, animations: {self.view.alpha=0.1}, completion: { finished in
            self.loadView()
        })}
        alert.showError("Restart", subTitle: "are you sure?", closeButtonTitle: "No")
        //关闭view再显示的动画效果
        
    }
    @IBAction func setting(sender: AnyObject) {
        let alert = SCLAlertView()
        let txtPeople = alert.addTextField(title:"Enter the people count")
        txtPeople.keyboardType = UIKeyboardType.NumberPad
        let txtRandom = alert.addTextField(title:"Enter the different count")
        txtRandom.keyboardType = UIKeyboardType.NumberPad
        alert.addButton("OK") {
            if txtPeople.text.toInt() > 2{
                self.arrayLength = txtPeople.text.toInt()
            }
            
            if txtRandom.text.toInt() < 4{
                self.randomCount = txtRandom.text.toInt()
            }
            
            UIView.animateWithDuration(0.5, animations: {self.view.alpha=0.1}, completion: { finished in
                self.loadView()
            })
        }
        alert.showEdit("设置", subTitle:"设置玩家人数和卧底人数", closeButtonTitle:"Cancle")
        
    }
    @IBAction func check(sender: AnyObject) {
        let alert = SCLAlertView()
        let different = alert.addTextField(title:"Enter the digi")
        different.keyboardType = UIKeyboardType.NumberPad
        alert.addButton("Sure"){
            if var t = different.text.toInt()
            {
                if self.whetherChecked(t) == true {
                    let newAlert = SCLAlertView()
                    newAlert.showWarning("重复了", subTitle:"这货已经被干掉了,请重新输入" )
                    //alert.showError(self, title:"重复了", subTitle:"这货已经被干掉了,请重新输入一个", closeButtonTitle:"Cancle")
                    
                }
                else{
                    let i = t - 1
                    if i > self.arrayLength {
                        let newAlert = SCLAlertView()
                        newAlert.showWarning("数字过大", subTitle:"你输的数字比玩家总数还大！" )
                    }else if i == self.whiteOne {
                        let newAlert = SCLAlertView()
                        newAlert.showWarning("猜对了",subTitle:"一个白板被揪出来了！")
                        self.restNbr = self.restNbr - 1
                        self.restPeopleLabel.text = "剩余总数：\(self.restNbr)"
                        self.view.viewWithTag(t)!.backgroundColor = UIColor.purpleColor()
                        self.checkedArray.append(t)
                    }else{
                        if self.array[i] == 0{
                            
                            self.restDNbr = self.restDNbr - 1
                            self.restNbr = self.restNbr - 1
                            
                            if self.restDNbr == 0{
                                let newAlert = SCLAlertView()
                                newAlert.addButton("重新开始"){
                                    UIView.animateWithDuration(0.5, animations: {self.view.alpha=0.1}, completion: { finished in
                                        self.loadView()
                                    })
                                }
                                newAlert.showInfo("群众胜利", subTitle:"卧底都被干掉了" )
                            }else{
                                let newAlert = SCLAlertView()
                                newAlert.showWarning("猜对了", subTitle:"一个卧底被干死了！" )
                                //根据tag找到相应view
                                self.view.viewWithTag(t)!.backgroundColor = UIColor.purpleColor()
                            }
                            
                            self.restPeopleLabel.text = "剩余总数：\(self.restNbr)"
                            self.restDifferent.text = "剩余卧底：\(self.restDNbr)"
                            
                        }else{
                            let newAlert = SCLAlertView()
                            newAlert.showSuccess("平民被杀", subTitle:"可怜的平民啊" )
                            self.view.viewWithTag(t)!.backgroundColor = UIColor.redColor()
                            
                            self.restNbr = self.restNbr - 1
                            
                            self.restPeopleLabel.text = "剩余总数：\(self.restNbr)"
                            self.restDifferent.text = "剩余卧底：\(self.restDNbr)"
                            
                            if self.restNbr == self.restDNbr{
                                let newAlert = SCLAlertView()
                                newAlert.addButton("重新开始"){
                                    UIView.animateWithDuration(0.5, animations: {self.view.alpha=0.1}, completion: { finished in
                                        self.loadView()
                                    })
                                }
                                newAlert.showError("卧底胜利", subTitle:"卧底就是屌" )
                            }
                        }
                        self.checkedArray.append(t)
                        self.checkedText += "\(t)、 "
                        //self.checkedLabel.text = self.checkedText
                    }
                }
            }
        }
        alert.showError("find out", subTitle:"the different one", closeButtonTitle:"Cancle")
    }
    
    //check wheather the number have been checked
    func whetherChecked(number:Int) -> Bool{
        for tmp in self.checkedArray{
            if number == tmp{
                return true
            }
        }
        return false
    }
    
    func tapped(sender:UIGestureRecognizer){
        sender.view!.backgroundColor = UIColor.blueColor()
        sender.view!.userInteractionEnabled = false
        let blank = self.view.frame.height/CGFloat(arrayLength)
        let height = blank - 20
        
        for i in 0..<arrayLength{
            //use tmp,tmp1,tmp2 to caculate the number of the card
            let tmp1 =  blank * CGFloat(i+1)
            let tmp2 = height/2
            let tmp = tmp1 - tmp2
            let flag = sender.view!.center.y - tmp
            //println(tmp)
            if -1 < flag && flag < 1{
                var text = ""
                if array[i] == 0{
                    text = word1[Int(index)]!
                }else if i == whiteOne{
                    text = "自己想个词吧，哈哈"
                }else{
                    text = word2[Int(index)]!
                }
                sec.textLabel.text =  text
                sec.textLabel.font = UIFont.systemFontOfSize(20)
                self.presentViewController(sec, animated: true, completion: {})
            }
        }
        
        //once tapped,indicates that the game has been started
        self.start = true
    }
    
    func createNewLabel(i:Int){
        let blank = self.view.frame.height/CGFloat(arrayLength)
        let y = CGFloat(i) * blank + 20
        let height = blank - 20
        
        let newLabel = UILabel(frame:CGRectMake(40, y, self.view.frame.width/2.5, height))
        newLabel.text = "\(i+1)"
        newLabel.backgroundColor = UIColor.yellowColor()
        newLabel.textAlignment = NSTextAlignment.Center
        newLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: "tapped:")
        newLabel.alpha = 0.6
        newLabel.addGestureRecognizer(tapRec)
        newLabel.userInteractionEnabled = true
        newLabel.tag = i+1
        self.view.addSubview(newLabel)
        
        //UILabel动画
        UILabel.beginAnimations("animationID", context: nil)
        UILabel.setAnimationDuration(1)
        UILabel.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        var moveTransform1:CGAffineTransform = CGAffineTransformMakeRotation(0)
        
        var moveTransform2:CGAffineTransform = CGAffineTransformTranslate(moveTransform1, 0, 0)
        newLabel.layer.setAffineTransform(moveTransform2)
        
        UILabel.commitAnimations()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*        let timmer:NSTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target:self, selector:"createNewLabel:", userInfo:nil, repeats:true)
        timmer.fire()
        */
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func loadView() {
        super.loadView()
        
        self.tabBarController?.tabBar.hidden = true
        
        self.start = false
        whiteOne = 100
        
        checkedArray = [0]
        checkedText = "已死玩家："
        
        if arrayLength == nil{
            arrayLength = 6
        }
        if randomCount == nil{
            randomCount = 1
        }
        
        restNbr = arrayLength
        restDNbr = randomCount
        
        /*
        restPeopleLabel =  UILabel(frame:CGRectMake(280, 180, 100, 50))
        restPeopleLabel.text = "剩余总：\(restNbr)"
        self.view.addSubview(restPeopleLabel)
        
        restDifferent = UILabel(frame:CGRectMake(280, 250, 100, 50))
        restDifferent.text = "\(restDNbr)"
        self.view.addSubview(restDifferent)
        */
        let arrayCreator = Array(givenNbr:arrayLength,rC:randomCount)
        array = arrayCreator.getArray()
        
        println(array)
        
        index = arc4random()%40 + 1
        
        restPeopleLabel =  UILabel(frame:CGRectMake(self.view.frame.width/1.5, self.view.frame.height/7, 120, 50))
        restPeopleLabel.text = "    剩余：\(restNbr)"
        restPeopleLabel.backgroundColor = UIColor(red: 0, green: 255, blue: 255, alpha: 0.6)
        //restPeopleLabel.layer.cornerRadius = 20;
        restPeopleLabel.textAlignment = NSTextAlignment.Left
        restPeopleLabel.font = UIFont(name:"System Bold",size:14)
        self.view.addSubview(restPeopleLabel)
        
        restDifferent = UILabel(frame:CGRectMake(self.view.frame.width/1.5, self.view.frame.height/3.5, 120, 50))
        restDifferent.text = "    卧底：\(restDNbr)"
        restDifferent.backgroundColor = UIColor(red: 0, green: 255, blue: 255, alpha: 0.6)
        restDifferent.textAlignment = NSTextAlignment.Left
        self.view.addSubview(restDifferent)
        
        self.view.sendSubviewToBack(imageView)
        
        for i in 0..<arrayLength {
            self.createNewLabel(i)
        }
        
        
        /*
        checkedLabel = UILabel(frame:CGRectMake(280, 320, 120, 50))
        checkedLabel.text = checkedText
        //checkedLabel.
        var textFont = UIFont(name: "", size : 11)
        
        
        checkedLabel.font = textFont
        checkedLabel.numberOfLines = 5
        self.view.addSubview(checkedLabel)
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}