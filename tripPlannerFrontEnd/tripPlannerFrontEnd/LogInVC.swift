//
//  LogInVC.swift
//  tripPlannerFrontEnd
//
//  Created by Tony Cioara on 12/26/17.
//  Copyright © 2017 Tony Cioara. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {
    
    var loginUser: Any?
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func logInButton(_ sender: Any) {
        guard let email = emailTF.text else {return}
        guard let password = passwordTF.text else {return}
        logIn(email: email, password: password)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let email = emailTF.text else {return}
        guard let password = passwordTF.text else {return}
        signUp(email: email, password: password)
    }
    
    func logIn (email: String, password: String) {
        let basicToken = BasicAuth.generateBasicAuthHeader(username: email, password: password)
        
        //This request has to have the proper credentials to get back the correct data, we provide the request with credentials with our authorization and parameters.
        Network.instance.fetch(route: Route.get_user, token: basicToken) { (data) in
            let jsonUser = try? JSONDecoder().decode(User.self, from: data)
            if let user = jsonUser {
                
                self.loginUser = user
                print("Login Success")
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toTrips", sender: self)
                    
                }
            }
        }
    }
    
    
    func signUp (email: String, password: String) {
        let basicToken = BasicAuth.generateBasicAuthHeader(username: email, password: password)
        Network.instance.fetch(route: Route.post_user(email: email, password: password), token: basicToken) { (data) in

            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toTrips", sender: self)
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "ToTrips" {
                let tripsVC = segue.destination as! TripsVC
                tripsVC.user = loginUser as! User
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


