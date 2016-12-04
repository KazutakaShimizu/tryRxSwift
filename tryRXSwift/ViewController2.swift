//
//  ViewController2.swift
//  tryRXSwift
//
//  Created by 清水一貴 on 2016/12/04.
//  Copyright © 2016年 清水一貴. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

//単方向データバインディング
//テキストフィールドの入力値をviewModleのtextに突っ込む
class ViewController2: UIViewController {

    let disposeBag = DisposeBag()
//    viewmodelを生成
    let viewModle = ViewModel()
//    ラベルを生成
    var label = UILabel()
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        startSubscribe()
        
    }
    
//    ラベルを生成
    private func setUpView(){
        label = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 40))
        label.backgroundColor = UIColor.blue
        view.addSubview(label)
    }
    
    
    private func startSubscribe(){
        textField.rx.text
//            textFieldの変更時にイベントが飛ぶので、それに合わせてsubscriceし処理を走らせる
//            .subscribe(onNext: { [weak self] text in
//                self?.viewModle.text = text
//                print(self?.viewModle.text)
//            })            
//            textFieldとlabelをバインディングし、入力値を直接ラベルに反映させる
            .bindTo(label.rx.text)
            .addDisposableTo(disposeBag)
    }
}

class ViewModel {
    var text:String! = nil
}
