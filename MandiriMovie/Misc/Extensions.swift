//
//  Extensions.swift
//  MandiriMovie
//
//  Created by Marcelino Budiman on 22/07/23.
//

import Foundation
import UIKit

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let query = URLQueryItem(name: queryItem, value: value)
        queryItems.append(query)
        urlComponents.queryItems = queryItems

        return urlComponents.url!
    }
    
}

extension UIView{

    func showLoader(_ color:UIColor?){
        let LoaderView  = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        LoaderView.tag = 999999
        LoaderView.backgroundColor = color
        let Loader = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        Loader.center = LoaderView.center
        Loader.style = UIActivityIndicatorView.Style.large
        Loader.color = UIColor.secondaryLabel
        Loader.startAnimating()
        LoaderView.addSubview(Loader)
        self.addSubview(LoaderView)
    }

    func dismissLoader(){
        self.viewWithTag(999999)?.removeFromSuperview()
    }
    
    func createSpinnerFooter(view: UIView) -> UIView {
        let footerView = UIView( frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
}
