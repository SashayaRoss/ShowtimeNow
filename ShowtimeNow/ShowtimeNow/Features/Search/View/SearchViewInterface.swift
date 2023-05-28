//
//  SearchViewInterface.swift
//  ShowtimeNow
//
//  Created by Aleksandra Kustra on 28/05/2023.
//

import UIKit

protocol SearchViewInterface: UIView {
    var tableView: UITableView { get }
    var errorMessage: UILabel { get }
}
