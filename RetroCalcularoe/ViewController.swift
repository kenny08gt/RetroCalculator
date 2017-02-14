//
//  ViewController.swift
//  RetroCalcularoe
//
//  Created by LionMane Software on 2/13/17.
//  Copyright © 2017 LionMane Software. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var leftVS = ""
    var rightVS = ""
    var result = ""
    
    @IBOutlet weak var outputLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "btn",ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
    }
    
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividedPressed(sender: AnyObject){
        processOperation(operation: .Divide)
    }
    @IBAction func onMultipluPressed(sender: AnyObject){
        processOperation(operation: .Multiply)
    }
    @IBAction func onAddPressed(sender: AnyObject){
        processOperation(operation: .Add)
    }
    @IBAction func onSubstractPressed(sender: AnyObject){
        processOperation(operation: .Substract)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation)
    }
    
    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
            
            if runningNumber != ""{
                rightVS = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftVS)! * Double(rightVS)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftVS)! / Double(rightVS)!)"
                }else if currentOperation == Operation.Add{
                    result = "\(Double(leftVS)! + Double(rightVS)!)"
                }else if currentOperation == Operation.Substract{
                    result = "\(Double(leftVS)! - Double(rightVS)!)"
                }
                
                leftVS = result
                outputLbl.text = result
            }
            currentOperation = operation
            
        }else{
            leftVS = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
        
    }
    
    @IBAction func ClearBtnPress(_ sender: Any) {
        playSound()
        clearAll()
    }
    
    func clearAll(){
        leftVS = ""
        rightVS = ""
        runningNumber = ""
        currentOperation = .Empty
        outputLbl.text = "0"
        
    }
}

