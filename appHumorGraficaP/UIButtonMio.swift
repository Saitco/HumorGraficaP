//
//  UIButtonMio.swift
//  PINEDO
//
//  Created by Matías Correnti on 17/12/15.
//  Copyright © 2015 Correnti. All rights reserved.
//

import UIKit

@IBDesignable
class UIButtonMio: UIButton {
    
    fileprivate var starShape: CAShapeLayer!
    fileprivate var outerRingShape: CAShapeLayer!
    fileprivate var fillRingShape: CAShapeLayer!
    
    @IBInspectable
    var lineWidth: CGFloat = 1 {
        didSet {
            updateLayerProperties()
        }
    }
    
    @IBInspectable
    var favoriteColor: UIColor = UIColor(hexInt:0xeecd34) {
        didSet {
            updateLayerProperties()
        }
    }
    
    @IBInspectable
    var notFavoriteColor: UIColor = UIColor(hexInt:0x9e9b9b) {
        didSet {
            updateLayerProperties()
        }
    }
    
    @IBInspectable
    var starFavoriteColor: UIColor = UIColor(hexInt:0x9e9b9b) {
        didSet {
            updateLayerProperties()
        }
    }
    
    var isFavorite: Bool = false {
        didSet {
            return self.isFavorite ? favorite() : notFavorite()
        }
    }
    
    fileprivate func updateLayerProperties()
    {
        if fillRingShape != nil
        {
            fillRingShape.fillColor = favoriteColor.cgColor
        }
        
        if outerRingShape != nil
        {
            outerRingShape.lineWidth = lineWidth
            outerRingShape.strokeColor = notFavoriteColor.cgColor
        }
        
        if starShape != nil
        {
            starShape.fillColor = isFavorite ? starFavoriteColor.cgColor : notFavoriteColor.cgColor
        }
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        updateLayerProperties()
    }
    
    
    
    fileprivate func favorite()
    {
        // 1. Star grows
        var starGoUp = CATransform3DIdentity
        starGoUp = CATransform3DScale(starGoUp, 1.5, 1.5, 1.5)
        
        // 2. Star stop growing and starts shrinking
        var starGoDown = CATransform3DIdentity
        starGoDown = CATransform3DScale(starGoDown, 0.01, 0.01, 0.01)
        
        // Configure a keyframe animation with both transforms (grow and shrink)
        let starKeyFrames = CAKeyframeAnimation(keyPath: "transform")
        starKeyFrames.values = [
            NSValue(caTransform3D:CATransform3DIdentity),
            NSValue(caTransform3D:starGoUp),
            NSValue(caTransform3D:starGoDown)
        ]
        starKeyFrames.keyTimes = [0.0,0.4,0.6]
        starKeyFrames.duration = 0.4
        starKeyFrames.beginTime = CACurrentMediaTime() + 0.05
        starKeyFrames.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        // This is VERY important when you're working with relative time, remove and odd things will happen
        starKeyFrames.fillMode =  kCAFillModeBackwards
//        starKeyFrames.setValue(favoriteKey, forKey: starKey)
        
        // Let the notification tell us when it's over
//        starKeyFrames.delegate = self
//        starShape.addAnimation(starKeyFrames, forKey: favoriteKey)
        starShape.transform = starGoDown
        
        // 1. Ring grows
        var grayGoUp = CATransform3DIdentity
        grayGoUp = CATransform3DScale(grayGoUp, 1.5, 1.5, 1.5)
        
        // 2. Ring stop growing and starts shrinking
        var grayGoDown = CATransform3DIdentity
        grayGoDown = CATransform3DScale(grayGoDown, 0.01, 0.01, 0.01)
        
        let outerCircleAnimation = CAKeyframeAnimation(keyPath: "transform")
        outerCircleAnimation.values = [
            NSValue(caTransform3D:CATransform3DIdentity),
            NSValue(caTransform3D:grayGoUp),
            NSValue(caTransform3D:grayGoDown)
        ]
        outerCircleAnimation.keyTimes = [0.0,0.4,0.6]
        outerCircleAnimation.duration = 0.4
        outerCircleAnimation.beginTime = CACurrentMediaTime() + 0.01
        outerCircleAnimation.fillMode =  kCAFillModeBackwards
        outerCircleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        outerRingShape.add(outerCircleAnimation, forKey: "Gray circle Animation")
        outerRingShape.transform = grayGoDown
        
        // 3. Fill Circle grows from Star's center.
        var favoriteFillGrow = CATransform3DIdentity
        favoriteFillGrow = CATransform3DScale(favoriteFillGrow, 1.5, 1.5, 1.5)
        
        // 5. Fill Circle grows until reach the size of step 2 and shrink back to the initial size.
        let fillCircleAnimation = CAKeyframeAnimation(keyPath: "transform")
        
        fillCircleAnimation.values = [
            NSValue(caTransform3D:fillRingShape.transform),
            NSValue(caTransform3D:favoriteFillGrow),
            NSValue(caTransform3D:CATransform3DIdentity)
        ]
        fillCircleAnimation.keyTimes = [0.0,0.4,0.6]
        fillCircleAnimation.duration = 0.4
        fillCircleAnimation.beginTime = CACurrentMediaTime() + 0.22
        fillCircleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        fillCircleAnimation.fillMode =  kCAFillModeBackwards
        
        let favoriteFillOpacity = CABasicAnimation(keyPath: "opacity")
        favoriteFillOpacity.toValue = 1
        favoriteFillOpacity.duration = 1
        favoriteFillOpacity.beginTime = CACurrentMediaTime()
        favoriteFillOpacity.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        favoriteFillOpacity.fillMode =  kCAFillModeBackwards
        
        fillRingShape.add(favoriteFillOpacity, forKey: "Show fill circle")
        fillRingShape.add(fillCircleAnimation, forKey: "fill circle Animation")
        fillRingShape.transform = CATransform3DIdentity
    }
    
