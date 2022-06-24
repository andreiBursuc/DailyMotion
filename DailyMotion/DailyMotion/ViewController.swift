//
//  ViewController.swift
//  DailyMotion
//
//  Created by Andrei-Stefan BURSUC on 23.06.2022.
//

import UIKit

class ViewController: UIViewController {

    let videoRepo = VideoRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        videoRepo.videos { response in
            dump(response)
        } error: { error in
            dump(error)
        }
    }
}

