//
//  ViewController.swift
//  SpotifySDKDemo
//
//  Created by Elon Rubin on 2/16/17.
//  Copyright © 2017 Elon Rubin. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation

class MainViewController: UIViewController, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {

    //--------------------------------------
    // MARK: Variables
    //--------------------------------------
    
    // Variables
    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession!
    
    // Initialzed in either updateAfterFirstLogin: (if first time login) or in viewDidLoad (when there is a check for a session object in User Defaults
    var player: SPTAudioStreamingController?
    var loginUrl: URL?
    
    
    //--------------------------------------
    // MARK: Outlets
    //--------------------------------------
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var nextSong: UIButton!
    
    
    //--------------------------------------
    // MARK: Functions
    //--------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.updateAfterFirstLogin), name: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil)
        
    }

    func setup () {
        // insert redirect your url and client ID below
        let redirectURL = "beet-login://callback" // put your redirect URL here
        let clientID = "d1003042be864a2a8e2b6188fb8d74b1" // put your client ID here
        auth.redirectURL     = URL(string: redirectURL)
        auth.clientID        = clientID
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
<<<<<<< HEAD:Beet/MainViewController.swift
=======
        self.nextSong.isHidden = true
        
>>>>>>> 66fc21cb7ff99622cabe90e5ad92f2232eb5625b:SpotifySDKDemo/MainViewController.swift
    }
    
    func initializePlayer(authSession:SPTSession){
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self
            self.player!.delegate = self
            try! player?.start(withClientId: auth.clientID)
            self.player!.login(withAccessToken: authSession.accessToken)
        }
    }
    
    func updateAfterFirstLogin () {
        loginButton.isHidden = true
        let userDefaults = UserDefaults.standard
        
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            
            self.session = firstTimeSession
            initializePlayer(authSession: session)
            self.loginButton.isHidden = true
            
        }
    }
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        // after a user authenticates a session, the SPTAudioStreamingController is then initialized and this method called
<<<<<<< HEAD:Beet/MainViewController.swift
        print("logged in")
        self.player?.playSpotifyURI("spotify:track:58s6EuEYJdlb0kO7awm3Vp", startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
        })
=======
       print("logged in")
        
            self.nextSong.isHidden = false
            self.player?.playSpotifyURI("spotify:user:leoxia360:playlist:7E5AEH4mIljpXkpxs1lha7", startingWith: 0, startingWithPosition: 0, callback: { (error) in
                if (error != nil) {
                    print("playing!")
                }
                
            })
        
>>>>>>> 66fc21cb7ff99622cabe90e5ad92f2232eb5625b:SpotifySDKDemo/MainViewController.swift
    }

    @IBAction func nextSongButtonPressed(_ sender: Any) {
        self.player?.skipNext({ (error) in
            if (error != nil){
                print("next song")
            }
        })
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if UIApplication.shared.openURL(loginUrl!) {
            if auth.canHandle(auth.redirectURL) {
                // To do - build in error handling
            }
        }
    }
}

