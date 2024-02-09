//
//
//  TwitterCloneHarsh
//
//  932 - 15 pro max
//  852 - 15 pro
//  667 - se 3rd
//

import UIKit

let Utils = UtilityManager()

class UtilityManager: NSObject {
    
    var heightOfStatusBar : Int = 500
    
    var myUserIDglobal = ""
    var myImageUrlGlobal = ""
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    public func showAlert(title:String, message: String, view:UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    public func showAlertHandler(title:String, message: String, view:UIViewController,okAction:@escaping ((UIAlertAction) -> Void)) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: okAction))
        view.present(alert, animated: true, completion: nil)
    }
    
    public func showConfirmAlert(title:String, message: String, view:UIViewController,YesAction:@escaping ((UIAlertAction) -> Void),NoAction:@escaping ((UIAlertAction) -> Void)) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: YesAction))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: NoAction))
        view.present(alert, animated: true, completion: nil)
    }
    
    public func postAllNotificationForReloadDownloadData(){
        NotificationCenter.default.post(name: NSNotification.Name(Constants.keyReloadTablUpcoming), object: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name(Constants.keyReloadTablDiscover), object: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name(Constants.keyReloadTablHome), object: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name(Constants.keyReloadTablDownload), object: nil)
    }
    
    
    func showLoader(_ show: Bool, loadingText : String = "") {
         
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return }
        guard let _ = windowScene.windows.last else { return }
        windowScene.keyWindow?.viewWithTag(1200)
        //UIApplication.shared.window[0].viewWithTag(1200)
        let existingView = windowScene.keyWindow?.viewWithTag(1200)
        
        if show {
            if existingView != nil {
                return
            }
            let loadingView =  makeLoadingView(withFrame: UIScreen.main.bounds, loadingText: loadingText)
            loadingView?.tag = 1200
            windowScene.keyWindow?.addSubview(loadingView!)
        } else {
            existingView?.removeFromSuperview()
        }

    }



    func makeLoadingView(withFrame frame: CGRect, loadingText text: String?) -> UIView? {
        let loadingView = UIView(frame: frame)
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        //activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = loadingView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        activityIndicator.tag = 100 // 100 for example

        loadingView.addSubview(activityIndicator)
        if !text!.isEmpty {
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
            let cpoint = CGPoint(x: activityIndicator.frame.origin.x + activityIndicator.frame.size.width / 2, y: activityIndicator.frame.origin.y + 80)
            lbl.center = cpoint
            lbl.textColor = UIColor.white
            lbl.textAlignment = .center
            lbl.text = text
            lbl.tag = 1234
            loadingView.addSubview(lbl)
        }
        return loadingView
    }

     
}
 
