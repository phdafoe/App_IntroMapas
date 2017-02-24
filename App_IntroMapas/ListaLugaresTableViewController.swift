//
//  ListaLugaresTableViewController.swift
//  App_IntroMapas
//
//  Created by formador on 24/2/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit

typealias diccionario = [String: String]
var customLugaresFavoritos = [diccionario]()
var existeObjetoSeleccioando = -1




class ListaLugaresTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customLugaresFavoritos.append(["name": "Taj - Majal", "lat" : "27.175277", "long": "78.042128"])

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return customLugaresFavoritos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        
        //let dataModel = customLugaresFavoritos[indexPath.row]
        
        cell.textLabel?.text = customLugaresFavoritos[indexPath.row]["name"]
        cell.detailTextLabel?.text = customLugaresFavoritos[indexPath.row]["lat"]
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        existeObjetoSeleccioando = indexPath.row
        return indexPath
    }
    
    

    
    // MARK: - Navigation
    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "muestraMapaSinSeleccion"{
            existeObjetoSeleccioando = -1
        }
    }
    
    
    
    
    
    
    
    
    
    

}
