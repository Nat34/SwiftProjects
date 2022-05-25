//
//  ViewController.swift
//  ImageViewer
//
//  Created by Nathan Thomas on 5/15/22.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Image Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        // ios app always has one, force unwrap ok
        let path = Bundle.main.resourcePath!
        // if we cannot read the app bundle, something wrong, force unwrap ok
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // load picture
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // change default behavior
    // takes a UTableView
    // cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for:
        indexPath)
        // cell has a text label, lets set it to the filename if it exists
        cell.textLabel?.text = "Picture \(indexPath.row + 1) of \(pictures.count)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // storyboard may be nil, ? is optional chaining
        // as? may fail, may receive a viewController of a different type
        // if any, i.e if let, nothing in brackets will execute
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

