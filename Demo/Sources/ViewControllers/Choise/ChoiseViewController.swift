//
//  Globus
//

import Globus

class ChoiseViewController: GLBViewController {
    
    // MARK: - Outlet property
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private property
    
    var data: Array< ChoiseViewModel > = [
        ChoiseControllerViewModel< LabelViewController >.init(title:"Label"),
        ChoiseControllerViewModel< ButtonViewController >.init(title:"Button"),
        ChoiseControllerViewModel< ButtonImageViewController >.init(title:"Button & Image"),
        ChoiseControllerViewModel< ButtonBadgeViewController >.init(title:"Button & Badge"),
        ChoiseControllerViewModel< ImageViewController >.init(title:"Image")
    ]
    
    //MARK: - UIViewController
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.glb_registerCell(ChoiseCellTableViewCell.self)
    }
    
    //MARK: - GLBNibExtension
    
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
        let viewModel = self.data[indexPath.row]
        if let vc = viewModel.instantiateViewController() {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let choiseCell = cell as? ChoiseCellTableViewCell {
            let viewModel = self.data[indexPath.row]
            choiseCell.configure(viewModel: viewModel)
        }
    }
    
}
