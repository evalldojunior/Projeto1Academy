//
//  Knapsack.swift
//  musicmix
//
//  Created by Evaldo Garcia de Souza Júnior on 12/03/20.
//  Copyright © 2020 Evaldo Garcia de Souza Júnior. All rights reserved.
//

import Foundation

public final class Knapsack {
    
    var capacityOfBag: Int
    var knapsackItems: [Musica]
    
    init(capacity: Int, activities: [Musica]) {
        self.capacityOfBag = capacity
        self.knapsackItems = activities
    }
    
    func knapsack() -> [Musica] {
        var tableOfValues = [[Int]]()
     
        tableOfValues = Array(repeating: Array(repeating: 0, count: capacityOfBag+1),
                              count: knapsackItems.count+1)
        
        for itemIndex in 1...knapsackItems.count{
            for totalTime in 1...capacityOfBag{
                
                if(totalTime < knapsackItems[itemIndex-1].tempo){
                    tableOfValues[itemIndex][totalTime] = tableOfValues[itemIndex-1][totalTime]
                }
                else{
                    let remainingCapacity = totalTime - knapsackItems[itemIndex-1].tempo
                    tableOfValues[itemIndex][totalTime] = max(1 + tableOfValues[itemIndex-1][remainingCapacity], tableOfValues[itemIndex-1][totalTime]) //colocando a prioridade de todos os itens como a mesma
                }
            
            }
        }

        var res = tableOfValues[knapsackItems.count][capacityOfBag]
        var w = capacityOfBag
        var i = knapsackItems.count
        var acts : [Musica] = []
        
        while(i > 0 && res > 0){

            if(res != tableOfValues[i-1][w]){
                acts.append(knapsackItems[i-1])
                res = res - 1 // mudando a prioridade de todos os itens para ser a mesma. antes no lugar do 1: (capacityOfBag - knapsackItems[i-1].tempo)
                w = w - knapsackItems[i-1].tempo
            }
            
            i = i - 1
            
        }
        
        return acts        
    }
    
}
