//
//  ViewController.swift
//  musicmix
//
//  Created by Evaldo Garcia de Souza Júnior on 02/03/20.
//  Copyright © 2020 Evaldo Garcia de Souza Júnior. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
//    var auth = SPTAuth.defaultInstance()
//    var session:SPTSession!
//    var player : SPTAudioStreamingController?
//    var loginUrl: URL?
    
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
        
        preencherMusicas()
        
//        setup()
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateAfterFirstLogin), name: NSNotification.Name(rawValue: "ligginSuccessfull"), object: nil)
    }
    
    
//    @IBAction func spotifyLogin(_ sender: Any) {
//        if UIApplication.shared.canOpenURL(loginUrl!){ //talvez de erro
//            if auth!.canHandle(auth?.redirectURL) {
//                // do something
//            }
//        }
//    }
    
    @IBAction func mostrarResultado() {
        view.endEditing(true)
        if timeTextField.text == "" || generoTextField.text == "" {
            let alerta = UIAlertController(title: "Alerta", message: "Preencha todos os campos", preferredStyle: UIAlertController.Style.alert)
            let botaoOK = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            
            alerta.addAction(botaoOK)
            self.present(alerta, animated: true, completion: nil)
        } else {
            if resultado == false {
                UIView.animate(withDuration: 1.5) {
                    self.posicaoFinalElementos()
                }
                resultado = true
            }
            else {
                UIView.animate(withDuration: 1.5) {
                    self.posicaoInicialElementos()
                    }
                resultado = false
            }
        }
    }
    
    
    @IBAction func darkMode() {
        UIView.animate(withDuration: 0.5) {
            self.modoNoturno()
        }
    }
    
//    func setup() {
//        let redirectURL = "musicmix://returnAfterLogin"
//        let clientID = "14a528f61c4a49ad93abab2808829549"
//        auth!.redirectURL = URL(string: redirectURL)
//        auth!.clientID = "14a528f61c4a49ad93abab2808829549"
//        auth?.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
//        loginUrl = auth?.spotifyAppAuthenticationURL()
//    }
//
//    func initializePlayer(authSession:SPTSession) {
//        if self.player == nil {
//            self.player = SPTAudioStreamingController.sharedInstance()
//            self.player!.playbackDelegate = self
//            self.player!.delegate = self
//            try! player?.start(withClientId: auth?.clientID)
//            self.player!.login(withAccessToken: authSession.accessToken)
//        }
//    }
    
//    @objc func updateAfterFirstLogin() {
//        let userDefaults = UserDefaults.standard
//        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
//            let sessionDataObj = sessionObj as! Data
//            let firstTimeSession = try? NSKeyedUnarchiver.unarchivedObject(ofClass: SPTSession.self, from: sessionDataObj)! //talvez de erro
//            self.session = firstTimeSession
//            initializePlayer(authSession: session)
//        }
//    }
//
//    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
//        print("ae porra voce logou")
//    }
    
    func criarListaMusica() {
        //- Ler o campo de tempo
        let time = timeTextField.text!
        let timeInt = Int(time)!
        
        //- Ler o campo de gênero musical
        //let genero = generoTextField.text!
        
        //- Aplicar o algoritmo de knapsack para descobrir a lista de musicas do gênero dado que completem o tempo dado
        var knapsack: Knapsack = Knapsack(capacity: timeInt, activities: listaMusica)
        var listaFinal: [Musica] = knapsack.knapsack()
        print(listaFinal[1].nome)
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
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
            self.lixoButton.alpha = 0
            self.shuffleButton.alpha = 0
        }, completion: { _ in
            self.lixoButton.isHidden = true
            self.shuffleButton.isHidden = true
        })
        
        //- Reaparecer o modo noturno
        darkModeButton.alpha = 0
        darkModeButton.isHidden = false
        UIView.animate(withDuration: 0.1, delay: 1.0, options: .curveEaseInOut, animations: {
            self.darkModeButton.alpha = 1
        }, completion: { _ in
        })
        
        //- Trocar o texto do botão refazer para “Party!”
        //- Voltar o botão party para a sua posição inicial
        partyButton.setTitle("Party!", for: .normal)
        partyButton.frame = CGRect(x: partyButton.frame.origin.x, y: 489, width: partyButton.frame.size.width, height: partyButton.frame.size.height)
        
        // trnar editavel
        timeTextField.isEnabled = true
        generoTextField.isEnabled = true
    }
    
    func posicaoFinalElementos() {
        criarListaMusica()
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
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.darkModeButton.alpha = 0
        }, completion: { _ in
            self.darkModeButton.isHidden = true
        })
    }
    
    func mostrarElementos() {
        //- Aparecer botões de lixeira e shuffle
        lixoButton.alpha = 0
        shuffleButton.alpha = 0
        self.lixoButton.isHidden = false
        self.shuffleButton.isHidden = false
        UIView.animate(withDuration: 0.1, delay: 1.0, options: .curveEaseInOut, animations: {
            self.lixoButton.alpha = 1
            self.shuffleButton.alpha = 1
        }, completion: { _ in
        })
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
    
    // colocando exemplos predefinidos para mostrar pelo menos um resultado
    // talvez colocar as proximas linhas em um outro arquivo
    var listaMusica: [Musica] = []
    
    let nomeGeral = ["Physical", "Stupid Love", "Salt", "Don't Start Now", "The Man", "Say So", "Worth It", "Work", "Shake It Off", "Want To Want Me", "Lean On", "Super Bass", "Happy", "Someone Like You", "Glad You Came", "Call Me Maybe", "Stronger", "Payphone", "Roar", "I Love It", "Problem"]
    
    let tempoGeral = [3, 3, 3, 3, 4, 3, 4, 3, 4, 3, 3, 3, 4, 5, 3, 3, 4, 4, 4, 3, 3]
    
    //let capaGeral = [""]
    
    let artistaGeral = ["Dua Lipa", "Lady Gaga", "Ava Max", "Dua Lipa", "Taylor Swift", "Doja Cat", "Fifth Harmony", "Rihanna", "Taylor Swift", "Jason Derulo", "Major Lazer", "Nicki Minaj", "Pharrell Williams", "Adele", "The Wanted", "Carly Rae Jepsen", "Kelly Clarkson", "Marron 5", "Katy Perry", "Icona PoP", "Ariana Grande"]
    
    func preencherMusicas() {
        for n in 0...nomeGeral.count-1 {
            let musica: Musica = Musica(tempoMin: tempoGeral[n], nomeMus: nomeGeral[n], artistaMus: artistaGeral[n])
            listaMusica.append(musica)
        }
    }
    
    
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
