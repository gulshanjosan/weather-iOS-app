import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTempLabel: UILabel!
    @IBAction func getDataButtonClicked(sender: AnyObject) {
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=" + cityNameTextField.text! + "us&APPID=4b9f5572bc761b3f1b35c291f43b46b2")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=Ottawa,ca" + "us&APPID=4b9f5572bc761b3f1b35c291f43b46b2")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeatherData(urlString: String) {
        let url = NSURL(string: urlString)
        
        //print("This: " + urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                self.setLabels(data!)
            })
        }
        task.resume()
    }
    
    
    func setLabels(weatherData: NSData) {
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(weatherData, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
            print(json)
            
            //cityNameLabel.text = json[("name")] as? String
            if let name = json[("name")] as? String {
                cityNameLabel.text = name
            }
            
            if let main = json[("main")] as? NSDictionary {
                if let temp = main[("temp")] as? Int {
                    //convert kelvin to celcius
                    let cl = temp - 273
                    let myString = cl.description
                    
                    //let a:Int? = Int(myString)
                    
                    cityTempLabel.text = "\(myString)" + " Degree Celsius"
                    
                }
            }
            
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
}