//
//  ViewController.swift
//  tryRXSwift
//
//  Created by 清水一貴 on 2016/12/02.
//  Copyright © 2016年 清水一貴. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//delegateっぽく使う
class ViewController1: UIViewController {
//    イベント購読を解除するdisposeを生成
    let disposeBag = DisposeBag()
//    通知元のクラスを生成
    var sampleView = SampleView()
    override func viewDidLoad() {
        configureView()
//        sampleViewの中のeventからイベントの購読を開始
        sampleView.event.subscribe(onNext: { value in
            print(value)
        }).addDisposableTo(disposeBag)
    }
    
    private func configureView(){
        sampleView.frame = CGRect(x: 100, y: 400, width: 200, height: 200)
        sampleView.backgroundColor = UIColor.red
        self.view.addSubview(sampleView)
    }
}

//uiviewをタップした時に、イベントを送信する
class SampleView: UIView {
//    イベントを送信するsubjectを生成。外から直接参照できないようにprivateで宣言する。subjectはObservableでもある
    private let eventSubject = PublishSubject<Int>()
//    外からsubjectを取得するために、subjectを返す変数を作る。カプセル化
    var event: Observable<Int>{ return eventSubject }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sendEvent()
    }
    
//    イベントと一緒に値を送信
    func sendEvent(){
        eventSubject.onNext(123456)
    }
}
