//
//  ViewController.swift
//  Polling
//
//  Created by 何晓文 on 2017/6/2.
//  Copyright © 2017年 何晓文. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //停止标记
    fileprivate var flag : Int = 0
    //懒加载线程对象 创建一个子线程
    lazy var myThread : Thread = {
        let myThread = Thread {
            let timer = Timer(timeInterval: 2, target: self, selector: #selector(self.requestTask), userInfo: nil, repeats: true)
            let runloop = RunLoop.current
            runloop.add(timer, forMode: .commonModes)
            runloop.run()
            
        }
        
        
        return myThread
    }()
   
    //创建timer
    lazy var gcdTimer : DispatchSourceTimer = {
        let gcdTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        
        gcdTimer.setEventHandler(handler: {
            
            self.requestTask()
            
        })
        //设置触发时间 和间隔
        gcdTimer.scheduleRepeating(deadline: .now(), interval: 1)
        
        return gcdTimer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //开启线程
//        myThread.start()
        
        
       
        
      //GCD Timer
        gcdTimer.resume()
        
        
        
        
    }
    //轮询请求
    func requestTask(){
        print(flag);
        flag += 1
        if flag == 10 {
//            Thread.exit()
           gcdTimer.cancel()
            print("结束任务")
        }
        
        
    }


}





