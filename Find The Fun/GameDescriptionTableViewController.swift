import UIKit

class GameDescriptionTableViewController: UITableViewController {
    
    var gameDescription: Game
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: NibName.coverHDTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.coverHDTableViewCell)
        self.tableView.register(UINib(nibName: NibName.coverTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.coverTableViewCell)
        self.tableView.register(UINib(nibName: NibName.summaryTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.summaryTableViewCell)
        self.tableView.register(UINib(nibName: NibName.companyTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.companyTableViewCell)
        self.tableView.register(UINib(nibName: NibName.publishedTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.publishedTableViewCell)
        self.tableView.register(UINib(nibName: NibName.platformTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.platformTableViewCell)
        self.tableView.register(UINib(nibName: NibName.ratingTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.ratingTableViewCell)
        self.tableView.register(UINib(nibName: NibName.screenshotsTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.screenshotsTableViewCell)
        self.tableView.register(UINib(nibName: NibName.genreTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.genreTableViewCell)
        self.tableView.register(UINib(nibName: NibName.gameModesTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.gameModesTableViewCell)
        self.tableView.register(UINib(nibName: NibName.relatedInDescriptionTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.relatedInDescriptionTableViewCell)
        self.tableView.register(UINib(nibName: NibName.videosTableViewCell, bundle: nil), forCellReuseIdentifier: Identifier.videosTableViewCell)
        
        tableView.delegate = self
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(GameDescriptionTableViewController.saveFavourite(sender:)))
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(GameDescriptionTableViewController.removeFavourite(sender:)))
        
        if fetchGameFavourite(id: Int32(gameDescription.idGame)) {
            navigationItem.rightBarButtonItem = saveButton
        } else {
            navigationItem.rightBarButtonItem = trashButton
        }
        title = gameDescription.name
        tabBarController?.navigationController?.navigationBar.barTintColor = ColorUI.navBar
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName : UIColor.white]

        view.backgroundColor = ColorUI.backgoundTableView
        let viewFooter = UIView()
        viewFooter.backgroundColor = ColorUI.backgoundTableView
        self.tableView.tableFooterView = viewFooter
        self.view.backgroundColor = ColorUI.backgoundTableView
    }
    
    required init(game: Game) {
        self.gameDescription = game
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameDescription.gameDescriptionFields.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRowInGameDescription(indexPath: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return gameDescription.gameDescriptionFields[indexPath.row](tableView, indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
        gameDescription.didSelectGame(tableView: tableView, indexPath: indexPath, navigationController: navController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
     func saveFavourite(sender: UIButton) {
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(GameDescriptionTableViewController.removeFavourite(sender:)))

        navigationItem.rightBarButtonItem = trashButton
        let cover = UIImageView()
        cover.af_setImage(
            withURL: getCover(url: gameDescription.cover?.url)!,
            placeholderImage: #imageLiteral(resourceName: "img-not-found"),
            filter: nil,
            progress: nil,
            progressQueue: DispatchQueue.main,
            imageTransition: UIImageView.ImageTransition.crossDissolve(0.1),
            runImageTransitionIfCached: true,
            completion: { _ in
                saveFavouriteGame(
                    game: self.gameDescription,
                    image: cover.image!)
        })
    }
    
    func removeFavourite(sender: UIButton) {
    let saveButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(GameDescriptionTableViewController.saveFavourite(sender:)))
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to delete \(gameDescription.name)", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            deleteFavouriteGame(id: Int32(self.gameDescription.idGame))
            self.navigationItem.rightBarButtonItem = saveButton
        }
        alertController.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        navigationController?.present(alertController, animated: true, completion: nil)
    }
    
}
