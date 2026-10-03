import UIKit

final class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var roleSegmentedControl: UISegmentedControl!
    @IBOutlet weak var joinButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Club Connect"

        configureInterface()
    }

    private func configureInterface() {
        titleLabel.text = "Campus Club Connect"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center

        subtitleLabel.text = "Discover your campus community"
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .darkGray
        subtitleLabel.textAlignment = .center

        logoImageView.backgroundColor = UIColor.systemGray6
        logoImageView.layer.cornerRadius = 12
        logoImageView.clipsToBounds = true
        logoImageView.contentMode = .scaleAspectFit

        nameTextField.placeholder = "Enter your name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.clearButtonMode = .whileEditing

        reminderSwitch.isOn = false

        roleSegmentedControl.setTitle("Member", forSegmentAt: 0)
        roleSegmentedControl.setTitle("Officer", forSegmentAt: 1)
        roleSegmentedControl.selectedSegmentIndex = 0

        joinButton.setTitle("Join the Club", for: .normal)
    }

    @IBAction func joinButtonTapped(_ sender: UIButton) {
        nameTextField.resignFirstResponder()

        performSegue(
            withIdentifier: "ShowConfirmationSegue",
            sender: self
        )
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowConfirmationSegue",
              let destination = segue.destination as? ConfirmationViewController else {
            return
        }

        let enteredName = nameTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        destination.studentName = enteredName.isEmpty ? "Club Member" : enteredName
        destination.wantsReminders = reminderSwitch.isOn
        destination.selectedRole =
            roleSegmentedControl.selectedSegmentIndex == 0
            ? "Member"
            : "Officer"
    }
}
