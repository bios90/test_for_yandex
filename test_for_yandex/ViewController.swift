//
//  ViewController.swift
//  test_for_yandex
//
//  Created by Филипп Бесядовский on 23.07.2020.
//  Copyright © 2020 dimfcompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let btn_make_payment:UIButton =
    {
        let btn = UIButton()
        btn.setTitleColor(.gray, for: .normal)
        btn.setTitle("Make Payment", for: .normal)
        btn.layer.cornerRadius = 4
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.borderWidth = 1
        return btn
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews()
    {
        self.view.backgroundColor = .white
        self.view.addSubview(btn_make_payment)
        btn_make_payment.translatesAutoresizingMaskIntoConstraints = false
        
        btn_make_payment.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btn_make_payment.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        btn_make_payment.widthAnchor.constraint(equalToConstant: 256).isActive = true
        btn_make_payment.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        btn_make_payment.addTarget(self, action: #selector(clicked_make_payment), for: .touchUpInside)

        
    }

    @objc func clicked_make_payment(_ sender: Any)
    {
        PaymentManager.getInstance.makePayment(payment_methods: .all, success_action:
            { token, method_type in
                
        }, error_action:
            { err in
                
        })
    }
}

