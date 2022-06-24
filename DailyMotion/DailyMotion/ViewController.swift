//
//  ViewController.swift
//  DailyMotion
//
//  Created by Andrei-Stefan BURSUC on 23.06.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        VideoRepository().videos { response in
            dump(response)
        } error: { error in
            dump(error)
        }
    }
}

