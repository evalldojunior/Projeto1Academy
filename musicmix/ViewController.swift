//
//  ViewController.swift
//  musicmix
//
//  Created by Evaldo Garcia de Souza Júnior on 02/03/20.
//  Copyright © 2020 Evaldo Garcia de Souza Júnior. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var generoTextField: UITextField!
    @IBOutlet var timeTextField: UITextField!
    
    @IBOutlet var partyButton: UIButton!
    @IBOutlet var darkModeButton: UIButton!
    @IBOutlet var shuffleButton: UIButton!
    @IBOutlet var lixoButton: UIButton!
    
    @IBOutlet var logoImage: UIImageView!
    
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    
    var resultado = false
    var dark = false
    
    let time = ["2", "4", "6", "8", "10", "12", "17", "16", "18", "20", "22", "24", "26", "28", "30", "32", "34", "36", "38", "40"]
    let genero = ["Alternativa", "Classica", "Brega", "Dance", "Eletronica", "Forró", "Funk", "Gospel", "Hip hop", "Indie", "MPB", "Pagode", "Pop", "Rap", "Rock", "Sertanejo"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: timeTextField.frame.height))
        timeTextField.leftViewMode = .always
        generoTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: generoTextField.frame.height))
        generoTextField.leftViewMode = .always
        
        timeTextField.layer.borderWidth = 2
        generoTextField.layer.borderWidth = 2
        timeTextField.attributedPlaceholder = NSAttributedString(string: "Tempo (minutos)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        generoTextField.attributedPlaceholder = NSAttributedString(string: "Gênero musical", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        lixoButton.isHidden = true
        shuffleButton.isHidden = true
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        timeTextField.inputView = pickerView1
        generoTextField.inputView = pickerView2
        
        configureTextFields()
        configureTapGesture()
        
    }
    
    @IBAction func mostrarResultado() {
        view.endEditing(true)
        if timeTextField.text == "" || generoTextField.text == "" {
            let alerta = UIAlertController(title: "Alerta", message: "Preencha todos os campos", preferredStyle: UIAlertController.Style.alert)
            let botaoOK = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            
            alerta.addAction(botaoOK)
            self.present(alerta, animated: true, completion: nil)
        } else {
            if resultado == false {
                posicaoFinalElementos()
                resultado = true
            }
            else {
                posicaoInicialElementos()
                resultado = false
            }
        }
    }
    
    
    @IBAction func darkMode() {
        modoNoturno()
    }
    
    func criarListaMusica() {
        //- Ler o campo de tempo
        let time = timeTextField.text!
        let timeInt = Int(time)!
        
        //- Ler o campo de gênero musical
        let genero = generoTextField.text!
        
        //- Aplicar o algoritmo de knapsack para descobrir a lista de musicas do gênero dado que completem o tempo dado
    }
    
    
    func mostrarListaMusica() {
        //- Aparecer a lista de musicas resultante do algoritmo de knapsack apos os campos de tempo e genero musical
    }
    
    func esconderLista() {
        //- Esconder a lista de musicas
    }
    
    
    func posicaoInicialElementos() {
        //- Voltar os campos de tempo e gênero musical a sua posição inicial
        timeTextField.frame = CGRect(x: timeTextField.frame.origin.x, y: 396, width: timeTextField.frame.size.width, height: timeTextField.frame.size.height)
        generoTextField.frame = CGRect(x: generoTextField.frame.origin.x, y: 396, width: generoTextField.frame.size.width, height: generoTextField.frame.size.height)
        logoImage.frame = CGRect(x: logoImage.frame.origin.x, y: 146, width: logoImage.frame.size.width, height: logoImage.frame.size.height)
        timeTextField.text = ""
        generoTextField.text = ""
        
        //- Esconder os botões de lixeira e shuffle
        lixoButton.isHidden = true
        shuffleButton.isHidden = true
        
        //- Reaparecer o modo noturno
        darkModeButton.isHidden = false
        
        //- Trocar o texto do botão refazer para “Party!”
        //- Voltar o botão party para a sua posição inicial
        partyButton.setTitle("Party!", for: .normal)
        partyButton.frame = CGRect(x: partyButton.frame.origin.x, y: 489, width: partyButton.frame.size.width, height: partyButton.frame.size.height)
        
        // trnar editavel
        timeTextField.isEnabled = true
        generoTextField.isEnabled = true
    }
    
    func posicaoFinalElementos() {
        esconderElementos()
        mostrarElementos()
        moverETrocarNomeBotao()
        moverCamposTempoGenero()
    }
    
    func modoNoturno() {
        //- Trocar as cores do fundo e dos campos de tempo e gênero musical
        if dark == false {
            view.backgroundColor = #colorLiteral(red: 0.1316064894, green: 0.1274462938, blue: 0.1274887919, alpha: 1)
            timeTextField.layer.borderColor = UIColor.white.cgColor
            timeTextField.textColor = UIColor.white
            timeTextField.attributedPlaceholder = NSAttributedString(string: "Tempo (minutos)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            generoTextField.layer.borderColor = UIColor.white.cgColor
            generoTextField.textColor = UIColor.white
            generoTextField.attributedPlaceholder = NSAttributedString(string: "Gênero musical", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            
            dark = true
        } else {
            view.backgroundColor = UIColor.white
            timeTextField.layer.borderColor = UIColor.black.cgColor
            timeTextField.textColor = UIColor.black
            timeTextField.attributedPlaceholder = NSAttributedString(string: "Tempo (minutos)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
            generoTextField.layer.borderColor = UIColor.black.cgColor
            generoTextField.textColor = UIColor.black
            generoTextField.attributedPlaceholder = NSAttributedString(string: "Gênero musical", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
            
            dark = false
        }
        
    }
    
    func esconderElementos() {
        //- Esconder o botão de modo noturno
        darkModeButton.isHidden = true
    }
    
    func mostrarElementos() {
        //- Aparecer botões de lixeira e shuffle
        lixoButton.isHidden = false
        shuffleButton.isHidden = false
    }
    
    func moverETrocarNomeBotao() {
        //- Mover o botão Party! um pouco para baixo
        //- Trocar o texto do botão “Party!” para “Refazer”
        partyButton.setTitle("Refazer", for: .normal)
        partyButton.frame = CGRect(x: partyButton.frame.origin.x, y: 751, width: partyButton.frame.size.width, height: partyButton.frame.size.height)
    }
    
    func moverCamposTempoGenero() {
        //- Mover os campos de tempo e gênero musical um pouco para cima
        timeTextField.frame = CGRect(x: timeTextField.frame.origin.x, y: 300, width: timeTextField.frame.size.width, height: timeTextField.frame.size.height)
        generoTextField.frame = CGRect(x: generoTextField.frame.origin.x, y: 300, width: generoTextField.frame.size.width, height: generoTextField.frame.size.height)
        logoImage.frame = CGRect(x: logoImage.frame.origin.x, y: 113, width: logoImage.frame.size.width, height: logoImage.frame.size.height)
        
        // tornar nao editavel
        timeTextField.isEnabled = false
        generoTextField.isEnabled = false
        
        //timeTextField.text = timeTextField.text! + " minutos"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == pickerView1 {
            return 1
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1 {
            return time.count
        } else {
            return genero.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return time[row]
        } else {
            return genero[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
            timeTextField.text = time[row] + " minutos"
        } else {
            generoTextField.text = genero[row]
        }
    }
    
    private func configureTextFields() {
        timeTextField.delegate = self
        generoTextField.delegate = self
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    // comentar as linhas de codigo depois desse comentario
    var musica: Musica = Musica(tempoMin: 4, generoMus: "Pop")
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class Musica {
    var tempo: Int
    var genero: String
    
    init(tempoMin: Int, generoMus: String) {
        tempo = tempoMin
        genero = generoMus
    }
}
