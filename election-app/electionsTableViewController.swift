//
//  electionsTableViewController.swift
//  election-app
//
//  Created by Joseph Nagy on 2/26/20.
//  Copyright © 2020 Joseph Nagy. All rights reserved.
//

import UIKit

class electionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var scopeLabel: UILabel!
    @IBOutlet weak var contestLabel: UILabel!
    @IBOutlet weak var sealImage: UIImageView!
    @IBOutlet weak var ballotLabel: UILabel!
    @IBOutlet weak var partyLogo: UIImageView!
    
    struct source: Codable{
        var name:String?
        var official:Bool?
    }
    
    struct district: Codable{
        var name:String?
        var scope:String
        var id:String?
    }
    
    struct channel: Codable{
        var type:String?
        var id:String?
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
    }
    
    struct contest: Codable {
        var id:String?
        var type:String?
        var primaryParty:String?
        var electorateSpecifications:String?
        var special:String?
        var ballotTitle:String!
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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class electionsTableViewController: UITableViewController {
    
    // 1. Create structs to match JSON format
    
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
    }
    
    struct channel: Codable{
        var type:String?
        var id:String?
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100
        
        getAllData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
    var contestsG: [contest] = []
    
    func getAllData() {
        // Do any additional setup after loading the view.
                
        // 2. BEGIN NETWORKING code
        
        let mySession = URLSession(configuration: URLSessionConfiguration.default)

        let url = URL(string: "https://www.googleapis.com/civicinfo/v2/voterinfo?address=904%20W%20Main%20St%2C%20Durham%2C%20NC%2027701&key=AIzaSyD8TsaBQ4Oau4vfaojKoXZZceioPHcazqo")!
    
        // 3. MAKE THE HTTPS REQUEST task
    //
            let task = mySession.dataTask(with: url) { data, response, error in

                // ensure there is no error for this HTTP response
                guard error == nil else {
                    print ("error: \(error!)")
                    return
                }

                // ensure there is data returned from this HTTP response
                guard let jsonData = data else {
                    print("No data")
                    return
                }
                
                print("Got the data from network")
    // 4. DECODE THE RESULTING JSON
    //
                let decoder = JSONDecoder()
                do {
                    // decode the JSON into our array of todoItem's
                    let all_civic_data = try decoder.decode(civic_data.self, from: jsonData)
                    
                    for c in all_civic_data.contests{
                        self.contestsG.append(c)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("JSON Decode error \(error)")
                }
            }
            // actually make the http task run.
            task.resume()
            print("END OF CODE")
        }
 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contestsG.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contest", for: indexPath) as! electionTableViewCell
        
        //Change cell colors
        if(indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor.init(displayP3Red: 0.91, green: 0.91, blue: 0.91, alpha: 1.0)
        } else{
            cell.backgroundColor = UIColor.init(displayP3Red: 0.74, green: 0.71, blue: 0.75, alpha: 1.0)
        }

        // Configure the cell...
        var tempParty:String = contestsG[indexPath.row].candidates![0].party ?? ""
        var tempBallotTitle:String = contestsG[indexPath.row].ballotTitle.lowercased()
        var tempBallotTitleArr:[String] = tempBallotTitle.components(separatedBy: " ")
        
        let USstates = [ "ak",
        "al",
        "ar",
        "as",
        "az",
        "ca",
        "co",
        "ct",
        "dc",
        "de",
        "fl",
        "ga",
        "gu",
        "hi",
        "ia",
        "id",
        "il",
        "in",
        "ks",
        "ky",
        "la",
        "ma",
        "md",
        "me",
        "mi",
        "mn",
        "mo",
        "ms",
        "mt",
        "nc",
        "nd",
        "ne",
        "nh",
        "nj",
        "nm",
        "nv",
        "ny",
        "oh",
        "ok",
        "or",
        "pa",
        "pr",
        "ri",
        "sc",
        "sd",
        "tn",
        "tx",
        "ut",
        "va",
        "vi",
        "vt",
        "wa",
        "wi",
        "wv",
        "wy"]


        //set correct ballot title to display
        if(tempBallotTitle.contains("presidential")){
           cell.contestLabel.text = "Presidential Primary"
        }
        else if(tempBallotTitle.contains("us senate")){
           cell.contestLabel.text = "US Senate"
        }
        else if(tempBallotTitle.contains("house of representatives")){
           cell.contestLabel.text = "US House of Representatives"
        }
        else if(tempBallotTitle.contains("governor") && !tempBallotTitle.contains("lieutenant")){
           cell.contestLabel.text = "Governor"
        }
        else if(tempBallotTitle.contains("lieutenant governor")){
           cell.contestLabel.text = "Lieutenant Governor"
        }
        else if(tempBallotTitle.contains("attorney general")){
           cell.contestLabel.text = "Attorney General"
        }
        else if(tempBallotTitle.contains("auditor")){
           cell.contestLabel.text = "Auditor"
        }
        else if(tempBallotTitle.contains("treasurer")){
           cell.contestLabel.text = "Treasurer"
        }
        else if(tempBallotTitle.contains("agriculture")){
           cell.contestLabel.text = "Commissioner of Agriculture"
        }
        else if(tempBallotTitle.contains("labor")){
           cell.contestLabel.text = "Commissioner of Labor"
        }
        else if(tempBallotTitle.contains("insurance")){
           cell.contestLabel.text = "Commissioner of Insurance"
        }
        else if(tempBallotTitle.contains("superintendent")){
           cell.contestLabel.text = "Superintendent of Public Instruction"
        }
        else if(tempBallotTitle.contains("secretary of state")){
           cell.contestLabel.text = "Secretart of State"
        }
        else if(tempBallotTitle.contains("board of education") && tempBallotTitle.contains("at-large")){
           cell.contestLabel.text = "Board of Education At-Large"
        }
        else if(tempBallotTitle.contains("board of education") && tempBallotTitle.contains("district")){
           cell.contestLabel.text = "Board of Education District"
        }
        else if(tempBallotTitle.contains("board of commissioners")){
           cell.contestLabel.text = "Board of Commissioners"
        }
        else if(USstates.contains(tempBallotTitleArr[0]) && tempBallotTitleArr[2] == "senate"){
            cell.contestLabel.text = "State Senate"
        }
        else if(USstates.contains(tempBallotTitleArr[0])){
            cell.contestLabel.text = tempBallotTitleArr.dropFirst().joined(separator: " ")
        }
        else if(tempBallotTitleArr[1] == "county"){
            cell.contestLabel.text = tempBallotTitleArr.dropFirst(2).joined(separator: " ")
        }
        
        

        //cell.ballotTitleLabel.text = contestsG[indexPath.row].ballotTitle
           
           

        //set correct party to display
        if(tempParty.contains("GREEN")){
           cell.scopeLabel.text = "Green           Party"
            cell.partyLogo.image = UIImage(named: "green")
            //cell.scopeLabel.textColor = "#fc0a"
        }
        else if(tempParty.contains("LIBERTARIAN")){
           cell.scopeLabel.text = "Libertarian Party"
            cell.partyLogo.image = UIImage(named: "libertarian")
        }
        else if(tempParty.contains("REPUBLICAN")){
           cell.scopeLabel.text = "Republican Party"
            cell.partyLogo.image = UIImage(named: "republican")
        }
        else if(tempParty.contains("DEMOCRAT")){
           cell.scopeLabel.text = "Democratic Party"
            cell.partyLogo.image = UIImage(named: "democratic")
        }
        else if(tempParty.contains("CONSTITUTION")){
           cell.scopeLabel.text = "Constitution Party"
            cell.partyLogo.image = UIImage(named: "constitution")
        }
        else{
           cell.scopeLabel.text = "General Election"
            cell.partyLogo.image = UIImage(named: "flag")
        }

        //set correct seals to display
        if(contestsG[indexPath.row].ballotTitle.contains("PRESIDENTIAL")) {
           cell.sealImage.image = UIImage(named: "president")
        }
        else if(contestsG[indexPath.row].ballotTitle.contains("US SENATE")){
           cell.sealImage.image = UIImage(named: "senate")
        }
        else if(contestsG[indexPath.row].ballotTitle.contains("REPRESENTATIVES")){
           cell.sealImage.image = UIImage(named: "house")
        }
        else if(contestsG[indexPath.row].ballotTitle.contains("COUNTY")){
           cell.sealImage.image = UIImage(named: "county")
        }
        else{
           cell.sealImage.image = UIImage(named: "state")
        }

        return cell
        }


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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // and cast it to the correct class type
        
        let destVC = segue.destination as! candidatesTableViewController
        
        // Pass the selected object to the new view controller.
        let myRow = tableView!.indexPathForSelectedRow
        let myCurrCell = tableView!.cellForRow(at: myRow!) as! electionTableViewCell
//        print(myRow!.row)
        
        //This code uses variables that aren't precisely accurate.\
        //myRow is a tuple of myRow.section being the section # and myRow.row being the row number Therefore, you must index the row number as a reference to the index of the elements in the list you want to youse. A better name for myRow could be indexPath. It doesnt really matter as long as you understand what is going on. 
        destVC.allCandidates = contestsG[myRow!.row].candidates!
    }
    

}
