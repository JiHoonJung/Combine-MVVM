//
//  MainViewController.swift
//  Combine_Test
//
//  Created by 정지훈 on 2022/06/16.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: RandomUserViewModel
    
    private(set) var data: [RandomUser]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var subscription = Set<AnyCancellable>()
    
    init?(coder: NSCoder, viewModel: RandomUserViewModel) {
        print(#function)
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.fetchRandomUser()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.$randomUsers.sink { [weak self] data in
            self?.data = data
        }
        .store(in: &subscription)
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RandomUserCell", for: indexPath) as! RandomUserTableViewCell
        
        let randomUser = data![indexPath.row]
        cell.bindRandomUser(randomUser: randomUser)
        
        return cell
    }
    
}
