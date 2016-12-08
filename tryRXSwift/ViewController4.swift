//
//  ViewController4.swift
//  tryRXSwift
//
//  Created by 清水一貴 on 2016/12/04.
//  Copyright © 2016年 清水一貴. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//mapとかfilterとか、その辺使って見る
class ViewController4: UIViewController {
    @IBOutlet var textField: UITextField!
    @IBOutlet var textFIeld2: UITextField!
    @IBOutlet var button: UIButton!
    var label:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
//        startMapSubscribe()
//        startFilterSubscribed()
//        startTakeSubscribe()
//        startSkipSubscribe()
        startCombineSubscribe()
    }
    
    private func setUpView(){
        label = UILabel(frame: CGRect(x: 100, y: 400, width: 200, height: 40))
        label?.backgroundColor = UIColor.brown
        view.addSubview(label!)
    }

//    文字のバイト数が10以上になった時だけ、subscribeする
    private func startFilterSubscribe(){
        textField.rx.text
            .filter{ ($0?.lengthOfBytes(using: .utf8))! > 10 }
            .subscribe {[weak self] text in
                self?.label?.text = text.element!
        }
    }
    
//    textFieldの入力値に特定の文字列を付け加えて、labelに反映させる
    private func startMapSubscribe(){
        textField.rx.text
            .filter{ $0 != ""}
            .map{ "\($0!)さん、こんにちは！" }
            .subscribe {[weak self] text in
                    self?.label?.text = text.element
        }
    }

//    takeで送信するイベントの回数を制限する
    private func startTakeSubscribe(){
        textField.rx.text
            .take(3)
            .subscribe {[weak self] text in
                self?.label?.text = text.element!
                print("hoge")
        }
    }
    
    //    takeで送信するイベントの回数を制限する
    private func startSkipSubscribe(){
        textField.rx.text
            .skip(10)
            .subscribe {[weak self] text in
                self?.label?.text = text.element!
                print("hoge")
        }
    }

    //    takeで送信するイベントの回数を制限する
    private func startRestrictSubscribe(){
        textField.rx.text
            .skip(10)
            .subscribe {[weak self] text in
                self?.label?.text = text.element!
                print("hoge")
        }
    }
    
//    combineLatestを使って見る
    private func startCombineSubscribe(){
        Observable.combineLatest(textField.rx.text, textFIeld2.rx.text) { text1,text2  in
            return (text1?.characters.count)! + (text2?.characters.count)!
        }
        .subscribe(onNext: { (value) in
            print(value)
        })
        
    }
}
