//
//  candidatesTableViewController.swift
//  election-app
//
//  Created by Joseph Nagy on 2/26/20.
//  Copyright © 2020 Joseph Nagy. All rights reserved.
//

import UIKit

class candidatesTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    
    }
}

class candidatesTableViewController: UITableViewController {
    
    //structs for data
    
    struct elections_resource: Codable {
        var id:String?
        var name:String?
        var electionDay:String?
        var ocdDivisionId:String?
    }
    
    struct address: Codable {
        var locationName:String?
        var line1:String?
        var line2:String?
        var line3:String?
        var city:String?
        var state:String?
        var zip:String?
    }
    
    struct source: Codable{
        var name:String?
        var official:Bool?
    }
    
    struct district: Codable{
        var name:String?
        var scope:String
        var id:String?
        
        /*
        init() {
            var name = ""
            var scope = ""
            var id = ""
        }
 */
    }
    
    struct channel: Codable{
        var type:String?
        var id:String?
        init() {
            type = ""
            id = ""
        }
    }
    
    struct candidate: Codable {
        var name:String?
        var party:String?
        var candidateUrl:String?
        var phone:String?
        var photoUrl:String?
        var email:String?
        var orderOnBallot:String?
        var channels:[channel]?
        init() {
            name = ""
            party = ""
            candidateUrl = ""
            phone = ""
            photoUrl = ""
            email = ""
            orderOnBallot = ""
            channels = [channel()]
        }
    }
    
    struct contest: Codable {
        var id:String?
        var type:String?
        var primaryParty:String?
        var electorateSpecifications:String?
        var special:String?
        var ballotTitle:String
        var office:String?
        var level:[String]?
        var roles:[String]?
        var district:district
        var numberElected:String?
        var numberVotingFor:String?
        var ballotPlacement:String?
        var candidates:[candidate]?
        var referendumTitle:String?
        var referendumSubtitle:String?
        var referendumUrl:String?
        var referendumBrief:String?
        var referendumText:String?
        var referendumProStatement:String?
        var referendumConStatement:String?
        var referendumPassageThreshold:String?
        var referendumEffectOfAbstain:String?
        var referendumBallotResponses:[String]?
        var sources:[source]?
       /*
        init() {
            id = ""
            type = ""
            primaryParty = ""
            electorateSpecifications = ""
            special = ""
            ballotTitle = ""
            office = ""
            level = [""]
            roles = [""]
            district = district()
            numberElected = ""
            numberVotingFor = ""
            ballotPlacement = ""
            candidates:[candidate]?
            referendumTitle = ""
            referendumSubtitle = ""
            referendumUrl = ""
            referendumBrief = ""
            referendumText = ""
            referendumProStatement = ""
            referendumConStatement = ""
            referendumPassageThreshold = ""
            referendumEffectOfAbstain = ""
            referendumBallotResponses = [""]
            sources:[source]?
        }
    */
        
    }
    
    struct location: Codable {
        var id:String?
        var address:address?
        var notes:String?
        var pollingHours:String?
        var name:String?
        var voterServices:String?
        var startDate:String?
        var endDate:String?
        var sources:[source]?
    }
    
    struct electionOfficial: Codable {
        var name:String?
        var title:String?
        var officePhoneNumber:String?
        var faxNumber:String?
        var emailAddress:String?
    }
    
    struct electionAdministrationBody: Codable{
        var name:String?
        var electionInfoUrl:String?
        var electionRegistrationUrl:String?
        var electionRegistrationConfirmationUrl:String?
        var absenteeVotingInfoUrl:String?
        var votingLocationFinderUrl:String?
        var ballotInfoUrl:String?
        var electionRulesUrl:String?
        var voter_services:[String]?
        var hoursOfOperation:String?
        var correspondenceAddress:address?
        var physicalAddress:address?
        var electionOfficials:[electionOfficial]?
    }
    
    struct administration_region: Codable {
        var name:String?
        var electionAdministrationBody:electionAdministrationBody?
        var sources:[source]?
    }
    
    struct state: Codable {
        var id:String?
        var name:String?
        var electionAdministrationBody:electionAdministrationBody?
        var local_jurisdiction:administration_region?
        var sources:[source]?
    }
    
    struct civic_data: Codable {
        var kind:String?
        var election:elections_resource?
        var otherElections:[elections_resource]?
        var normalizedInput:address?
        var pollingLocations:[location]?
        var earlyVoteSites:[location]?
        var dropOffLocations:[location]?
        var contests:[contest]
        var state:[state]?
        var mailOnly:Bool?
    }
    
    //var thisContest:contest
    var allCandidates = [candidate()]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Candidates"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
