//
//  ViewController5.swift
//  tryRXSwift
//
//  Created by 清水一貴 on 2016/12/05.
//  Copyright © 2016年 清水一貴. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

//ui周りで使って見る
class ViewController5: UIViewController {
    @IBOutlet var button: UIButton!
    @IBOutlet var textField: UITextField!
    @IBOutlet var validateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
//            self.rxButtonTapped()
//        self.rxRealTimeValidation()
        self.rxKeyboard()
    }
    
//    buttonがタップされた時に処理を走らせる
    private func rxButtonTapped(){
        button.rx.tap
            .subscribe {[weak self] text in
                self?.buttonTapped()
        }
    }
    private func buttonTapped(){
        print("tapped")
    }
    
//    textFieldが空欄なら、labelにvalidateという文字を入れる
    private func rxRealTimeValidation(){
        textField.rx.text
            .subscribe{[weak self] text in
                guard let text = text.element else{ return }
                if text! == "" {
                    self?.validateLabel.text = "validate"
                }else{
                    self?.validateLabel.text = ""
                }
        }
    }
    
    private func rxKeyboard(){
        NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillShow)
            .subscribe { [weak self] event in
                print("keyboard \(event)")
        }
    }
}

extension ViewController5{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
}
