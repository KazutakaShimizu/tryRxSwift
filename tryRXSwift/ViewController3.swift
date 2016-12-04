//
//  ViewController3.swift
//  tryRXSwift
//
//  Created by 清水一貴 on 2016/12/04.
//  Copyright © 2016年 清水一貴. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

//双方向データバインディング
class ViewController3: UIViewController {
    let disposeBag = DisposeBag()
    //    viewmodelを生成
    let viewModle2 = ViewModel2()
    var label = UILabel()
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
//        startChainSubscribe()
        startInteractiveSubscribe()
    }
    
    //    ラベルを生成
    private func setUpView(){
        label = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 40))
        label.backgroundColor = UIColor.blue
        view.addSubview(label)
        textField.text = "hoge"
    }
    
//    textFiledとモデルをバインディングして、textFieldの入力値をモデルに反映させる
//    モデルとラベルをバインディングして、モデルの変更をラベルに反映させる
    private func startChainSubscribe(){
        textField.rx.text
            //            textFieldの変更時にイベントが飛ぶので、それに合わせてsubscribeし処理を走らせる
//            textFieldの入力値をmodelに反映させている
            .subscribe(onNext: { [weak self] text in
                self?.viewModle2.text.value = text!
                print(self?.viewModle2.text.value)
            })
//            モデルとラベルをバインディングして、モデルの値をラベルに反映させている
            viewModle2.text.asObservable().bindTo(label.rx.text)
            //            textFieldとlabelをバインディングし、入力値を直接ラベルに反映させる
            //            .bindTo(label.rx.text)
            .addDisposableTo(disposeBag)
    }
    
//    モデルとtextFieldの入力値を双方向でバインディングし、変更をインタラクティブに反映させる
//    このメソッドの中で双方向バインディングしているため、別のメソッドからmodelの値を変えると、それがtextFieldの入力値に反映させる
    private func startInteractiveSubscribe(){
        textField.rx.text
            .subscribe(onNext: { [weak self] text in
                self?.viewModle2.text.value = text!
                print(self?.viewModle2.text.value)
            })
            viewModle2.text.asObservable().bindTo(textField.rx.text)
            .addDisposableTo(disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch")
        changeVMText()
    }
    
    private func changeVMText(){
        self.viewModle2.text.value = "piyo"
    }
        
}

class ViewModel2 {
    var text: Variable<String> = Variable<String>("hoge")
    //    var text:String! = nil
}