    fileprivate func endFavorite()
    {
        // just a helper to run this piece of code with default actions disabled
//        executeWithoutActions {
//            self.starShape.fillColor = self.starFavoriteColor.CGColor
//            self.starShape.opacity = 1
//            self.fillRingShape.opacity = 1
//            self.outerRingShape.transform = CATransform3DIdentity
//            self.outerRingShape.opacity = 0
//        }
        
        // 4. Star grows to it's initial size, and the filling color is changed.
//        let starAnimations = CAAnimationGroup()
        var starGoUp = CATransform3DIdentity
        starGoUp = CATransform3DScale(starGoUp, 2, 2, 2)
        
        let starKeyFrames = CAKeyframeAnimation(keyPath: "transform")
        starKeyFrames.values = [
            NSValue(caTransform3D: starShape.transform),
            NSValue(caTransform3D:starGoUp),
            NSValue(caTransform3D:CATransform3DIdentity)
        ]
        starKeyFrames.keyTimes = [0.0,0.4,0.6]
        starKeyFrames.duration = 0.2
        starKeyFrames.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        starShape.add(starKeyFrames, forKey: nil)
        starShape.transform = CATransform3DIdentity
    }
    
    fileprivate func notFavorite()
    {
        let starFillColor = CABasicAnimation(keyPath: "fillColor")
        starFillColor.toValue = notFavoriteColor.cgColor
        starFillColor.duration = 0.3
        
        let starOpacity = CABasicAnimation(keyPath: "opacity")
        starOpacity.toValue = 0.5
        starOpacity.duration = 0.3
        
        let starGroup = CAAnimationGroup()
        starGroup.animations = [starFillColor, starOpacity]
        
        starShape.add(starGroup, forKey: nil)
        starShape.fillColor = notFavoriteColor.cgColor
        starShape.opacity = 0.5
        
        let fillCircle = CABasicAnimation(keyPath: "opacity")
        fillCircle.toValue = 0
        fillCircle.duration = 0.3
//        fillCircle.setValue(notFavoriteKey, forKey: starKey)
//        fillCircle.delegate = self
        
        fillRingShape.add(fillCircle, forKey: nil)
        fillRingShape.opacity = 0
        
        let outerCircle = CABasicAnimation(keyPath: "opacity")
        outerCircle.toValue = 0.5
        outerCircle.duration = 0.3
        
        outerRingShape.add(outerCircle, forKey: nil)
        outerRingShape.opacity = 0.5
    }
    
    
}
