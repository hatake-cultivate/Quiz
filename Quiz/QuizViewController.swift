//
//  QuizViewController.swift
//  Quiz
//
//  Created by ohtatomotaka on 2015/02/10.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    //出題数
    var questionNumber:Int = 5
    
    //現在の問題数
    var sum:Int = 0
    
    //正解数
    var correctAnswer:Int = 0
    
    //乱数
    var random:Int = 0
    
    //クイズを格納する配列
    var quizArray = [NSMutableArray]()
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButtons: Array<UIButton>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //------------------------ここから下にクイズを書く------------------------//
        quizArray.append(["分シフォールドがよくわかるモデルはどれか？","リボンモデル","空間充填モデル","stick&ball",1])
        quizArray.append(["半手動で分類されたタンパク質2次DBはどれか？","SCOP","CATH","FSSP",2])
        quizArray.append(["DSSPで2次構造を同定するのに重要なものはどれか？","二面角φΨ","側鎖の水素結合","結合長",1])
        quizArray.append(["X線構造解析で位相を決めるものではない方法はどれか？","重原子置換法","多波長異常分散","フーリエ変換で位相計算",3])
        quizArray.append(["Evolutionary Trace法においてTRではないものはどれか？","conserned","class-specific","newtral",3])
        quizArray.append(["進化における構造変化機構でないものはどれか？","円循環変異","ドメインスワッピング","会合　",3])
        //------------------------ここから下にクイズを書く------------------------//
        choiceQuiz()
    }
    
    func choiceQuiz() {
        print(quizArray.count)
        //クイズの問題文をシャッフルしてTextViewにセット
        random = Int(arc4random_uniform(UInt32(quizArray.count)))
        quizTextView.text = quizArray[random][0] as! NSString as String
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        for var i = 0; i < choiceButtons.count; i++ {
            choiceButtons[i].setTitle(quizArray[random][i+1] as! String , forState: .Normal)
            //どのボタンが押されたか判別するためのtagをセット
            choiceButtons[i].tag = i + 1;
        }
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        sum++
        print("random \(random)")
        if quizArray[random][4] as! Int == sender.tag {
            //正解数を増やす
            correctAnswer++
        }
        
        //解いた問題数の合計が予め設定していた問題数に達したら結果画面へ
        if sum == questionNumber {
            performSegueToResult()
        } else {
            quizArray.removeAtIndex(random)
            choiceQuiz()
        }
    }
    
    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toResultView") {
            
            let ResultView : ResultViewController = segue.destinationViewController as! ResultViewController

            ResultView.correctAnswer = self.correctAnswer
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


