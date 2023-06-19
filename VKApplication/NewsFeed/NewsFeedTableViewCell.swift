//
//  NewsFeedTableViewCell.swift
//  VKApplication
//
//  Created by Дмитрий Пономарев on 17.06.2023.
//


import UIKit

final class NewsFeedTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var statusLike = false
    
    //MARK: - UI properties
    
    let userNameLabel = UILabel()
    let imageFeed = WebImageView()
    let dateLabel = UILabel()
    let userNameAndDateStackView = UIStackView()
    let descriptionLabel = UILabel()
    let bottomActionListStackView = UIStackView()
    let likeDislikeButton = UIButton()
    var numberOfLikes = UILabel()
    let commentButton = UIButton()
    var numberOfComments = UILabel()
    let shareButton = UIButton()
    var numberOfShares = UILabel()
    let seenStackView = UIStackView()
    let seenImageView = UIImageView()
    var numberOfSeen = UILabel()
        
    //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configureView(_ itemModel: CellItems) {
        dateLabel.text = itemModel.date
        descriptionLabel.text = itemModel.description
        numberOfLikes.text = itemModel.likes
        numberOfSeen.text = itemModel.seen
        numberOfComments.text = itemModel.comments
        numberOfShares.text = itemModel.shares
        imageFeed.set(imageUrl: itemModel.photo)
        userNameLabel.text = itemModel.name
    }
}

//MARK: - Private methods

private extension NewsFeedTableViewCell {
    
    //MARK: - setup UI
    
    func setup() {
        setupViews()
        addViews()
        makeConstraints()
    }
    
    //MARK: - addViews
    
    func addViews() {
        
        contentView.addSubview(imageFeed)
        contentView.addSubview(userNameAndDateStackView)
        userNameAndDateStackView.addArrangedSubview(userNameLabel)
        userNameAndDateStackView.addArrangedSubview(dateLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(bottomActionListStackView)
        bottomActionListStackView.addArrangedSubview(likeDislikeButton)
        bottomActionListStackView.addArrangedSubview(numberOfLikes)
        bottomActionListStackView.addArrangedSubview(commentButton)
        bottomActionListStackView.addArrangedSubview(numberOfComments)
        bottomActionListStackView.addArrangedSubview(shareButton)
        bottomActionListStackView.addArrangedSubview(numberOfShares)
        contentView.addSubview(seenStackView)
        seenStackView.addArrangedSubview(seenImageView)
        seenStackView.addArrangedSubview(numberOfSeen)
    }
    
    //MARK: - makeConstraints
    
    func makeConstraints() {
        imageFeed.snp.makeConstraints {
            $0.left.top.equalToSuperview().inset(20)
            $0.height.equalTo(userNameAndDateStackView).inset(10)
            $0.width.equalTo(imageFeed.snp.height)
        }
        userNameAndDateStackView.snp.makeConstraints {
            $0.top.equalTo(imageFeed)
            $0.left.equalTo(imageFeed.snp.right).offset(20)
            $0.bottom.equalTo(descriptionLabel.snp.top).inset(-50)
        }
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(bottomActionListStackView.snp.top).inset(-50)
        }
        bottomActionListStackView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(20)
        }
        seenStackView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - setupViews
    
    func setupViews() {
        userNameLabel.text = "Название группы/пользователя"
        
        imageFeed.backgroundColor = .blue
        
        dateLabel.text = "Дата"
        dateLabel.textColor = .gray
        
        userNameAndDateStackView.axis = .vertical
        userNameAndDateStackView.spacing = 5
        
        imageFeed.layer.cornerRadius = 12
        imageFeed.layer.masksToBounds = true
        
        descriptionLabel.text = "descriptiondescriptiondescriptiondescriptiondescriptiondescription"
        
        likeDislikeButton.setImage(UIImage(named: "hearts"), for: .normal)
        likeDislikeButton.addTarget(self, action: #selector(click), for: .touchUpInside)
        numberOfLikes.textColor = .gray
        
        commentButton.setImage(UIImage(named: "comment"), for: .normal)
        numberOfComments.textColor = .gray
        
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        numberOfShares.textColor = .gray
        
        bottomActionListStackView.axis = .horizontal
        bottomActionListStackView.spacing = 10
        bottomActionListStackView.distribution = .equalSpacing
        
        seenImageView.image = UIImage(named: "seen")
        numberOfSeen.text = "100"
        numberOfSeen.textColor = .gray
        
        seenStackView.axis = .horizontal
        seenStackView.spacing = 7
    }
    
    //MARK: - objc Methods

    @objc func click() {
        switch statusLike {
        case false:
            likeDislikeButton.setImage(UIImage(named: "likeheart"), for: .normal)
            statusLike = true
        case true:
            likeDislikeButton.setImage(UIImage(named: "hearts"), for: .normal)
            statusLike = false
        }
    }
}
