//
//  QuizViewController.swift
//  Quiz
//
//  Created by litech on 2015/02/10.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    //クイズを格納する配列
    var quizArray = [[Any]]()
    
    //正解数
    var correctAnswer: Int = 0
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButtons1: UIButton!
    @IBOutlet var choiceButtons2: UIButton!
    @IBOutlet var choiceButtons3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tmpArray = [[Any]]()
        
        //------------------------ここから下にクイズを書く------------------------//
        tmpArray.append(["旧暦の”睦月”現代の何月？", "1月", "2月", "3月", 1])
        tmpArray.append(["旧暦の”卯月”現代の何月？", "2月", "3月", "4月",2])
        tmpArray.append(["旧暦の”水無月”現代の何月？", "4月", "5月", "6月",3])
        tmpArray.append(["旧暦の”葉月”現代の何月？", "7月", "8月", "9月",2])
        tmpArray.append(["旧暦の”霜月”現代の何月？", "11月", "12月", "1月",1])
        tmpArray.append(["旧暦の”長月”現代の何月？", "9月", "10月", "11月",1])
        tmpArray.append(["旧暦の”神無月”現代の何月？", "8月", "9月", "10月",3])
        tmpArray.append(["旧暦の”皐月”現代の何月？", "4月", "5月", "6月",1])
        tmpArray.append(["旧暦の”如月””現代の何月？", "1月", "2月", "3月",2])
        tmpArray.append(["旧暦の”師走”現代の何月？", "10月", "11月", "12月",3])
        //------------------------ここから上にクイズを書く------------------------//
        
        // 問題をシャッフルしてquizArrayに格納する
        while (tmpArray.count > 0) {
            let index = Int(arc4random_uniform(UInt32(tmpArray.count)))
            quizArray.append(tmpArray[index])
            tmpArray.remove(at: index)
        }
        choiceQuiz()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func choiceQuiz() {
        quizTextView.text = quizArray[0][0] as! String
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        choiceButtons1.setTitle(quizArray[0][1] as? String, for: .normal)
        choiceButtons2.setTitle(quizArray[0][2] as? String, for: .normal)
        choiceButtons3.setTitle(quizArray[0][3] as? String, for: .normal)
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        if quizArray[0][4] as! Int == sender.tag {
            //正解数を増やす
            correctAnswer+=1
        }
        
        quizArray.remove(at: 0)
        //解いた問題数の合計が予め設定していた問題数に達したら結果画面へ
        if quizArray.count == 0 {
            performSegueToResult()
        } else {
            choiceQuiz()
        }
    }
    
    func performSegueToResult() {
        performSegue(withIdentifier: "toResultView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toResultView") {
            
            let resultView = segue.destination as! ResultViewController
            resultView.correctAnswer = self.correctAnswer
        }
    }
    
    
    
}


