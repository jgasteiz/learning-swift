//
//  ViewController.swift
//  FunFacts
//
//  Created by Javi Manzano on 15/03/2015.
//  Copyright (c) 2015 Javi Manzano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var funFactGenerator = FunFactGenerator()
    var colorWheel = ColorWheel()

    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var funFactButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        getFunFact()
    }

    @IBAction func getFunFact() {
        let funFact = funFactGenerator.getFunFact()
        funFactLabel.text = funFact

        let randomColor = colorWheel.getRandomColor()
        funFactButton.tintColor = randomColor
        view.backgroundColor = randomColor
    }

}

