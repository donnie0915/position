//
//  ViewController.swift
//  position
//
//  Created by donnie on 14-6-28.
//  Copyright (c) 2014年 donnie. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate{
    
    @IBOutlet var showPosition : UILabel
    @IBOutlet var showError : UILabel
    
    let locationManager:CLLocationManager = CLLocationManager() ///初始化定位器
    let geocoder:CLGeocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self //设置代理
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //设置精确度
        
        let singleFingerTap = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        self.view.addGestureRecognizer(singleFingerTap)
        
        if ( ios8() ) {
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startUpdatingLocation()   //开启位置更新
        
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        println("handleSingleTap....")
        locationManager.startUpdatingLocation()     //开启位置更新
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ios8() -> Bool {
        println("iOS " + UIDevice.currentDevice().systemVersion)
        // There is a problem if Apple upgrades iOS version to 8.1 or something else.
        if ( UIDevice.currentDevice().systemVersion == "8.0" ) {
            return true
        } else {
            return false
        }
    }
    
    
    func completionHandler(placemarks: AnyObject[]!, error: NSError!) -> Void {
        println("completionHandler...\(placemarks.count )")
        
        var address=""
        var placemark:CLPlacemark = placemarks[0] as CLPlacemark
        if(placemark.addressDictionary.objectForKey("State") != nil){
            var state:String = placemark.addressDictionary.objectForKey("State") as String
            println(" state : "+state)
        }
        if(placemark.name != nil ){
            println(" name :" + placemark.name)
        }
        if(placemark.thoroughfare != nil ){
            println(" thoroughfare :" + placemark.thoroughfare)
        }
        if(placemark.subThoroughfare != nil ){
            println(" subThoroughfare :" + placemark.subThoroughfare)
        }
        if(placemark.locality != nil ){
            println(" locality :" + placemark.locality)
            self.showPosition.text="你所在的城市 : "+placemark.locality
        }
        if(placemark.subLocality != nil ){
            println(" subLocality :" + placemark.subLocality)
        }
        if(placemark.administrativeArea != nil ){
            println(" administrativeArea :" + placemark.administrativeArea)
            
        }
        if(placemark.subAdministrativeArea != nil ){
            println(" subAdministrativeArea :" + placemark.subAdministrativeArea)
        }
        if(placemark.postalCode != nil ){
            println(" postalCode :" + placemark.postalCode)
        }
        if(placemark.ISOcountryCode != nil ){
            println(" ISOcountryCode :" + placemark.ISOcountryCode)
        }
        if(placemark.country != nil ){
            println(" country :" + placemark.country)
        }
        if(placemark.inlandWater != nil ){
            println(" inlandWater :" + placemark.inlandWater)
        }
        if(placemark.ocean != nil ){
            println(" ocean :" + placemark.ocean)
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!) {
        println("locationManager ...")
        var location:CLLocation = locations[locations.count-1] as CLLocation
        
        println("location.description : "+location.description)
//        var latitude = location.coordinate.latitude
        
        if (location.horizontalAccuracy > 0) {
            self.locationManager.stopUpdatingLocation()
         
            geocoder.reverseGeocodeLocation(location, completionHandler)
        }
    }
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        self.locationManager.stopUpdatingLocation()
        println(error)
        self.showError.text="获取地址失败"
    }
    
    
    
}

