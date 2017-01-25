//
//  Globus
//

import Globus

class ChoiseViewController: GLBViewController {
    
    // MARK: - Outlet property
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK: - Private property
    
    var data: Array< ChoiseViewModel > = [
        ChoiseControllerViewModel< MainViewController >.init(title:"Main"),
        ChoiseControllerViewModel< LabelViewController >.init(title:"Label"),
        ChoiseControllerViewModel< ButtonViewController >.init(title:"Button"),
        ChoiseControllerViewModel< ButtonImageViewController >.init(title:"Button & Image"),
        ChoiseControllerViewModel< ButtonBadgeViewController >.init(title:"Button & Badge"),
        ChoiseControllerViewModel< ImageViewController >.init(title:"Image"),
        ChoiseControllerViewModel< ImagePickerCropViewController >.init(title:"Image picker & crop"),
        ChoiseControllerViewModel< TextFieldViewController >.init(title:"Text field"),
        ChoiseControllerViewModel< DateFieldViewController >.init(title:"Date field"),
        ChoiseControllerViewModel< ListFieldViewController >.init(title:"List field"),
        ChoiseControllerViewModel< PhoneFieldViewController >.init(title:"Phone field"),
        ChoiseControllerViewModel< TextViewController >.init(title:"Text view"),
        ChoiseControllerViewModel< SpinnerViewController >.init(title:"Spinner view"),
        ChoiseControllerViewModel< ActivityViewController >.init(title:"Activity view"),
        ChoiseControllerViewModel< ScrollViewController >.init(title:"ScrollView"),
        ChoiseControllerViewModel< TransitionRootViewController >.init(title:"Transition"),
        ChoiseControllerViewModel< PageControlViewController >.init(title:"PageControl"),
        ChoiseControllerViewModel< NotificationsViewController >.init(title:"Notifications"),
        ChoiseControllerViewModel< DialogRootViewController >.init(title:"Dialog"),
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
