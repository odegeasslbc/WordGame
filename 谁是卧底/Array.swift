//
//  Array.swift
//  WordGame
//
//  Created by 刘炳辰 on 14/12/22.
//  Copyright (c) 2014年 刘炳辰. All rights reserved.
//

import Foundation

class Array {
    var arrayLength:Int!
    var randomCount:Int
    var array:[Int]!
    var randomNbr1:Int!
    var randomNbr2:Int!
    var randomNbr3:Int!
    
    init(givenNbr:Int,rC:Int){
        arrayLength = givenNbr
        randomCount = rC
        array = [1]
        if randomCount == 2{
            for var i = 1; i<givenNbr; i++ {
                array.append(1)
            }
            getRandom()
            array[randomNbr1] = 0
            array[randomNbr2] = 0
        }else if randomCount == 1{
            for var i = 1; i<givenNbr; i++ {
                array.append(1)
            }
            getRandom()
            array[randomNbr1] = 0
        }else if randomCount == 3{
            for var i = 1; i<givenNbr; i++ {
                array.append(1)
            }
            getRandom()
            array[randomNbr1] = 0
            array[randomNbr2] = 0
            array[randomNbr3] = 0
        }

    }
    
    func getRandom()->(Int,Int,Int){
        
        let t = UInt32(arrayLength)
        let one = arc4random()%t
        var two = arc4random()%t
        var three = arc4random()%t

        while one == two {
            two = arc4random()%t
        }
        while three == one || three == two{
            three = arc4random()%t
        }
        
        randomNbr1 = Int(one)
        randomNbr2 = Int(two)
        randomNbr3 = Int(three)
        
        return (Int(one),Int(two),Int(three))
    }
    
    func getArray() -> [Int]{
        return array
    }
}