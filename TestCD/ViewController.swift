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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    var villes = [Ville]()
    
    let leContexte = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
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

