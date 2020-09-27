//
//  SelectionControl.swift
//  Productivity
//
//  Created by Diego on 6/22/20.
//  Copyright © 2020 Diego. All rights reserved.
//

import UIKit

@IBDesignable class SelectionControl: UIStackView {

    //MARK: Properties

    private var selectionButtons = [UIButton]()

    var selection = [false, false, false, false, false, false, false] {
        didSet {
            updateButtonSelectionStates()
        }
    }

    @IBInspectable var buttonSize: CGSize = CGSize(width: 36.0, height: 36.0) {
        didSet {
            setupButtons()
        }
    }

    @IBInspectable var buttonCount: Int = 7 {
        didSet {
            setupButtons()
        }
    }

    //MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    //MARK: Button Action

    @objc func selectionButtonTapped(button: UIButton) {
        guard let index = selectionButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the selectionButtons array: \(selectionButtons)")
        }

        // set the proper spot to be selected
        if selection[index]{
            selection[index] = false
        } else {
            selection[index] = true
        }
    }


    //MARK: Private Methods

    private func setupButtons() {

        // Clear any existing buttons
        for button in selectionButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        selectionButtons.removeAll()

        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledButton = UIImage(named: "footerIcon_Focus_filled", in: bundle, compatibleWith: self.traitCollection)
        let emptyButton = UIImage(named:"footerIcon_Focus_unfilled", in: bundle, compatibleWith: self.traitCollection)

        for _ in 0..<buttonCount {
            // Create the button
            let button = UIButton()

            // Set the button images
            button.setImage(emptyButton, for: .normal)
            button.setImage(filledButton, for: .selected)


            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true


            // Setup the button action
            button.addTarget(self, action: #selector(SelectionControl.selectionButtonTapped(button:)), for: .touchUpInside)

            // Add the button to the stack
            addArrangedSubview(button)

            // Add the new button to the selection button array
            selectionButtons.append(button)
        }

        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates(){
        var index = 0
        for button in selectionButtons {
            if selection[index] {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
            index = index + 1
        }
    }
}
