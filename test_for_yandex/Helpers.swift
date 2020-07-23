import  UIKit

func getTopController()->UIViewController
{
    var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
    while ((topController?.presentedViewController) != nil) {
        topController = topController?.presentedViewController
    }
    return topController!
}
