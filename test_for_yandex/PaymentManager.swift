import Foundation
import YandexCheckoutPayments
import YandexCheckoutPaymentsApi


class PaymentManager:NSObject
{
    static let getInstance = PaymentManager()
    var success_action:((String,PaymentMethodType)->())?
    var error_action:((YandexCheckoutPaymentsError?)->())?
    var action_3d_secure:(()->())?
    var payment_vc:TokenizationModuleInput?
    
    func makePayment(payment_methods:PaymentMethodTypes,success_action:@escaping (String,PaymentMethodType)->(),error_action:@escaping (YandexCheckoutPaymentsError?)->())
    {
        self.success_action = success_action
        self.error_action = error_action
        
        let key = Constants.Payments.API_KEY
        let amount = Amount(value: 10, currency: .rub)
        let title = "Test payment"
        let text = "Test payment for yandex team"
        
        let settings = TokenizationSettings(paymentMethodTypes:payment_methods , showYandexCheckoutLogo: true)
        let tokenizationData = TokenizationModuleInputData(clientApplicationKey: key, shopName: title, purchaseDescription: text, amount: amount, tokenizationSettings: settings,savePaymentMethod: .userSelects)
        let inputData: TokenizationFlow = .tokenization(tokenizationData)
        let viewController = TokenizationAssembly.makeModule(inputData: inputData,moduleOutput: self)
        let top_vc = getTopController()
        top_vc.present(viewController, animated: true, completion: nil)
        self.payment_vc = viewController
    }
    
    func show3dSecure(url:String,action_3d_secure:(()->())?)
    {
        guard let secureVc = self.payment_vc else
        {
            return
        }
        self.action_3d_secure = action_3d_secure
        secureVc.start3dsProcess(requestUrl: url)
    }
    
    func dismissPaymentController()
    {
        
        if let payment_vc = self.payment_vc,let vc = payment_vc as? UIViewController
        {
            vc.dismiss(animated: false, completion: nil)
        }
    }
}

extension PaymentManager:TokenizationModuleOutput
{
    
    func didFinish(on module: TokenizationModuleInput, with error: YandexCheckoutPaymentsError?)
    {
        (self.payment_vc as! UIViewController).dismiss(animated: true, completion: nil)
        DispatchQueue.main.async
            { [weak self] in
            
                self?.error_action?(error)
                self?.error_action = nil
        }
    }
    
    func didSuccessfullyPassedCardSec(on module: TokenizationModuleInput)
    {
        DispatchQueue.main.async
            { [weak self] in
                self?.action_3d_secure?()
                self?.action_3d_secure = nil
        }
    }
    
    func tokenizationModule(_ module: TokenizationModuleInput, didTokenize token: Tokens, paymentMethodType: PaymentMethodType)
    {
        DispatchQueue.main.async
            { [weak self] in
                
                let token_text = token.paymentToken
                self?.success_action?(token_text,paymentMethodType)
                self?.success_action = nil
        }
    }
}
