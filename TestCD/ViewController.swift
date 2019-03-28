//
//  ViewController.swift
//  TestCD
//
//  Created by Ali ED-DBALI on 11/03/2019.
//  Copyright © 2019 Ali ED-DBALI. All rights reserved.
//
// Projet qui montre l'usage de CoreData et TableView
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    var villes = [Ville]()
    
    let leContexte = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //1. Create the alert controller.
    let alert = UIAlertController(title: "Entrez les données de la ville svp", message: "", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Création
        
        /*
            let nouvelleVille = Ville(context: leContexte)
         
            nouvelleVille.nom = "London"
            nouvelleVille.population = 4000000
         
            do {
                try leContexte.save()
            } catch {
                print("Problème de sauvegarde : \(error)")
            }
        */
        
        alert.addTextField { (textField) in
            textField.text = "Nom"
        }
        
        alert.addTextField { (textField) in
            textField.text = "Population"
        }
        
        loadData()
    }
    
    // MARK: DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return villes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = villes[indexPath.row].nom
        
        cell.detailTextLabel?.text = String(villes[indexPath.row].population)
        // cell.detailTextLabel?.text = formatNumber(Int(villes[indexPath.row].population))
        return cell
    }

    
    // MARK: Charger les données dans le tableau

    func loadData() {
        
        let requete : NSFetchRequest<Ville> = Ville.fetchRequest()
        do {
            let resultat = try leContexte.fetch(requete)
            // Dans resultat : la liste des villes retournées par la requête
            for ville in resultat {
                villes.append(ville)
            }
            // print(resultat)
        } catch {
            print("Interrogation impossible : \(error)")
        }
    }

    /*{
        if buttonIndex == 1 {
            let nouvelleVille = Ville(context: leContexte)
            
            nouvelleVille.nom = alertView.textField(at:0)?.text;
            print("test");
            nouvelleVille.population = 4000000
            
            do {
                try leContexte.save()
            } catch {
                print("Problème de sauvegarde : \(error)")
            }
            
            tableView.reloadData();
        }
    }*/
    
    @IBAction func onAdd(_ sender: Any) {
        
        let nouvelleVille = Ville(context: leContexte)
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            
            nouvelleVille.nom = textField.text!
            nouvelleVille.population = 4000000
            
            print(nouvelleVille.nom)
            do {
                try self.leContexte.save()
                self.villes.removeAll()
                self.loadData()
                self.tableView.reloadData()
            } catch {
                print("Problème de sauvegarde : \(error)")
            }
            
        }))
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        self.tableView.reloadData();
    }
    // MARK: Fonctions utilitaires
    
    // Fonction qui retourne une chaine où le nombre est formatté. Ici des espaces qui séparent les milliers
    private func formatNumber(_ number : Int) -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = " "
        formater.numberStyle = .decimal
        let fs = formater.string(from: NSNumber(value: number))!
        return fs
    }
}

