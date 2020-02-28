//
//  assignedLocationViewController.swift
//  election-app
//
//  Created by Joseph Nagy on 2/27/20.
//  Copyright © 2020 Joseph Nagy. All rights reserved.
//

import UIKit

class assignedLocationViewController: UIViewController {
    struct elections_resource: Codable {
              var id:String?
              var name:String?
              var electionDay:String?
              var ocdDivisionId:String?
          }
          
          struct address: Codable {
              var locationName:String
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
    
    var pollingLocation:location = location()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
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
                    
                    self.pollingLocation = all_civic_data.pollingLocations![0]
        
                } catch {
                    print("JSON Decode error \(error)")
                }
            }
            // actually make the http task run.
            task.resume()
            print("END OF CODE")
        }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
