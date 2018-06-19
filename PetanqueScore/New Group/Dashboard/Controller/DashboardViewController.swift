//
//  DashboardViewController.swift
//  PetanqueScore
//
//  Created by Benjamin_Budet on 17/04/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit
import JavaScriptCore
import WebKit
import CoreLocation

class DashboardViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var newGameOutlet: UIButton!
    @IBOutlet weak var profilesButtonOutlet: UIButton!
    var wkWebView: WKWebView!
    let locationManager = CLLocationManager()
    var longit: Double = 0.0
    var latit: Double = 0.0
    var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        profilesButtonOutlet.layer.cornerRadius = 10
        profilesButtonOutlet.layer.borderWidth = 1

        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        newGameOutlet.layer.cornerRadius = 10
        newGameOutlet.layer.borderWidth = 1
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            longit = (locationManager.location?.coordinate.latitude)!
            latit = (locationManager.location?.coordinate.longitude)!
        }
        
        wkWebView = WKWebView(frame: CGRect(x: 0, y: self.view.frame.size.height - 50, width: self.view.frame.width, height: 50)
, configuration: WKWebViewConfiguration())
        wkWebView.uiDelegate = self
        wkWebView.navigationDelegate = self
        view.addSubview(wkWebView!)
        let scriptSource = "document.body.innerHTML = `Latitude: \(latit) Longitude \(longit)`;"

        let jsScript = "var x = document.body; function getLocation() { if (navigator.geolocation) { navigator.geolocation.getCurrentPosition(showPosition); } else { x.innerHTML = `Geolocation is not supported by this browser.`; } } function showPosition(position) { x.innerHTML = `Latitude: ` + position.coords.latitude + `<br>Longitude: ` + position.coords.longitude; }"
        wkWebView.evaluateJavaScript(scriptSource, completionHandler: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        games = NSCodingData.GetGames() ?? []
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fjpjpActionClicked(_ sender: Any) {

        UIApplication.shared.open(URL(string : "https://www.ffpjp.org/")!, options: [:], completionHandler: nil)
    }

    @IBAction func cd29ActionClicked(_ sender: Any) {
            UIApplication.shared.open(URL(string : "http://www.petanque-finistere.fr/")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func boulistenauteActionClicked(_ sender: Any) {
            UIApplication.shared.open(URL(string : "http://www.boulistenaute.com/")!, options: [:], completionHandler: nil)
    }
    
    func webView(_ webView: WKWebView,
                 runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let title = NSLocalizedString("OK", comment: "OK Button")
        let ok = UIAlertAction(title: title, style: .default) { (action: UIAlertAction) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true)
        completionHandler()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        wkWebView.evaluateJavaScript("alert('Hello from evaluateJavascript()')", completionHandler: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
