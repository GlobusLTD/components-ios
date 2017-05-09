//
//  Globus
//

import Globus

class ChoiseViewController: GLBViewController {
    
    // MARK: - Outlet property
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK: - Private property
    
    var data: Array< ChoiseViewModel > = [
        ChoiseControllerViewModel< MainViewController >(title:"Main"),
        ChoiseControllerViewModel< LabelViewController >(title:"Label"),
        ChoiseControllerViewModel< ButtonViewController >(title:"Button"),
        ChoiseControllerViewModel< ButtonImageViewController >(title:"Button & Image"),
        ChoiseControllerViewModel< ButtonBadgeViewController >(title:"Button & Badge"),
        ChoiseControllerViewModel< ImageViewController >(title:"Image"),
        ChoiseControllerViewModel< ImagePickerCropViewController >(title:"Image picker & crop"),
        ChoiseControllerViewModel< TextFieldViewController >(title:"Text field"),
        ChoiseControllerViewModel< DateFieldViewController >(title:"Date field"),
        ChoiseControllerViewModel< ListFieldViewController >(title:"List field"),
        ChoiseControllerViewModel< PhoneFieldViewController >(title:"Phone field"),
        ChoiseControllerViewModel< TextViewController >(title:"Text view"),
        ChoiseControllerViewModel< SpinnerViewController >(title:"Spinner view"),
        ChoiseControllerViewModel< ActivityViewController >(title:"Activity view"),
        ChoiseControllerViewModel< ScrollViewController >(title:"ScrollView"),
        ChoiseControllerViewModel< TransitionRootViewController >(title:"Transition"),
        ChoiseControllerViewModel< PageControlViewController >(title:"PageControl"),
        ChoiseControllerViewModel< NotificationsViewController >(title:"Notifications"),
        ChoiseControllerViewModel< DialogRootViewController >(title:"Dialog"),
        ChoiseControllerViewModel< ListDataViewController >(title:"ListDataView"),
        ChoiseControllerViewModel< SimpleDataViewController >(title:"SimpleDataView"),
        ChoiseControllerViewModel< CalendarDataViewController >(title:"CalendarDataView"),
    ]
    
    //MARK: - UIViewController
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.glb_registerCell(ChoiseCellTableViewCell.self)
    }
    
    // MARK: - GLBNibExtension
    
    public override static func nibName() -> String {
        return "ChoiseViewController-Swift"
    }
    
}

//MARK: - UITableViewDataSource

extension ChoiseViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.glb_dequeueReusableCell(ChoiseCellTableViewCell.self)!
    }
    
}

//MARK: - UITableViewDelegate

extension ChoiseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let svc = self.glb_slideViewController {
            if let nvc = svc.centerViewController as? UINavigationController {
                let viewModel = self.data[indexPath.row]
                if let vc = viewModel.instantiateViewController() {
                    nvc.setViewControllers([ vc ], animated: true)
                }
            }
            svc.hideLeftViewController(animated: true, complete: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let choiseCell = cell as? ChoiseCellTableViewCell {
            let viewModel = self.data[indexPath.row]
            choiseCell.configure(viewModel: viewModel)
        }
    }
    
}
