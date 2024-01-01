//
//  SearchVC.swift
//  TwitterHarsh
//
//  Created by My Mac Mini  
//

import UIKit

//MARK: -  UITableViewCell
class SearchTVC: UITableViewCell {
    
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBO
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
                 ene",
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
            
        super.viewDidLoad()
        
        self.navigationItem.title = "Trending"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
     
        tblSearch.showsVerticalScrollIndicator = false
        tblSearch.showsHorizontalScrollIndicator = false
    }
     
    
    //MARK: -  UITableViewDelegate, UITableViewDataSource
     SearchTVC else { return UITableViewCell()}
        
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
        guard let nextVC = storyBoard.instantiateViewController(withIdentifier:  
}

 
