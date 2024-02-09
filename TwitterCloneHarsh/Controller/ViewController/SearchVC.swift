//
//  SearchVC.swift
//  TwitterCloneHarsh
//
//  Created by My Mac Mini on 24/12/23.
//

import UIKit

//MARK: -  UITableViewCell
class SearchTVC: UITableViewCell {
    
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var lblTrendingHashTag: UILabel!
    
    @IBOutlet weak var lblCountPost: UILabel!
    
}

class SearchVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    //MARK: -  @IBOutlet
    @IBOutlet weak var tblSearch: UITableView!
    
    // Dummy Data
    //MARK: -  Properties
    let arrCategory = ["Movies · Trending",
                       "Sports · Trending",
                       "Autos and vehicles · Trending",
                       "Education · Trending",
                       "AI · Trending",
                       "Stocks · Trending",
                       "Culture · Trending",
                       "Citizenship · Trending",
                       "Smartphones · Trending",
                       "Entertainment · Trending",
                       "People and blogs · Trending",
                       "Documentary · Trending",
                       "Gaming · Trending",
                       "Kids · Trending",
                       "Music · Trending",
                       "Film and Animation · Trending",
                       "Travel · Trending",
                       "Comedy · Trending",
                       "News · Trending",
                       "International education · Trending",
                       "Politics · Trending",
                       "Science · Trending",
                       "Technology · Trending",
                       "Nonprofits · Trending",
                       "NGO · Trending"]
    
    let arrTrendingHashTag = ["#ActionScene",
                              "#CricketWorldCup",
                              "#FutureOfVehicle",
                              "#DigitalEra",
                              "#ArtificialIntelligence",
                              "#TodayMarketDown",
                              "#IndieCulture",
                              "#CanadianCitizenship",
                              "#ShonOniPhone",
                              "#FavouriteTvShow",
                              "#DailyVlogs",
                              "#OneEarthOnNetflix",
                              "#PUBGonSmartphone",
                              "#FavouriteToys",
                              "#BollywoodMusic",
                              "#VFXandGraphics",
                              "#JournetOfTheYear",
                              "#KapilSharmaShow",
                              "#AmericatheSuperPower",
                              "#CanadianStudents",
                              "#DirtyPolitics",
                              "#InventionOfTheDecade",
                              "#AirChargingWithoutCable",
                              "#YearOFNonprofits",
                              "#ISupportNGO"]
    
    let arrCountPost = ["10.2K posts",
                        "22.4K posts",
                        "1.2K posts",
                        "2.3K posts",
                        "52.2K posts",
                        "70.8K posts",
                        "11.5K posts",
                        "50.5K posts",
                        "43.2K posts",
                        "60.6K posts",
                        "45.3K posts",
                        "10.2K posts",
                        "30.3K posts",
                        "50.5K posts",
                        "40.4K posts",
                        "10.2K posts",
                        "88.8K posts",
                        "99.2K posts",
                        "46.6K posts",
                        "67.7K posts",
                        "70.2K posts",
                        "90.9K posts",
                        "26.2K posts",
                        "25.2K posts",
                        "66.2K posts",]

    
    //MARK: -  ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Trending"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
     
        tblSearch.showsVerticalScrollIndicator = false
        tblSearch.showsHorizontalScrollIndicator = false
    }
     
    
    //MARK: -  UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TVC_SEARCH, for: indexPath) as? SearchTVC else { return UITableViewCell()}
        
        cell.lblCategory.text = arrCategory[indexPath.row]
        cell.lblTrendingHashTag.text = arrTrendingHashTag[indexPath.row]
        cell.lblCountPost.text = arrCountPost[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: Constants.STORYBOARD_HOME, bundle: nil)
        guard let nextVC = storyBoard.instantiateViewController(withIdentifier: Constants.VC_COMPOSE_TWEET) as? ComposeTweetVC else { return }
        nextVC.modalPresentationStyle = .automatic
        nextVC.isModalInPresentation = false
        nextVC.trendingHashTagFromSearch = arrTrendingHashTag[indexPath.row]
        self.navigationController?.present(nextVC, animated: true, completion: nil)
        
    }
}

 
