//
//  ContentView.swift
//  iphone calculator
//
//  Created by StudentPM on 3/10/25.
//

import SwiftUI

struct ContentView: View {
    @State var leftNum: String = ""
    @State var rightNum: String = ""
    @State var oper: String = ""
    @State private var numsAndOperations: [[String]] = [
        ["AC","+/-", "%", "÷"],
        ["7","8", "9", "x"],
        ["4","5", "6", "-"],
        ["1","2", "3", "+"],
        ["0", " . " , "="]
    ]
    @State private var screenNumber: String = "0"
    @State private var text: [String] = ["AC","7","4","1"]
    
    var body: some View {
        VStack{
            Color.black.ignoresSafeArea()
            HStack{
                Spacer()
                
                Text("\(screenNumber)")
                    .font(.system(size: 80))
                    .padding()
                    .foregroundColor(.white)
                
            }
            
            
            ForEach(numsAndOperations, id: \.self){ word in
                HStack{
                    ForEach(word, id:\.self){ item in
                        ButtonsView(cardText: item, doSomething: {handleClick(text: item)})
                    }
                }
            }
        }
        .background(.black)
        
    }
    
    var currentInput = ""
    
    func handleClick(text: String){
//        screenNumber = text
        //variable need to add here to hold the button in
        if text == "AC" || text == "+/-" || text == "%"{
            if text == "AC"{
                screenNumber = "0"
            }
            else if text == "+/-"{
                
                        //6                "6"
                if let currentVal = Int(screenNumber) {
                        //"-6"                    //-6
                    screenNumber = String(-currentVal)
                }
                
            }
            else if text == "%" {
                
                if let currentVal = Double(screenNumber) {
                                screenNumber = String(currentVal / 100)
                
                
            }
                
                
                
            }
            
        }
        else if text == "÷" || text == "x" || text == "-" || text == "+" || text == "="{
            
//            print("7")
            if text == "÷" || text == "x" || text == "-" || text == "+"{
                leftNum = screenNumber
                oper = text
                screenNumber = "0"
            }
            else{
                rightNum = screenNumber
                doMath(left: leftNum, operate: oper, right: rightNum)
                
            }
                
        }
        else{
            if screenNumber == "0"{
                screenNumber = text
            }
            else{
                screenNumber += text

            }
            return
        }
        
    }
    
    func doMath(left: String, operate: String, right: String){
        if operate == "+"{
            if let leftInt = Int(left), let rightInt = Int(right){
                screenNumber = String(leftInt + rightInt)
            }
        }
        else if operate == "-"{
            if let leftInt = Int(left), let rightInt = Int(right){
                screenNumber = String(leftInt - rightInt)
            }
        }
        else if operate == "x"{
            if let leftInt = Int(left), let rightInt = Int(right){
                screenNumber = String(leftInt * rightInt)
            }
        }
        else if operate == "÷"{
            if let leftInt = Int(left), let rightInt = Int(right){
                if rightInt != 0{
                    screenNumber = String(leftInt / rightInt)
                } else {
                    screenNumber = "Error"
                }
                
            }
        }
    }

    struct ButtonsView: View {
        var cardText: String = "0"
        var doSomething: () -> Void
        var body: some View {
            
            Button(action: doSomething){
                ZStack{
                    RoundedRectangle(cornerRadius: 50)
                        .fill(decideColor(text: cardText))
                        .frame(width: cardText == "0" ? 160 : 80, height: 80.5)
                        .shadow(radius:5)
                    
                    Text("\(cardText)")
                        .foregroundColor(fontColor(text: cardText))
                        .font(.title)
                        .bold()
                    
                    
                    
                    
                }
                
            }
        }
        
        func decideColor(text: String) -> Color{
            if text == "÷" || text == "x" || text == "-" || text == "+" || text == "="{
                return Color.orange
                
            }
            else if text == "AC" || text == "%" || text == "+/-"{
                return Color(white :0.9)
            }
            else{
                return Color.gray
            }
        }
        func fontColor(text: String) -> Color{
            if text == "AC" || text == "%" || text == "+/-"{
                return Color.black
                
            }
            else{
                return Color.white
            }
        }
        
    }
    
}
    #Preview {
        ContentView()
        
    }

