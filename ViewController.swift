//
//  ViewController.swift
//  Loteria
//
//  Created by William Tomaz on 27/04/20.
//  Copyright © 2020 William Tomaz. All rights reserved.
//

import UIKit

enum GameType: String { //Enum de string com valores da loteria (nomes)
    case megasena = "MEGA-SENA"
    case quina = "QUINA"
}

infix operator >-<
func >-< (total: Int, universe: Int) -> [Int]{
    var result: [Int] = []
    while result.count < total{
        let randomNumber = Int(arc4random_uniform(UInt32(universe))+1) //converte "universe""em UInt32, e depois tudo pra inteiro
        if !result.contains(randomNumber){ //se o numero não tiver no array ele adicion
            result.append(randomNumber)
        }
    }
    return result.sorted()
}

class ViewController: UIViewController {

    @IBOutlet weak var lbGameType: UILabel!
    @IBOutlet weak var scGameType: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        showNumbers(for: .megasena)
    }
    
    func showNumbers(for type: GameType) { //função para exibir os números
        lbGameType.text = type.rawValue //está pegando a string atribuida no enum
        var game: [Int] = []
        switch type {
            case .megasena:
                game = 6>-<60 //Chamando o operador criado acima
            balls.last!.isHidden = false //escondida false, ou seja, a bolinha aparece
            case .quina:
                game = 5>-<80
            balls.last!.isHidden = true //bolinha ofuscada
        }
        for (index, game) in game.enumerated(){ //for in varre todos elementos, enumerated devolve uma tupla com chave e valor
            balls[index].setTitle("\(game)", for: .normal) //no for in é criado uma chave (0, 1, 2 ...) com o valor de game(6 numeros ou 5, randomicos), e depois é passado os valores "game", para o titulo dos botoes, que estao ordenados da mesma forma
        }
    }
    
    @IBAction func generateGame() {
        switch scGameType.selectedSegmentIndex { //encaminha o tipo de jogo de acordo com o index selecionado
        case 0:
            showNumbers(for: .megasena)
        default:
            showNumbers(for: .quina)
        }
    }
}

