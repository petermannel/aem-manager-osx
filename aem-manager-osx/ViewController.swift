//
//  ViewController.swift
//  aem-manager-osx
//
//  Created by Peter Mannel-Wiedemann on 27.11.15.
//
//

import Cocoa

class ViewController: NSViewController {
    
    // MARK: properties
    @IBOutlet weak var table: NSTableView!
    
    
    var  instances = AEMInstance.loadAEMInstances()
    var selectedInstance: AEMInstance?
    
    var guiarray:[NSWindowController] = []
    
    override func viewDidAppear() {
        for a in instances {
            print(a.id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.setDataSource(self)
        table.setDelegate(self)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableData:", name: "reload", object: nil)

        let app = NSApplication.sharedApplication().delegate as! AppDelegate
        app.mainVC = self

    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func editInstance(sender: NSMenuItem) {
        
    
        if table.selectedRow < 0 {
            performSegueWithIdentifier("noInstance",sender: self)
        }else{
            
            // open preferences dialog with instance
            if let winCrtl = storyboard!.instantiateControllerWithIdentifier("aemInstanceGUI") as? NSWindowController {
                if let aemInstanceGui = winCrtl.contentViewController as? AemInstanceController{
                    // add data
                    print("Selected Instance in table with id \(selectedInstance?.id) and name \(selectedInstance?.name)")
                    aemInstanceGui.aeminstance = selectedInstance
                    aemInstanceGui.instances = instances
                    print("Edit Instance with name : \(aemInstanceGui.aeminstance!.name) and id: \(aemInstanceGui.aeminstance!.id)")
                }
                winCrtl.showWindow(self)
                guiarray.append(winCrtl)
            }
        }
        
        
    }
    
    @IBAction func newInstance(sender: NSMenuItem) {
        
        // open new preferences dialog
        if let winCrtl = storyboard!.instantiateControllerWithIdentifier("aemInstanceGUI") as? NSWindowController {
            
            if let aemInstanceGui = winCrtl.contentViewController as? AemInstanceController{
                // add data
                aemInstanceGui.aeminstance = AEMInstance()
                aemInstanceGui.instances = instances
 
                print("New Instance with id \(aemInstanceGui.aeminstance!.id)")
            }
            winCrtl.showWindow(self)
            guiarray.append(winCrtl)
        }
        
    }
    
    @IBAction func startInstance(sender: NSMenuItem) {
        
        
        if table.selectedRow < 0 {
            performSegueWithIdentifier("noInstance",sender: self)
        }else{
            print("Start Instance")
        }
        
    }
    @IBAction func stopInstance(sender: NSMenuItem) {
        
        if table.selectedRow < 0 {
            performSegueWithIdentifier("noInstance",sender: self)
        }else{
            print("Stop Instance")
        }
        
        
        
    }
    @IBAction func openAuthor(sender: NSMenuItem) {
        if table.selectedRow < 0 {
            performSegueWithIdentifier("noInstance",sender: self)
        }else{
            print("Open Author/Publish")
        }
        
        
    }
    @IBAction func openCRXDE(sender: NSMenuItem) {
        if table.selectedRow < 0 {
            performSegueWithIdentifier("noInstance",sender: self)
        }else{
            print("Open CRX DE")
        }
        
        
    }
    
    @IBAction func openFelixConsole(sender: NSMenuItem) {
        if table.selectedRow < 0 {
            performSegueWithIdentifier("noInstance",sender: self)
        }else{
            print("Open Felix Console")
        }
        
        
    }
    
    func reloadTableData(notification: NSNotification){
        table.reloadData()
    }

    
    
    
}


extension ViewController: NSTableViewDataSource , NSTableViewDelegate {
    

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return instances.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        if let coid = tableColumn?.identifier {
            switch coid {
            case "name": return instances[row].name
            case "path": return instances[row].path
            case "type": return instances[row].type
            case "status": return instances[row].status
            case "url": return AEMInstance.getUrl(instances[row])
            default: break
            }
            
        }
        return nil
    }
    func tableViewSelectionDidChange(notification: NSNotification) {
        if table.selectedRow >= 0 {
            print("Selected instance in table with name : \(instances[table.selectedRow].name) and id: \(instances[table.selectedRow].id)")
            // set seletected instance
            selectedInstance = instances[table.selectedRow]
            
        }
    }
    
    
}



