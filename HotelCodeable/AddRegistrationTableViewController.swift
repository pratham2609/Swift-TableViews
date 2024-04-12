
import UIKit

class AddRegistrationTableViewController: UITableViewController, RoomTypeTableViewControllerDelegate {
    
    // 1st section Text Fields
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkoutDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkoutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    //    @IBOutlet weak var
    
    let checkinDateLabelIndexPath = IndexPath(row: 0, section: 1)
    let checkinDatePickerIndexPath = IndexPath(row: 1, section: 1)
    let checkoutDateLabelIndexPath = IndexPath(row: 2, section: 1)
    let checkoutDatePickerIndexPath = IndexPath(row: 3, section: 1)
    var roomType: RoomType?
    var isCheckinDatePickerAvailable : Bool = false{
        didSet{
            checkInDatePicker.isHidden = !isCheckinDatePickerAvailable
        }
    }
    var isCheckoutDatePickerAvailable: Bool = false{
        didSet{
            checkoutDatePicker.isHidden = !isCheckoutDatePickerAvailable
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let midnight = Date()
        let today = Calendar.current.startOfDay(for: midnight)
        
        checkInDatePicker.minimumDate = today
        updateViews()
        updateCount()
        updateRoomType()
    }
    
    
    @IBAction func handleDone(_ sender: UIBarButtonItem) {
        if firstNameTF.text == ""{
            let alertController = UIAlertController(title: "Error", message: "Please enter your First Name", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
                                             
            self.present(alertController, animated: true, completion: nil)
            return
        }
        guard let lastName = lastNameTF.text else{
            return
        }
        guard let email = emailTF.text else{
            return
        }
        
        print(firstNameTF.text ?? "",lastName,email)
    }
    
    func updateViews(){
        let checkoutDate = Calendar.current.date(byAdding: .day,value:1, to: checkInDatePicker.date)
        checkoutDatePicker.minimumDate = checkoutDate
        checkInDateLabel.text = checkInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        checkoutDateLabel.text = checkoutDatePicker.date.formatted(date:.abbreviated,time:.omitted)
        
    }
    
    func updateCount() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
        
    }

    @IBAction func handleDateChange(_ sender: UIDatePicker) {
        updateViews()
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        updateCount()
    }
    
    func updateRoomType(){
        if let roomType = roomType{
            roomTypeLabel.text = roomType.name
        } else{
            roomTypeLabel.text = "Not Set"
        }
    }
    func roomTypeTableViewController(_ controller: RoomTypeTableViewController, didSelect roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> RoomTypeTableViewController? {
        let roomTypeViewController = RoomTypeTableViewController(coder: coder)
        roomTypeViewController?.delegate = self
        roomTypeViewController?.roomType = roomType
        return roomTypeViewController
    }
    
    // MARK: TABLE VIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath == checkinDateLabelIndexPath && isCheckoutDatePickerAvailable == false){
            isCheckinDatePickerAvailable.toggle()
        }
        else if(indexPath == checkoutDateLabelIndexPath && isCheckinDatePickerAvailable == false){
            isCheckoutDatePickerAvailable.toggle()
        }
        else if(indexPath == checkinDateLabelIndexPath || indexPath == checkoutDateLabelIndexPath){
            isCheckinDatePickerAvailable.toggle()
            isCheckoutDatePickerAvailable.toggle()
        }
        else{
            return
        }
        tableView.beginUpdates()
        tableView.endUpdates()
//        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case checkinDatePickerIndexPath where isCheckinDatePickerAvailable == false:
            return 0
        case checkoutDatePickerIndexPath where isCheckoutDatePickerAvailable == false:
            return 0
        default :
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case checkinDatePickerIndexPath:
            return 190
        case checkoutDatePickerIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
}
