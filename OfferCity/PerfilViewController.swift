//
//  PerfilViewController.swift
//  followme
//
//  Created by Miguel Mexicano Herrera on 15/04/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Visitas: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        RestService().ServiceTest(usuario: "522224458813", isProfile: true, imei: "000867721021924579"){response, error in
            
            self.Visitas.text = String(describing: response!.visitaPerfil)
            self.Name.text = response?.name
            
            
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
